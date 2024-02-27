###############################################################################
# Private functionality
###############################################################################

DeclareOperation("GV_GetCounter", [IsGVGraph]);
DeclareOperation("GV_IncCounter", [IsGVGraph]);

DeclareOperation("GV_StringifyGraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifyDigraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifySubgraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifyContextHead", [IsGVGraph]);
DeclareOperation("GV_StringifyGraphEdge", [IsGVEdge]);
DeclareOperation("GV_StringifyDigraphEdge", [IsGVEdge]);
DeclareOperation("GV_StringifyNode", [IsGVNode]);
DeclareOperation("GV_StringifyGraphAttrs", [IsGVGraph]);
DeclareOperation("GV_StringifyNodeEdgeAttrs", [IsHashMap]);
DeclareOperation("GV_StringifyGraph", [IsGVGraph, IsBool]);

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

BindGlobal("GV_ContextType", NewType(GV_ObjectFamily,
                                    IsGVContext and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

###############################################################################
# Constuctors etc
###############################################################################
DeclareOperation("GV_Node", [IsGVGraph, IsString]);
DeclareOperation("GV_Edge", [IsGVGraph, IsGVNode, IsGVNode]);
DeclareOperation("GV_Graph", [IsGVGraph, IsString]);
DeclareOperation("GV_Digraph", [IsGVDigraph, IsString]);
DeclareOperation("GV_Context", [IsGVGraph, IsString]);

InstallMethod(GV_Node, 
"for a string", 
[IsGVGraph, IsString],
function(graph, name)
  local out;
  if Length(name) = 0 then
    return ErrorNoReturn("Node name cannot be empty.");
  fi;
  out := Objectify(GV_NodeType, 
                  rec(
                    Name  := name,
                    Attrs := HashMap(),
                    Idx   := GV_GetCounter(graph)                
                  ));
  GV_IncCounter(graph);
  return out;
end);

InstallMethod(GV_Edge, "for two graphviz nodes", 
[IsGVGraph, IsGVNode, IsGVNode],
function(graph, head, tail)
  local out;
  out :=  Objectify(GV_EdgeType, 
                rec(
                  Name  := "",
                  Head  := head,
                  Tail  := tail,
                  Attrs := HashMap(),
                  Idx   := GV_GetCounter(graph)                
                ));
  GV_IncCounter(graph);
  return out;
end);

# Graph constructors

InstallMethod(GV_Digraph, 
"for a graphviz digraph and a string", 
[IsGVDigraph, IsString],
function(parent, name)
  local out;

  out := GV_Digraph(name);
  out!.Parent := parent;
  out!.Idx := GV_GetCounter(parent);
  
  GV_IncCounter(parent);
  return out;
end);

InstallMethod(GV_Graph, 
"for a graphviz graph and a string", 
[IsGVGraph, IsString],
function(parent, name)
  local out;

  out := GV_Graph(name);
  out!.Parent := parent;
  out!.Idx := GV_GetCounter(parent);
  
  GV_IncCounter(parent);
  return out;
end);

InstallMethod(GV_Context, 
"for a string and a positive integer", 
[IsGVGraph, IsString],
function(parent, name)
  local out;

  out := Objectify(GV_ContextType,
                      rec(
                        Name      := name,
                        Subgraphs := HashMap(),
                        Nodes     := HashMap(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := parent,
                        Idx       := GV_GetCounter(parent),               
                        Counter   := 1
                      ));
  
  GV_IncCounter(parent);
  return out;
end);

# public constructors


InstallMethod(GV_Graph, 
"for a string and a positive integer", 
[IsString],
function(name)
  return Objectify(GV_GraphType,
                      rec(
                        Name      := name,
                        Subgraphs := HashMap(),
                        Nodes     := HashMap(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := fail,
                        Idx       := 1,               
                        Counter   := 1
                      ));
end);

InstallMethod(GV_Digraph, 
"for a string", 
[IsString],
function(name)
  return Objectify(GV_DigraphType,
                      rec(
                        Name      := name,
                        Subgraphs := HashMap(),
                        Nodes     := HashMap(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := fail,
                        Idx       := 1,
                        Counter   := 1
                      ));
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

InstallMethod(ViewString, "for a graphviz digraph", [IsGVDigraph], 
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

InstallMethod(ViewString, "for a graphviz context", [IsGVContext], 
function(g)
  local result, edges, nodes;
  result := "";
  edges := Length(GV_Edges(g));
  nodes := Size(GV_Nodes(g));

  Append(result, StringFormatted("<context ", GV_Name(g))); 

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
InstallMethod(GV_Subgraphs, "for a graphviz graph", [IsGVGraph], x -> x!.Subgraphs);
InstallMethod(GV_GetSubgraph, 
"for a graphviz graph and string", 
[IsGVGraph, IsString], 
{x, name} -> GV_Subgraphs(x)[name]);

InstallMethod(GV_IncCounter, 
"for a graphviz graph",
[IsGVGraph], 
function(x) 
  x!.Counter := x!.Counter + 1;
end);

InstallMethod(GV_GetCounter, 
"for a graphviz graph",
[IsGVGraph], 
x -> x!.Counter);

InstallMethod(GV_HasNode, 
"for a graphviz graph", 
[IsGVGraph, IsString], 
function(g, name)
  return name in Keys(GV_Nodes(g));
end);

DeclareOperation("GV_GetParent", [IsGVGraph]);
InstallMethod(GV_GetParent, 
"for a graphviz graph", 
[IsGVGraph],
function(graph)
  return graph!.Parent;
end);

InstallMethod(GV_FindNodeS, 
"for a graphviz graph and a string",
[IsGVGraph, IsString],
function(graph, name)
  local node_name, subgraph, seen, to_visit, parent, g;
  seen := [graph];
  to_visit := [graph];

  while Length(to_visit) > 0 do
    g := Remove(to_visit, Length(to_visit));

    # look for node in this graph
    for node_name in Keys(GV_Nodes(g)) do
      if node_name = name then
        return g[node_name];
      fi;
    od;

    # add subgraphs to list of to visit if not visited
    for subgraph in Values(GV_Subgraphs(g)) do
      if not ForAny(seen, s -> IsIdenticalObj(s, subgraph)) then
        Add(seen, subgraph);
        Add(to_visit, subgraph);
      fi;
    od;
    
    # add parent if not visited
    parent := GV_GetParent(g);
    if not IsGVGraph(parent) then
      continue;
    fi;
    if not ForAny(seen, s -> IsIdenticalObj(s, parent)) then
      Add(seen, parent);
      Add(to_visit, parent);
    fi;
  od;

  return fail;
end);

DeclareOperation("GV_HasParent", [IsGVGraph]);
InstallMethod(GV_HasParent, 
"for a graphviz graph", 
[IsGVGraph],
function(graph)
  return GV_GetParent(graph) <> fail; 
end);

DeclareOperation("GV_FindNode", [IsGVGraph, IsString]);
InstallMethod(GV_FindNode, 
"for a graphviz graph and a string", 
[IsGVGraph, IsString],
function(graph, name)
  local elem, node;
  if GV_HasNode(graph, name) then
    return graph[name];
  fi;

  for elem in Values(GV_Subgraphs(graph)) do
    node := GV_FindNode(elem, name);
    if node <> fail then
      return node;
    fi;
  od;

  return fail;
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

InstallMethod(GV_SetAttr, "for a graphviz object, object and object",
[IsGVObject, IsObject, IsObject], 
function(x, name, value)
  GV_Attrs(x)[String(name)] := String(value);
  return x;
end);

InstallMethod(GV_SetAttr, "for a graphviz graph, object and object",
[IsGVGraph, IsObject, IsObject], 
function(x, name, value)
  local attrs, string;
  
  attrs := GV_Attrs(x);
  if name = "label" then
    string := StringFormatted("{}={}", String(name), String(value));
  else 
    string := StringFormatted("{}=\"{}\"", String(name), String(value));
  fi;

  Add(attrs, string);
  return x;
end);

InstallMethod(GV_SetAttr, "for a graphviz object, object and object",
[IsGVGraph, IsObject], 
function(x, value)
  local attrs;
  attrs := GV_Attrs(x);

  Add(attrs, String(value));
  return x;
end);

InstallMethod(\[\], 
"for a graphviz graph and string",
[IsGVGraph, IsString],
function(graph, node)
  return GV_Nodes(graph)[node];
end);

InstallMethod(GV_AddNode, 
"for a graphviz graph and node",
[IsGVGraph, IsGVNode], 
function(x, node)
  local found, name, nodes, parent;
  name := GV_Name(node);
  nodes := GV_Nodes(x);

  # dont add if already node with the same name
  found := GV_FindNodeS(x, name);
  if found <> fail then
    return ErrorNoReturn(StringFormatted("Already node with name {}.", name));
  fi;

  nodes[name] := node;
  return x;
end);

InstallMethod(GV_AddNode, "for a graphviz graph and string",
[IsGVGraph, IsString], 
function(x, name)
  local node;
  node := GV_Node(x, name);
  GV_AddNode(x, node);
  return node;
end);

DeclareOperation("GV_AddEdge", [IsGVGraph, IsGVEdge]);
InstallMethod(GV_AddEdge, 
"for a graphviz graph and edge",
[IsGVGraph, IsGVEdge], 
function(x, edge)
  local head_curr, tail_curr, head, head_name, tail_name, tail;

  head := GV_Head(edge);
  tail := GV_Tail(edge);
  head_name := GV_Name(head);
  tail_name := GV_Name(tail);
  head_curr := GV_FindNodeS(x, head_name);
  tail_curr := GV_FindNodeS(x, tail_name);

  # if not already existing, add the nodes to the graph
  if head_curr = fail then
    GV_AddNode(x, head);
  fi;
  if tail_curr = fail then
    GV_AddNode(x, tail);
  fi;

  # make sure the nodes exist / are the same as existing ones
  if head_curr <> fail and not IsIdenticalObj(head, head_curr) then
    return ErrorNoReturn(StringFormatted("Different node in graph with name {}.", head_name));
  fi;
  if tail_curr <> fail and not IsIdenticalObj(tail, tail_curr) then
    return ErrorNoReturn(StringFormatted("Different node in graph with name {}.", tail_name));
  fi;

  Add(x!.Edges, edge);
  return x;
end);

InstallMethod(GV_AddEdge, 
"for a graphviz graph and two graphviz nodes", 
[IsGVGraph, IsGVNode, IsGVNode],
function(x, head, tail)
  local edge, head_name, tail_name;

  head_name := GV_Name(head);
  tail_name := GV_Name(tail);

  # add the nodes to the graph if not present
  if GV_FindNodeS(x, head_name) = fail then
    GV_AddNode(x, head);
  fi;
  if GV_FindNodeS(x, tail_name) = fail then
    GV_AddNode(x, tail);
  fi;

  edge := GV_Edge(x, head, tail);
  GV_AddEdge(x, edge);
  return edge;
end);

InstallMethod(GV_AddEdge, 
"for a graphviz graph and two strings", 
[IsGVGraph, IsString, IsString],
function(x, head, tail)
  local head_node, tail_node;

  head_node := GV_FindNodeS(x, head);
  if head_node = fail then
    head_node := GV_Node(x, head);
  fi;

  tail_node := GV_FindNodeS(x, tail);
  if tail_node = fail then
    tail_node := GV_Node(x, tail);
  fi;

  return GV_AddEdge(x, head_node, tail_node);
end);

InstallMethod(GV_AddSubgraph, 
"for a graphviz graph and string",
[IsGVGraph, IsString],
function(graph, name)
  local subgraphs, subgraph;

  subgraphs := GV_Subgraphs(graph);
  if IsBound(subgraphs[name]) then
    return ErrorNoReturn(StringFormatted("The graph already contains a subgraph with name {}.",
                        name));
  fi;

  if IsGVDigraph(graph) then
    subgraph := GV_Digraph(graph, name);
  elif IsGVGraph(graph) then
    subgraph := GV_Graph(graph, name);
  else
    return ErrorNoReturn("Filter must be a filter for a graph category.");
  fi;

  subgraphs[name] := subgraph;
  return subgraph;
end);

InstallMethod(GV_AddSubgraph, 
"for a grpahviz graph",
[IsGVGraph],
function(graph)
  local name;
  return GV_AddSubgraph(graph, StringFormatted("no_name_{}", 
                                               String(GV_GetCounter(graph))));
end);

InstallMethod(GV_AddContext, 
"for a graphviz graph and a string",
[IsGVGraph, IsString],
function(graph, name)
  local ctx, subgraphs;

  subgraphs := GV_Subgraphs(graph);
  if IsBound(subgraphs[name]) then
    return ErrorNoReturn(StringFormatted("The graph already contains a subgraph with name {}.",
                                         name));
  fi;

  ctx := GV_Context(graph, name);
  subgraphs[name] := ctx;
  return ctx;
end);

InstallMethod(GV_AddContext, 
"for a graphviz graph",
[IsGVGraph],
g -> GV_AddContext(g, StringFormatted("no_name_{}", 
                                      String(GV_GetCounter(g)))));

InstallMethod(GV_RemoveNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode],
function(g, node)
  return GV_RemoveNode(g, GV_Name(node));
end); 

InstallMethod(GV_RemoveNode, "for a graphviz graph and a string",
[IsGVGraph, IsString],
function(g, name)
  local nodes, out;
  nodes := GV_Nodes(g);
  Unbind(nodes[name]);

  # remove incident edges
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
  local edge, idx, edges;

  edges := GV_Edges(g);
  idx := Length(edges);
  while idx > 0 do
    edge := edges[idx];
    if not filter(edge) then
      Remove(edges, idx);
    fi;
    idx := idx - 1;
  od;

  return g;
end);

InstallMethod(GV_FilterEnds, "for a graphviz graph and two strings",
[IsGVGraph, IsString, IsString],
function(g, hn, tn)
  GV_FilterEdges(g,
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
InstallMethod(GV_StringifyDigraphHead, "for a string", [IsGVDigraph],
function(graph)
  return StringFormatted("digraph {} {{\n", GV_Name(graph));
end);

#@ Return DOT subgraph head line.
InstallMethod(GV_StringifySubgraphHead, "for a string", [IsGVGraph],
function(graph)
  return StringFormatted("subgraph {} {{\n", GV_Name(graph));
end);

#@ Return DOT subgraph head line.
InstallMethod(GV_StringifyContextHead, "for a string", [IsGVContext],
function(graph)
  return StringFormatted("// {} context \n", GV_Name(graph));
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
                         head,
                         tail,
                         GV_StringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT digraph edge statement line.
InstallMethod(GV_StringifyDigraphEdge, "for a graphviz edge",
[IsGVEdge],
function(edge)
  local head, tail, attrs, split;
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
                         head,
                         tail,
                         GV_StringifyNodeEdgeAttrs(attrs));
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

DeclareOperation("GV_GetIdx", [IsGVObject]);
InstallMethod(GV_GetIdx, 
"for a graphviz object",
[IsGVObject],
x -> x!.Idx);

DeclareOperation("GV_ConstructHistory", [IsGVGraph]);
InstallMethod(GV_ConstructHistory, 
"for a graphviz graph",
[IsGVGraph],
function(graph)
  local nodes, edges, subs, node_hist, edge_hist, subs_hist, hist;
  
  nodes := GV_Nodes(graph); 
  edges := GV_Edges(graph); 
  subs  := GV_Subgraphs(graph); 
  
  node_hist := List(Values(nodes), n -> [GV_GetIdx(n), n]);
  subs_hist := List(Values(subs), s -> [GV_GetIdx(s), s]);
  edge_hist := List(edges, e -> [GV_GetIdx(e), e]);

  hist := Concatenation(node_hist, edge_hist, subs_hist);
  SortBy(hist, v -> v[1]);

  Apply(hist, x -> x[2]);
  return hist;
end);

InstallMethod(GV_StringifyGraph, 
"for a graphviz graph and a string",
[IsGVGraph, IsBool],
function(graph, is_subgraph)
  local result, obj;
  result := "";

  # get the correct head to use
  if is_subgraph then
    if IsGVContext(graph) then 
      Append(result, GV_StringifyContextHead(graph));
    elif IsGVGraph(graph) or IsGVDigraph(graph) then
      Append(result, GV_StringifySubgraphHead(graph));
    else 
      return ErrorNoReturn("Invalid subgraph type.");
    fi;
  elif IsGVDigraph(graph) then
    Append(result, GV_StringifyDigraphHead(graph));
  elif IsGVGraph(graph) then
    Append(result, GV_StringifyGraphHead(graph));
  elif IsGVContext(graph) then
    Append(result, GV_StringifyContextHead(graph));
  else
    return ErrorNoReturn("Invalid graph type.");
  fi;

  Append(result, GV_StringifyGraphAttrs(graph));

  # Add child graphviz objects
  for obj in GV_ConstructHistory(graph) do
    if IsGVGraph(obj) then
      Append(result, GV_StringifyGraph(obj, true));
    elif IsGVNode(obj) then
      Append(result, GV_StringifyNode(obj));
    elif IsGVEdge(obj) then
      if IsGVDigraph(graph) or (IsGVContext(graph) and IsGVDigraph(GV_GetParent(graph))) then
        Append(result, GV_StringifyDigraphEdge(obj));
      else
        Append(result, GV_StringifyGraphEdge(obj));
      fi;
    else 
      return ErrorNoReturn("Invalid graphviz object type.");
    fi;
  od;

  if IsGVContext(graph) then
    # reset attributes following the context
    if GV_GetParent(graph) <> fail then
      Append(result, GV_StringifyGraphAttrs(GV_GetParent(graph)));
    fi;
    Append(result, "\n");
  else 
    Append(result, "}\n");
  fi;
  return result;
end);

InstallMethod(GV_String, "for a graphviz graph",
[IsGVGraph],
function(graph)
  return GV_StringifyGraph(graph, false);
end);


