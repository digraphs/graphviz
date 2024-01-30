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
DeclareOperation("GV_StringifyEdgeAttrs", [IsGVGraph]);
DeclareOperation("GV_StringifyNodeAttrs", [IsGVGraph]);
DeclareOperation("GV_StringifyNodeEdgeAttrs", [IsRecord]);

###############################################################################
# Family + type
###############################################################################

BindGlobal("GV_ObjectFamily",
           NewFamily("GV_ObjectFamily",
                     IsGVObject));

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
InstallMethod(GV_Node, "for a string and a record", [IsString, IsRecord],
function(name, attrs)
  local namew;

  namew := Compacted(Filtered(name, x -> not x in [' ', '\t', '\r', '\n']));
  if Length(namew) = 0 then
    return ErrorNoReturn("Node name cannot be empty.");
  fi;
  return Objectify(GV_NodeType, 
                  rec(
                    Name  := namew,
                    Attrs := attrs                
                  ));
end);
InstallMethod(GV_Node, "for a string", [IsString],
function(name)
  return GV_Node(name, rec());
end);

# Edge constructors
InstallMethod(GV_Edge, "for a node, a node and a record", 
[IsGVNode, IsGVNode, IsRecord],
function(head, tail, attrs)
  return Objectify(GV_EdgeType, 
                rec(
                  Name  := "",
                  Head  := head,
                  Tail  := tail,
                  Attrs := attrs                
                ));
end);
InstallMethod(GV_Edge, "for a node and a node", [IsGVNode, IsGVNode],
function(head, tail)
  return GV_Edge(head, tail, rec());
end);

# Graph constructors
InstallMethod(GV_Graph, "for a string", [IsString],
function(name)
  return Objectify(GV_GraphType,
                      rec(Type       := GV_GRAPH, 
                          Name       := name,
                          Nodes      := rec(),
                          Edges      := [],
                          Attrs      := rec(),
                          NodeAttrs  := rec(),
                          EdgeAttrs  := rec()));
end);

InstallMethod(GV_Graph, "for no args", [], {} -> GV_Graph(""));

############################################################
# Stringify
############################################################
InstallMethod(ViewString, "", [IsGVNode], n -> StringFormatted("<node {}>", GV_Name(n)));
InstallMethod(ViewString, "", [IsGVEdge], 
function(e)
  local head, tail;
  head := GV_Head(e);
  tail := GV_Tail(e);
  return StringFormatted("<edge ({}, {})>", GV_Name(head), GV_Name(tail));
end);
InstallMethod(ViewString, "", [IsGVGraph], 
function(g)
  local result, edges, nodes;
  result := "";
  edges := Length(GV_Edges(g));
  nodes := Length(RecNames(GV_Nodes(g)));

  if GV_Type(g) = GV_GRAPH then
    Append(result, StringFormatted("<graph ", GV_Name(g)));
  elif GV_Type(g) = GV_DIGRAPH then
    Append(result, StringFormatted("<digraph ", GV_Name(g))); 
  fi;

  if GV_Name(g) <> "" then
    Append(result, StringFormatted("{} ", GV_Name(g)));
  fi;

  if nodes = 1 then
    Append(result, "with 1 node ");
  else
    Append(result, StringFormatted("with {} nodes ", nodes));
  fi;

  if edges = 1 then
    Append(result, "and 1 edge>");
  else
    Append(result, StringFormatted("and {} edges>", edges));
  fi;
  return result;
end);

############################################################
# Getters
############################################################
InstallMethod(GV_Name, "for a graphviz object", [IsGVObject], x -> x!.Name);
InstallMethod(GV_Attrs, "for a graphviz object", [IsGVObject], x -> x!.Attrs);

InstallMethod(GV_NodeAttrs, "for a graphviz graph", [IsGVGraph], x -> x!.NodeAttrs);
InstallMethod(GV_EdgeAttrs, "for a graphviz graph", [IsGVGraph], x -> x!.EdgeAttrs);
InstallMethod(GV_Nodes, "for a graphviz graph", [IsGVGraph], x -> x!.Nodes);
InstallMethod(GV_Edges, "for a graphviz graph", [IsGVGraph], x -> x!.Edges);
InstallMethod(GV_Type, "for a graphviz graph", [IsGVGraph], x -> x!.Type);

