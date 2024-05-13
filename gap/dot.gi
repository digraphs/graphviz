#############################################################################
##
##  dot.gi
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#############################################################################
# Constructors
#############################################################################

InstallMethod(GraphvizGraph, "for a string", [IsString],
function(name)
  return Objectify(GV_GraphType,
                      rec(
                        Name      := name,
                        Subgraphs := GV_Map(),
                        Nodes     := GV_Map(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := fail,
                        Idx       := 1,
                        Counter   := 1));
end);

InstallMethod(GraphvizGraph, "for no args", [], {} -> GraphvizGraph(""));

InstallMethod(GraphvizGraph, "for an object", [IsObject],
o -> GraphvizGraph(ViewString(o)));

InstallMethod(GraphvizDigraph, "for a string", [IsString],
function(name)
  return Objectify(GV_DigraphType,
                      rec(
                        Name      := name,
                        Subgraphs := GV_Map(),
                        Nodes     := GV_Map(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := fail,
                        Idx       := 1,
                        Counter   := 1));
end);

InstallMethod(GraphvizDigraph, "for no args", [], {} -> GraphvizDigraph(""));

InstallMethod(GraphvizDigraph, "for an object", [IsObject],
o -> GraphvizDigraph(ViewString(o)));

############################################################
# Stringify
############################################################

InstallMethod(ViewString, "for a graphviz node", [IsGVNode],
n -> StringFormatted("<graphviz node {}>", GraphvizName(n)));

InstallMethod(ViewString, "for a graphviz edge", [IsGVEdge],
function(e)
  local head, tail;
  head := GraphvizHead(e);
  tail := GraphvizTail(e);
  return StringFormatted("<graphviz edge ({}, {})>",
                         GraphvizName(head),
                         GraphvizName(tail));
end);

InstallMethod(ViewString, "for a graphviz graph", [IsGVGraphOrDigraph],
function(g)
  local result, edges, nodes, kind;

  result := "";
  edges  := Length(GraphvizEdges(g));
  nodes  :=
            Length(GV_MapNames(GraphvizNodes(g)));

  if IsGVDigraph(g) then
    kind := "digraph";
  elif IsGVContext(g) then
    kind := "context";
  else
    kind := "graph";
  fi;

  Append(result, StringFormatted("<graphviz {} ", kind));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("{} ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", GV_Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", GV_Pluralize(edges, "edge")));

  return result;
end);

############################################################
# Getters
############################################################

InstallMethod(GraphvizName, "for a graphviz object", [IsGVObject], x -> x!.Name);

InstallMethod(GraphvizAttrs, "for a graphviz object", [IsGVObject],
x -> x!.Attrs);

InstallMethod(GraphvizNodes, "for a graphviz graph", [IsGVGraphOrDigraph],
x -> x!.Nodes);

InstallMethod(GraphvizNode, "for a graphviz graph and object",
[IsGVGraphOrDigraph, IsObject], {gv, obj} -> gv!.Nodes[String(obj)]);

InstallMethod(GraphvizEdges, "for a graphviz graph",
[IsGVGraphOrDigraph], x -> x!.Edges);

InstallMethod(GraphvizEdges,
"for a graphviz graph, object, and object",
[IsGVGraphOrDigraph, IsObject, IsObject],
function(gv, head, tail)
    head := GraphvizNode(gv, head);
    tail := GraphvizNode(gv, tail);
    # TODO if head = fail then...
    return Filtered(GraphvizEdges(gv), x -> GraphvizHead(x) = head and
    GraphvizTail(x) = tail);
end);

InstallMethod(GraphvizSubgraphs, "for a graphviz graph", [IsGVGraphOrDigraph],
x -> x!.Subgraphs);

InstallMethod(GraphvizTail, "for a graphviz edge", [IsGVEdge], x -> x!.Tail);

InstallMethod(GraphvizHead, "for a graphviz edge", [IsGVEdge], x -> x!.Head);

InstallMethod(GraphvizGetSubgraph,
"for a graphviz graph and string",
[IsGVGraphOrDigraph, IsString],
{x, name} -> GraphvizSubgraphs(x)[name]);

InstallMethod(GraphvizGetSubgraph,
"for a graphviz graph and an object",
[IsGVGraphOrDigraph, IsObject],
{x, o} -> GraphvizSubgraphs(x)[ViewString(o)]);

# Accessing node attributes

InstallOtherMethod(\[\],
"for a graphviz node and a string",
[IsGVNode, IsString],
{node, key} -> GraphvizAttrs(node)[key]);

InstallOtherMethod(\[\],
"for a graphviz node and an object",
[IsGVNode, IsObject],
{node, key} -> node[GV_EnsureString(key)]);

# Setting node attributes

InstallOtherMethod(\[\]\:\=,
"for a graphviz node and two strings",
[IsGVNode, IsString, IsString],
function(node, key, val)
  GraphvizAttrs(node)[key] := val;
end);

InstallOtherMethod(\[\]\:\=,
"for a graphviz node and two strings",
[IsGVNode, IsObject, IsObject],
function(node, key, val)
  node[GV_EnsureString(key)] := GV_EnsureString(val);
end);

# Accessing edge attributes

InstallOtherMethod(\[\],
"for a graphviz node and a string",
[IsGVEdge, IsString],
{edge, key} -> GraphvizAttrs(edge)[key]);

InstallOtherMethod(\[\],
"for a graphviz node and an object",
[IsGVEdge, IsObject],
{edge, key} -> edge[GV_EnsureString(key)]);

InstallOtherMethod(\[\]\:\=,
"for a graphviz node and a string",
[IsGVEdge, IsString, IsString],
function(edge, key, val)
  GraphvizAttrs(edge)[key] := val;
end);

InstallOtherMethod(\[\]\:\=,
"for a graphviz node and an object",
[IsGVEdge, IsObject, IsObject],
function(edge, key, val)
  edge[GV_EnsureString(key)] := GV_EnsureString(val);
end);

InstallOtherMethod(\[\],
"for a graphviz graph and string",
[IsGVGraphOrDigraph, IsString],
{graph, node} -> GraphvizNodes(graph)[node]);

InstallOtherMethod(\[\],
"for a graphviz graph and string",
[IsGVGraphOrDigraph, IsObject],
{g, o} -> g[ViewString(o)]);

InstallMethod(GraphvizFindGraph,
"for a graphviz graph and a string",
[IsGVGraphOrDigraph, IsString],
{g, s} -> GV_GraphTreeSearch(g, v -> GraphvizName(v) = s));

InstallMethod(GraphvizFindGraph,
"for a graphviz graph and a string",
[IsGVGraphOrDigraph, IsObject],
{g, o} -> GraphvizFindGraph(g, ViewString(o)));

############################################################
# Setters
############################################################

InstallMethod(GraphvizSetName, "for a graphviz object and string",
[IsGVGraphOrDigraph, IsString],
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GraphvizSetName, "for a graphviz object and string",
[IsGVGraphOrDigraph, IsObject],
{g, o} -> GraphvizSetName(g, ViewString(o)));

InstallMethod(GraphvizSetAttrs, "for a graphviz object and record",
[IsGVObject, IsRecord],
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GraphvizSetAttr(x, name, attrs.(name));
  od;
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz object, object and object",
[IsGVObject, IsObject, IsObject],
function(x, name, value)
  local msg;

  if not name in GV_KNOWN_ATTRS then
    msg := Concatenation(
           StringFormatted("unknown attribute \"{}\", the", name),
           " graphviz object may no longer be valid, it can",
           " be removed using GraphvizRemoveAttr");
    Info(InfoWarning, 1, msg);
  fi;
  GraphvizAttrs(x)[String(name)] := String(value);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz graph, object and object",
[IsGVGraphOrDigraph, IsObject, IsObject],
function(x, name, value)
  local attrs, string, msg;

  if not name in GV_KNOWN_ATTRS then
    msg := Concatenation(
           StringFormatted("unknown attribute \"{}\", the", name),
           " graphviz object may no longer be valid, it can",
           " be removed using GraphvizRemoveAttr");
    Info(InfoWarning, 1, msg);
  fi;

  attrs := GraphvizAttrs(x);
  name := String(name);
  value := String(value);
  if ' ' in name then
    name := StringFormatted("\"{}\"", name);
  fi;
  if ' ' in value then
    value := StringFormatted("\"{}\"", value);
  fi;

  string := StringFormatted("{}={}", name, value);
  Add(attrs, string);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz object, object and object",
[IsGVGraphOrDigraph, IsObject],
function(x, value)
  local attrs;
  attrs := GraphvizAttrs(x);

  Add(attrs, String(value));
  return x;
end);

InstallMethod(GraphvizAddNode, "for a graphviz graph and string",
[IsGVGraphOrDigraph, IsString],
function(x, name)
  local node;
  node := GV_Node(x, name);
  GV_AddNode(x, node);
  return node;
end);

# TODO required?
InstallMethod(GraphvizAddNode, "for a graphviz graph and string",
[IsGVGraphOrDigraph, IsGVNode],
function(_, __)  # gaplint: disable=analyse-lvars
  local error;
  error := "Cannot add node objects directly to graphs. ";
  error := Concatenation(error, "Please use the node's name.");
  ErrorNoReturn(error);
end);

InstallMethod(GraphvizAddNode,
"for a graphviz graph and string",
[IsGVGraphOrDigraph, IsObject],
{x, name} -> GraphvizAddNode(x, ViewString(name)));

InstallMethod(GraphvizAddEdge,
"for a graphviz graph and two graphviz nodes",
[IsGVGraphOrDigraph, IsGVNode, IsGVNode],
function(x, head, tail)
  local edge, head_name, tail_name;

  head_name := GraphvizName(head);
  tail_name := GraphvizName(tail);

  # add the nodes to the graph if not present
  if GV_FindNode(x, head_name) = fail then
    GV_AddNode(x, head);
  fi;
  if GV_FindNode(x, tail_name) = fail then
    GV_AddNode(x, tail);
  fi;

  edge := GV_Edge(x, head, tail);
  GV_AddEdge(x, edge);
  return edge;
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz graph and two strings",
[IsGVGraphOrDigraph, IsString, IsString],
function(x, head, tail)
  local head_node, tail_node;

  head_node := GV_FindNode(x, head);
  if head_node = fail then
    head_node := GV_Node(x, head);
  fi;

  tail_node := GV_FindNode(x, tail);
  if tail_node = fail then
    tail_node := GV_Node(x, tail);
  fi;

  return GraphvizAddEdge(x, head_node, tail_node);
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz graph and two objects",
[IsGVGraphOrDigraph, IsObject, IsObject],
function(x, o1, o2)
  if not IsString(o1) then
    o1 := ViewString(o1);
  fi;
  if not IsString(o2) then
    o2 := ViewString(o2);
  fi;
  return GraphvizAddEdge(x, o1, o2);
end);

InstallMethod(GraphvizAddSubgraph,
"for a graphviz graph and string",
[IsGVGraphOrDigraph, IsString],
function(graph, name)
  local error, subgraphs, subgraph;

  subgraphs := GraphvizSubgraphs(graph);
  if IsBound(subgraphs[name]) then
    error := "The graph already contains a subgraph with name {}.";
    ErrorNoReturn(StringFormatted(error, name));
  fi;

  if IsGVDigraph(graph) then
    subgraph := GV_Digraph(graph, name);
  elif IsGVGraph(graph) or IsGVContext(graph) then
    subgraph := GV_Graph(graph, name);
  else
    ErrorNoReturn("Filter must be a filter for a graph category.");
  fi;

  subgraphs[name] := subgraph;
  return subgraph;
end);

InstallMethod(GraphvizAddSubgraph,
"for a graphviz graph and an object",
[IsGVGraphOrDigraph, IsObject],
{g, o} -> GraphvizAddSubgraph(g, ViewString(o)));

InstallMethod(GraphvizAddSubgraph,
"for a grpahviz graph",
[IsGVGraphOrDigraph],
function(graph)
  return GraphvizAddSubgraph(graph, StringFormatted("no_name_{}",
                                               String(GV_GetCounter(graph))));
end);

InstallMethod(GraphvizAddContext,
"for a graphviz graph and a string",
[IsGVGraphOrDigraph, IsString],
function(graph, name)
  local ctx, error, subgraphs;

  subgraphs := GraphvizSubgraphs(graph);
  if IsBound(subgraphs[name]) then
    error := "The graph already contains a subgraph with name {}.";
    ErrorNoReturn(StringFormatted(error, name));
  fi;

  ctx             := GV_Context(graph, name);
  subgraphs[name] := ctx;
  return ctx;
end);

InstallMethod(GraphvizAddContext,
"for a graphviz graph",
[IsGVGraphOrDigraph],
g -> GraphvizAddContext(g, StringFormatted("no_name_{}",
                                      String(GV_GetCounter(g)))));

InstallMethod(GraphvizAddContext,
"for a graphviz graph and an object",
[IsGVGraphOrDigraph, IsObject],
{g, o} -> GraphvizAddContext(g, ViewString(o)));

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and node",
[IsGVGraphOrDigraph, IsGVNode],
{g, node} -> GraphvizRemoveNode(g, GraphvizName(node)));

# TODO GraphvizRemoveEdges(gv, n1, n2)

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and a string",
[IsGVGraphOrDigraph, IsString],
function(g, name)
  local nodes;
  # TODO error if there's no such node
  nodes := GraphvizNodes(g);
  Unbind(nodes[name]);

  # remove incident edges
  GraphvizFilterEdges(g,
    function(e)
      local head, tail;
      head := GraphvizHead(e);
      tail := GraphvizTail(e);
      return name <> GraphvizName(tail) and name <> GraphvizName(head);
    end);

  return g;
end);

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and a string",
[IsGVGraphOrDigraph, IsObject],
{g, o} -> GraphvizRemoveNode(g, ViewString(o)));

