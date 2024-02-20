###############################################################################
# Private functionality
###############################################################################

DeclareOperation("GV_StringifyGraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifyDigraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifyGraphEdge", [IsGVEdge]);
DeclareOperation("GV_StringifyDigraphEdge", [IsGVEdge]);
DeclareOperation("GV_StringifySubgraph", [IsString]);
DeclareOperation("GV_StringifyPlainSubgraph", [IsString]);
DeclareOperation("GV_StringifyNode", [IsGVNode]);
DeclareOperation("GV_StringifyGraphAttrs", [IsGVGraph]);
DeclareOperation("GV_StringifyNodeEdgeAttrs", [IsHashMap]);

###############################################################################
# Family + type
###############################################################################

BindGlobal("GV_ObjectFamily",
           NewFamily("GV_ObjectFamily",
                     IsGVObject));

BindGlobal("GV_DigraphType", NewType(GV_ObjectFamily,
                                    IsGVDigraph and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GV_GraphType", NewType(GV_ObjectFamily,
                                    IsGVGraph and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GV_NodeType", NewType(GV_ObjectFamily,
                                    IsGVNode and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GV_EdgeType", NewType(GV_ObjectFamily,
                                    IsGVEdge and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

###############################################################################
# Constuctors etc
###############################################################################

# Node constructors
InstallMethod(GV_Node, "for a string", [IsString],
function(name)

  if Length(name) = 0 then
    return ErrorNoReturn("Node name cannot be empty.");
  fi;
  return Objectify(GV_NodeType, 
                  rec(
                    Name  := name,
                    Attrs := HashMap()                
                  ));
end);

# Edge constructors
InstallMethod(GV_Edge, "for two graphviz nodes", 
[IsGVNode, IsGVNode],
function(head, tail)
  return Objectify(GV_EdgeType, 
                rec(
                  Name  := "",
                  Head  := head,
                  Tail  := tail,
                  Attrs := HashMap()                
                ));
end);

InstallMethod(GV_Edge, "for two strings",
[IsString, IsString],
function(head_name, tail_name)
  local head, tail; 
  head := GV_Node(head_name);
  tail := GV_Node(tail_name);
  return GV_Edge(head, tail);
end);

# Graph constructors
InstallMethod(GV_Graph, "for a string", [IsString],
function(name)
  return Objectify(GV_GraphType,
                      rec(Name       := name,
                          Nodes      := HashMap(),
                          Edges      := [],
                          Attrs      := []));
end);

# Graph constructors
InstallMethod(GV_Digraph, "for a string", [IsString],
function(name)
  return Objectify(GV_DigraphType,
                      rec(Name       := name,
                          Nodes      := HashMap(),
                          Edges      := [],
                          Attrs      := []));
end);

InstallMethod(GV_Graph, "for no args", [], {} -> GV_Graph(""));
InstallMethod(GV_Digraph, "for no args", [], {} -> GV_Digraph(""));

############################################################
# Stringify
############################################################
InstallMethod(ViewString, "for a graphviz node", [IsGVNode], n -> StringFormatted("<node {}>", GV_Name(n)));
InstallMethod(ViewString, "for a graphviz edge", [IsGVEdge], 
function(e)
  local head, tail;
  head := GV_Head(e);
  tail := GV_Tail(e);
  return StringFormatted("<edge ({}, {})>", GV_Name(head), GV_Name(tail));
end);

InstallMethod(ViewString, "for a graphviz graph", [IsGVGraph], 
function(g)
  local result, edges, nodes;
  result := "";
  edges := Length(GV_Edges(g));
  nodes := Size(GV_Nodes(g));

  Append(result, StringFormatted("<graph ", GV_Name(g)));

  if GV_Name(g) <> "" then
    Append(result, StringFormatted("{} ", GV_Name(g)));
  fi;

  Append(result, StringFormatted("with {} ", Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", Pluralize(edges, "edge")));

  return result;
end);

InstallMethod(ViewString, "for a graphviz graph", [IsGVDigraph], 
function(g)
  local result, edges, nodes;
  result := "";
  edges := Length(GV_Edges(g));
  nodes := Size(GV_Nodes(g));

  Append(result, StringFormatted("<digraph ", GV_Name(g))); 

  if GV_Name(g) <> "" then
    Append(result, StringFormatted("{} ", GV_Name(g)));
  fi;

  Append(result, StringFormatted("with {} ", Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", Pluralize(edges, "edge")));

  return result;
end);

############################################################
# Getters
############################################################
InstallMethod(GV_Name, "for a graphviz object", [IsGVObject], x -> x!.Name);
InstallMethod(GV_Attrs, "for a graphviz object", [IsGVObject], x -> x!.Attrs);

InstallMethod(GV_Nodes, "for a graphviz graph", [IsGVGraph], x -> x!.Nodes);
InstallMethod(GV_Edges, "for a graphviz graph", [IsGVGraph], x -> x!.Edges);

InstallMethod(GV_Tail, "for a graphviz edge", [IsGVEdge], x -> x!.Tail);
InstallMethod(GV_Head, "for a graphviz edge", [IsGVEdge], x -> x!.Head);

InstallMethod(GV_HasNode, "for a graphviz graph", [IsGVGraph, IsString], 
function(g, name)
  return name in GV_Nodes(g);
end);

############################################################
# Setters
############################################################
InstallMethod(GV_SetName, "for a graphviz object and string",
[IsGVGraph, IsString], 
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GV_SetAttrs, "for a graphviz object and record",
[IsGVObject, IsRecord], 
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GV_SetAttr(x, name, attrs.(name));
  od;
  return x;
end);

InstallMethod(GV_SetAttrs, "for a graphviz object and record",
[IsGVGraph, IsRecord], 
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GV_SetAttr(x, name, attrs.(name));
  od;
  return x;
end);

InstallMethod(GV_SetAttr, "for a graphviz object, object and object",
[IsGVObject, IsObject, IsObject], 
function(x, name, value)
  GV_Attrs(x)[String(name)] := String(value);
  return x;
end);

InstallMethod(GV_SetAttr, "for a graphviz object, object and object",
[IsGVGraph, IsObject, IsObject], 
function(x, name, value)
  if name = "label" then
    Add(GV_Attrs(x), StringFormatted("{}={}", String(name), String(value)));
  else 
    Add(GV_Attrs(x), StringFormatted("{}=\"{}\"", String(name), String(value)));
  fi;

  return x;
end);

InstallMethod(GV_SetAttr, "for a graphviz object, object and object",
[IsGVGraph, IsObject], 
function(x, value)
  Add(GV_Attrs(x), String(value));
  return x;
end);

InstallMethod(\[\], 
"for a graphviz graph and string",
[IsGVGraph, IsString],
function(graph, node)
  return GV_Nodes(graph)[node];
end);

InstallMethod(GV_AddNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode], 
function(x, node)
  local name, nodes;
  name := GV_Name(node);
  nodes := GV_Nodes(x);

  # dont add if already node with the same name
  if GV_HasNode(x, name) then
    return ErrorNoReturn(StringFormatted("Already node with name {}.", name));
  fi;

  nodes[name] := node;
  return x;
end);

InstallMethod(GV_AddNode, "for a graphviz graph and string",
[IsGVGraph, IsString], 
function(x, name)
  local node, nodes;
  node := GV_Node(name);
  GV_AddNode(x, node);
  return node;
end);

InstallMethod(GV_AddEdge, "for a graphviz graph and edge",
[IsGVGraph, IsGVEdge], 
function(x, edge)
  local help, o;
  help := function(node)
    local gn, name;
    name := GV_Name(node); 
    if not GV_HasNode(x, name) then
      GV_AddNode(x, node);
      return true;
    fi;

    gn := GV_Nodes(x)[name];
    if not IsIdenticalObj(gn, node) then
      return false;
    fi;
    return true;
  end;

  o := help(GV_Head(edge));
  if not o then 
    return ErrorNoReturn(StringFormatted("Different node in graph with name {}.", GV_Name(GV_Head(edge))));
  fi;

  o := help(GV_Tail(edge));
  if not o then 
    GV_RemoveNode(x, GV_Head(edge)); # cleanup :)
    return ErrorNoReturn(StringFormatted("Different node in graph with name {}.", GV_Name(GV_Tail(edge))));
  fi;

  InsertElmList(x!.Edges, 1, edge);
  return x;
end);

InstallMethod(GV_AddEdge, 
"for a graphviz graph and two graphviz nodes", 
[IsGVGraph, IsGVNode, IsGVNode],
function(x, head, tail)
  local edge;
  edge := GV_Edge(head, tail);
  GV_AddEdge(x, edge);
  return edge;
end);

InstallMethod(GV_AddEdge, 
"for a graphviz graph and two strings", 
[IsGVGraph, IsString, IsString],
function(x, head, tail)
  local edge, head_node, tail_node;

  # try to get existing nodes
  head_node := x[head];
  tail_node := x[tail];

  # if dont exist make new ones
  if head_node = fail then
    head_node := GV_Node(head);
  fi;
  if tail_node = fail then
    tail_node := GV_Node(tail);
  fi;

  # add to graph
  edge := GV_Edge(head_node, tail_node);
  GV_AddEdge(x, edge);
  return edge;
end);

InstallMethod(GV_RemoveNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode],
function(g, n)
  local nodes, name, out;
  nodes := GV_Nodes(g);
  name := GV_Name(n);
  Unbind(nodes[name]);

  GV_FilterEdges(g, 
    function(e)
      local head, tail;
      head := GV_Head(e);
      tail := GV_Tail(e);
      return name <> GV_Name(tail) and name <> GV_Name(head); 
    end);

  return g;
end); 

InstallMethod(GV_RemoveNode, "for a graphviz graph and a string",
[IsGVGraph, IsString],
function(g, name)
  local nodes, out;
  nodes := GV_Nodes(g);
  Unbind(nodes[name]);

  GV_FilterEdges(g, 
    function(e)
      local head, tail;
      head := GV_Head(e);
      tail := GV_Tail(e);
      return name <> GV_Name(tail) and name <> GV_Name(head); 
    end);

  return g;
end); 

InstallMethod(GV_FilterEdges, "for a graphviz graph and edge filter",
[IsGVGraph, IsFunction],
function(g, filter)
  g!.Edges := Filtered(GV_Edges(g), filter);
  return g;
end);

InstallMethod(GV_FilterEnds, "for a graphviz graph and two strings",
[IsGVGraph, IsString, IsString],
function(g, hn, tn)
  g!.Edges := Filtered(GV_Edges(g), 
    function(e)
      local head, tail;
      head := GV_Head(e);
      tail := GV_Tail(e);
      if IsGVDigraph(g) then
        return tn <> GV_Name(tail) or hn <> GV_Name(head); 
      else 
        return (tn <> GV_Name(tail) or hn <> GV_Name(head)) and (hn <> GV_Name(tail) or tn <> GV_Name(head)); 
      fi; 
    end);
  return g;
end);

InstallMethod(GV_RemoveAttr, "for a graphviz object and an object", 
[IsGVObject, IsObject],
function(obj, attr)
  local attrs;
  attrs := GV_Attrs(obj);
  Unbind(attrs[String(attr)]);
  return obj;
end);

InstallMethod(GV_RemoveAttr, "for a graphviz graph and an object", 
[IsGVGraph, IsObject],
function(obj, attr)
  local attrs;
  attrs := GV_Attrs(obj);
  obj!.Attrs := Filtered(attrs, item -> item[1] <> String(attr));
  return obj;
end);

###############################################################################
# Stringifying
###############################################################################

#@ Return DOT graph head line.
InstallMethod(GV_StringifyGraphHead, "for a string", [IsGVGraph],
function(graph)
  return StringFormatted("graph {} {{\n", GV_Name(graph));
end);

#@ Return DOT digraph head line.
InstallMethod(GV_StringifyDigraphHead, "for a string", [IsGVGraph],
function(graph)
  return StringFormatted("digraph {} {{\n", GV_Name(graph));
end);

#@ Return DOT node statement line.
InstallMethod(GV_StringifyNode, "for string and record",
[IsGVNode],
function(node)
  local attrs, name, split;
  
  name := GV_Name(node);
  attrs := GV_Attrs(node);
  if ':' in name then
    split := SplitString(name, ":");
    name := StringFormatted("\"{}\":{}", split[1], split[2]);
  else
    name := StringFormatted("\"{}\"", name);
  fi;

  return StringFormatted("\t{}{}\n", name, GV_StringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT graph edge statement line.
InstallMethod(GV_StringifyGraphEdge, "for a graphviz edge",
[IsGVEdge],
function(edge)
  local head, split, tail, attrs;
  head := GV_Name(GV_Head(edge));
  tail := GV_Name(GV_Tail(edge));
  attrs := GV_Attrs(edge);

  # handle : syntax
  if ':' in head then
    split := SplitString(head, ':');
    head := StringFormatted("\"{}\":{}", split[1], split[2]);
  else 
    head := StringFormatted("\"{}\"", head);
  fi;
  if ':' in tail then
    split := SplitString(tail, ':');
    tail := StringFormatted("\"{}\":{}", split[1], split[2]);
  else 
    tail := StringFormatted("\"{}\"", tail);
  fi;

  return StringFormatted("\t{} -- {}{}\n",
                         tail,
                         head,
                         GV_StringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT digraph edge statement line.
InstallMethod(GV_StringifyDigraphEdge, "for a graphviz edge",
[IsGVEdge],
function(edge)
  local head, tail, attrs;
  head := GV_Name(GV_Head(edge));
  tail := GV_Name(GV_Tail(edge));
  attrs := GV_Attrs(edge);

  # handle : syntax
  if ':' in head then
    split := SplitString(head, ':');
    head := StringFormatted("\"{}\":{}", split[1], split[2]);
  else 
    head := StringFormatted("\"{}\"", head);
  fi;
  if ':' in tail then
    split := SplitString(tail, ':');
    tail := StringFormatted("\"{}\":{}", split[1], split[2]);
  else 
    tail := StringFormatted("\"{}\"", tail);
  fi;

  return StringFormatted("\t{} -> {}{}\n",
                         tail,
                         head,
                         GV_StringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT subgraph head line.
InstallMethod(GV_StringifySubgraph, "for a string",
[IsString],
function(name)
  return StringFormatted("subgraph {}{{\n", name);
end);

#@ Return plain DOT subgraph head line.
InstallMethod(GV_StringifyPlainSubgraph, "for a string",
[IsString],
function(name)
  return StringFormatted("{}{{\n", name);
end);

InstallMethod(GV_StringifyGraphAttrs, "for a graphviz graph", [IsGVGraph],
function(graph)
  local result, attrs, kv, i;
  attrs := GV_Attrs(graph);
  result := "";

  if Size(attrs) <> 0 then
    Append(result, "\t");
    for kv in attrs do
      Append(result,
             StringFormatted("{} ", kv));
    od;
    Append(result, "\n");
  fi;
  return result;
end);

InstallMethod(GV_StringifyNodeEdgeAttrs, "for a record", [IsHashMap],
function(attrs)
  local result, keys, key, n, i;

  result := "";
  n := Size(attrs);
  keys := SSortedList(Keys(attrs));

  if n <> 0 then
    Append(result, " [");
    for i in [1..n-1] do
        key := keys[i];
        if key = "label" then
          Append(result,
                StringFormatted("{}={}, ",
                                key,
                                attrs[key]));
        else 
          Append(result,
                StringFormatted("{}=\"{}\", ",
                                key,
                                attrs[key]));
        fi;
    od;

    key := keys[n];
    if key = "label" then
      Append(result,
            StringFormatted("{}={}]",
                            key,
                            attrs[key]));
    else 
      Append(result,
            StringFormatted("{}=\"{}\"]",
                            key,
                            attrs[key]));
    fi;
  fi;
  return result;
end);

InstallMethod(GV_String, "for a graphviz graph",
[IsGVGraph],
function(graph)
  local result, nodes, edges, keys, elem, i;
  nodes := GV_Nodes(graph);
  edges := GV_Edges(graph);
  
  result := "";

  if IsGVDigraph(graph) then
    Append(result, GV_StringifyDigraphHead(graph));
  else
    Append(result, GV_StringifyGraphHead(graph));
  fi;

  Append(result, GV_StringifyGraphAttrs(graph));

  for elem in SSortedList(Keys(nodes)) do
    Append(result, GV_StringifyNode(nodes[elem]));
  od;

  for elem in edges do
    if IsGVDigraph(graph) then
      Append(result, GV_StringifyDigraphEdge(elem));
    else
      Append(result, GV_StringifyGraphEdge(elem));
    fi;
  od;

  Append(result, "}\n");
  return result;
end);