InstallMethod(GV_Tail, "for a graphviz edge", [IsGVEdge], x -> x!.Tail);
InstallMethod(GV_Head, "for a graphviz edge", [IsGVEdge], x -> x!.Head);

InstallMethod(GV_HasNode, "for a graphviz graph", [IsGVGraph, IsString], 
function(g, name)
  return IsBound(GV_Nodes(g).(name));
end);

############################################################
# Setters
############################################################
InstallMethod(GV_Name, "for a graphviz object and string",
[IsGVGraph, IsString], 
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GV_SetType, "for a graphviz object and string",
[IsGVGraph, IsString], 
function(x, type)
  if type <> GV_GRAPH and type <> GV_DIGRAPH then          
    return ErrorNoReturn(StringFormatted("Invalid graph type. Must be {} or {}.",
                GV_GRAPH, GV_DIGRAPH));
  fi;
  x!.Type := type;
  return x;
end);

InstallMethod(GV_Attrs, "for a graphviz object and record",
[IsGVObject, IsRecord], 
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GV_Attrs(x).(name) := attrs.(name);
  od;
  return x;
end);

InstallMethod(GV_NodeAttrs, "for a graphviz graph and record",
[IsGVGraph, IsRecord], 
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GV_NodeAttrs(x).(name) := attrs.(name);
  od;
  return x;
end);

InstallMethod(GV_EdgeAttrs, "for a graphviz graph and record",
[IsGVGraph, IsRecord], 
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GV_EdgeAttrs(x).(name) := attrs.(name);
  od;
  return x;
end);

InstallMethod(GV_AddNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode], 
function(x, node)
  local name, nodes;
  name := GV_Name(node);
  nodes := GV_Nodes(x);

  # dont add if already node with the same name
  if IsBound(nodes.(name)) then
    return ErrorNoReturn(StringFormatted("Already node with name {}.", name));
  fi;

  nodes.(name) := node;
  return x;
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

    gn := GV_Nodes(x).(name);
    if not IsIdenticalObj(gn, node) then
      return false;
    fi;
    return true;
  end;

  o := help(GV_Head(edge));
  if not o then 
    return ErrorNoReturn(StringFormatted("Different in graph with name {}.", GV_Name(GV_Head(edge))));
  fi;

  help(GV_Tail(edge));
  if not o then 
    GV_RemoveNode(GV_Head(edge)); # cleanup :)
    return ErrorNoReturn(StringFormatted("Different in graph with name {}.", GV_Name(GV_Tail(edge))));
  fi;

  InsertElmList(x!.Edges, 1, edge);
  return x;
end);

InstallMethod(GV_RemoveNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode],
function(g, n)
  local nodes, name, out;
  nodes := GV_Nodes(g);
  name := GV_Name(n);
  Unbind(nodes.(name));

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
      if GV_Type(g) = GV_GRAPH then
        return (tn <> GV_Name(tail) or hn <> GV_Name(head)) and (hn <> GV_Name(tail) or tn <> GV_Name(head)); 
      else 
        return tn <> GV_Name(tail) or hn <> GV_Name(head); 
      fi; 
    end);
  return g;
end);

InstallMethod(GV_RemoveAttr, "for a graphviz object and string", 
[IsGVObject, IsString],
function(obj, attr)
  local attrs;
  attrs := GV_Attrs(obj);
  Unbind(attrs.(attr));
  return obj;
end);

InstallMethod(GV_RemoveEdgeAttr, "for a graphviz graph and string", 
[IsGVGraph, IsString],
function(graph, attr)
  local attrs;
  attrs := GV_EdgeAttrs(graph);
  Unbind(attrs.(attr));
  return graph;
end);