InstallMethod(GraphvizFilterEdges, "for a graphviz graph and edge filter",
[IsGVGraphOrDigraph, IsFunction],
function(g, filter)
  local edge, idx, edges;

  edges := GraphvizEdges(g);
  idx   := Length(edges);
  while idx > 0 do
    edge := edges[idx];
    if not filter(edge) then
      Remove(edges, idx);
    fi;
    idx := idx - 1;
  od;

  return g;
end);

InstallMethod(GraphvizFilterEnds, "for a graphviz graph and two strings",
[IsGVGraphOrDigraph, IsString, IsString],
function(g, hn, tn)
  GraphvizFilterEdges(g,
    function(e)
      local head, tail, tmp;
      head := GraphvizHead(e);
      tail := GraphvizTail(e);
      if IsGVDigraph(g) then
        return tn <> GraphvizName(tail) or hn <> GraphvizName(head);
      else
        tmp := tn <> GraphvizName(tail) or hn <> GraphvizName(head);
        return tmp and (hn <> GraphvizName(tail) or tn <> GraphvizName(head));
      fi;
    end);

  return g;
end);

InstallMethod(GraphvizFilterEnds, "for a graphviz graph and two strings",
[IsGVGraphOrDigraph, IsObject, IsObject],
function(g, o1, o2)
  if not IsString(o1) then
    o1 := ViewString(o1);
  fi;
  if not IsString(o2) then
    o2 := ViewString(o2);
  fi;

  GraphvizFilterEnds(g, o1, o2);
end);

InstallMethod(GraphvizRemoveAttr, "for a graphviz object and an object",
[IsGVObject, IsObject],
function(obj, attr)
  local attrs;
  attrs := GraphvizAttrs(obj);
  Unbind(attrs[String(attr)]);
  return obj;
end);

InstallMethod(GraphvizRemoveAttr, "for a graphviz graph and an object",
[IsGVGraphOrDigraph, IsObject],
function(obj, attr)
  local attrs;
  attrs      := GraphvizAttrs(obj);
  obj!.Attrs := Filtered(attrs, item -> item[1] <> String(attr));
  return obj;
end);

########################################################################
# Stringify
########################################################################

InstallMethod(AsString, "for a graphviz graph",
[IsGVGraphOrDigraph], graph -> GV_StringifyGraph(graph, false));

InstallMethod(GraphvizSetNodeLabels,
"for a graphviz graph and list of colors",
[IsGVGraphOrDigraph, IsList],
function(gv, labels)
  local nodes, i;
  # TODO error if labels and nodes aren't same size
  # TODO GV_ErrorIfNotValidLabel
  nodes := GraphvizNodes(gv);
  for i in [1 .. Size(nodes)] do
    GraphvizSetAttr(nodes[i], "label", labels[i]);
  od;
  return gv;
end);

InstallMethod(GraphvizSetNodeColors,
"for a graphviz graph and list of colors",
[IsGVGraphOrDigraph, IsList],
function(gv, colors)
  local nodes, i;

  GV_ErrorIfNotNodeColoring(gv, colors);

  nodes := GraphvizNodes(gv);

  for i in [1 .. Size(nodes)] do
    GraphvizSetAttr(nodes[i], "color", colors[i]);
    GraphvizSetAttr(nodes[i], "style", "filled");
  od;
  return gv;
end);

InstallGlobalFunction(ErrorIfNotValidColor,
function(c)
  if not GV_IsValidColor(c) then
    if IsString(c) then
      c := StringFormatted("\"{}\"", c);
    fi;
    ErrorFormatted("invalid color {} ({}), ",
        "valid colors are RGB values or names from ",
        "the GraphViz 2.44.1 X11 Color Scheme",
        " http://graphviz.org/doc/info/colors.html",
        c,
        TNAM_OBJ(c));
  fi;
end);