InstallMethod(GV_RemoveNodeAttr, "for a graphviz graph and string", 
[IsGVGraph, IsString],
function(graph, attr)
  local attrs;
  attrs := GV_NodeAttrs(graph);
  Unbind(attrs.(attr));
  return graph;
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
  local attrs, name;
  name := GV_Name(node);
  attrs := GV_Attrs(node);
  return StringFormatted("\t{}{}\n", name, GV_StringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT graph edge statement line.
InstallMethod(GV_StringifyGraphEdge, "for a graphviz edge",
[IsGVEdge],
function(edge)
  local head, tail, attrs;
  head := GV_Name(GV_Head(edge));
  tail := GV_Name(GV_Tail(edge));
  attrs := GV_Attrs(edge);
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

InstallMethod(GV_StringifyGraphAttrs, "for a record", [IsGVGraph],
function(graph)
  local result, attrs, attr_names, n, i;
  attrs := GV_Attrs(graph);
  result := "";
  attr_names := NamesOfComponents(attrs);
  n := Length(attr_names);
  if n <> 0 then
    Append(result, "\t");
    for i in [1 .. n] do
      Append(result,
             StringFormatted("{}=\"{}\" ",
                             attr_names[i],
                             attrs.(attr_names[i])));
    od;
    Append(result, "\n");
  fi;
  return result;
end);

InstallMethod(GV_StringifyNodeEdgeAttrs, "for a record", [IsRecord],
function(attrs)
  local result, attr_names, n, i;

  result := "";
  attr_names := NamesOfComponents(attrs);
  n := Length(attr_names);
  if n <> 0 then
    Append(result, " [");
    for i in [1 .. n - 1] do
      if attr_names[i] = "label" then
        Append(result,
               StringFormatted("{}=\"{}\", ",
                               attr_names[i],
                               attrs.(attr_names[i])));
      else
        Append(result,
               StringFormatted("{}={}, ",
                               attr_names[i],
                               attrs.(attr_names[i])));
      fi;
    od;
    if attr_names[n] = "label" then
      Append(result,
             StringFormatted("{}=\"{}\"]",
                             attr_names[n],
                             attrs.(attr_names[n])));
    else
      Append(result,
             StringFormatted("{}={}]",
                             attr_names[n],
                             attrs.(attr_names[n])));
    fi;
  fi;
  return result;
end);

InstallMethod(GV_StringifyEdgeAttrs, "for a graphviz graph",
[IsGVGraph],
function(graph)
  local result, attrs;
  attrs := GV_EdgeAttrs(graph);
  if Length(RecNames(attrs)) = 0 then
    return "";
  fi;

  result := "\t";
  Append(result, "edge");
  Append(result, GV_StringifyNodeEdgeAttrs(attrs));
  Append(result, "\n");
  return result;
end);

InstallMethod(GV_StringifyNodeAttrs, "for a graphviz graph",
[IsGVGraph],
function(graph)
  local result, attrs;
  attrs := GV_NodeAttrs(graph);
  if Length(RecNames(attrs)) = 0 then
    return "";
  fi;

  result := "\t";
  Append(result, "node");
  Append(result, GV_StringifyNodeEdgeAttrs(attrs));
  Append(result, "\n");
  return result;
end);

InstallMethod(GV_String, "for a graphviz graph",
[IsGVGraph],
function(graph)
  local result, nodes, edges, elem, i;
  nodes := GV_Nodes(graph);
  edges := GV_Edges(graph);
  
  result := "";

  if GV_Type(graph) = GV_DIGRAPH then
    Append(result, GV_StringifyDigraphHead(graph));
  else
    Append(result, GV_StringifyGraphHead(graph));
  fi;

  Append(result, GV_StringifyGraphAttrs(graph));
  Append(result, GV_StringifyNodeAttrs(graph));
  Append(result, GV_StringifyEdgeAttrs(graph));

  for elem in RecNames(nodes) do
    Append(result, GV_StringifyNode(nodes.(elem)));
  od;

  for elem in edges do
    if GV_Type(graph) = GV_DIGRAPH then
      Append(result, GV_StringifyDigraphEdge(elem));
    else
      Append(result, GV_StringifyGraphEdge(elem));
    fi;
  od;

  Append(result, "}\n");
  return result;
end);


