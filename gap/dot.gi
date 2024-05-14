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

#############################################################################
# ViewString
#############################################################################

InstallMethod(ViewString, "for a graphviz node", [IsGraphvizNode],
n -> StringFormatted("<graphviz node {}>", GraphvizName(n)));

InstallMethod(ViewString, "for a graphviz edge", [IsGraphvizEdge],
function(e)
  local head, tail;
  head := GraphvizHead(e);
  tail := GraphvizTail(e);
  return StringFormatted("<graphviz edge ({}, {})>",
                         GraphvizName(head),
                         GraphvizName(tail));
end);

InstallMethod(ViewString, "for a graphviz (di)graph", [IsGraphvizGraphOrDigraph],
function(g)
  local result, edges, nodes, kind;

  result := "";
  edges  := Length(GraphvizEdges(g));
  nodes  :=
            Length(GV_MapNames(GraphvizNodes(g)));

  if IsGraphvizDigraph(g) then
    kind := "digraph";
  elif IsGraphvizContext(g) then
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

#############################################################################
# Getters
#############################################################################

InstallMethod(GraphvizName, "for a graphviz object", [IsGraphvizObject],
x -> x!.Name);

InstallMethod(GraphvizAttrs, "for a graphviz object", [IsGraphvizObject],
x -> x!.Attrs);

InstallMethod(GraphvizNodes, "for a graphviz (di)graph",
[IsGraphvizGraphOrDigraph], x -> x!.Nodes);

InstallMethod(GraphvizEdges, "for a graphviz (di)graph",
[IsGraphvizGraphOrDigraph], x -> x!.Edges);

InstallMethod(GraphvizEdges,
"for a graphviz (di)graph, object, and object",
[IsGraphvizGraphOrDigraph, IsObject, IsObject],
function(gv, head, tail)
    head := GraphvizNodes(gv)[head];
    if head = fail then
      ErrorNoReturn("the 2nd argument (head of an edge) is not a node ",
                    "of the 1st argument (a graphviz graph or digraph)");
    fi;
    tail := GraphvizNodes(gv)[tail];
    if tail = fail then
      ErrorNoReturn("the 2nd argument (head of an edge) is not a node ",
                    "of the 1st argument (a graphviz graph or digraph)");
    fi;
    return Filtered(GraphvizEdges(gv),
                    x -> GraphvizHead(x) = head and GraphvizTail(x) = tail);
end);

InstallMethod(GraphvizSubgraphs, "for a graphviz (di)graph",
[IsGraphvizGraphOrDigraph], x -> x!.Subgraphs);

InstallMethod(GraphvizTail, "for a graphviz edge", [IsGraphvizEdge],
x -> x!.Tail);

InstallMethod(GraphvizHead, "for a graphviz edge", [IsGraphvizEdge],
x -> x!.Head);

# Accessing node attributes

InstallMethod(\[\], "for a graphviz node and a string",
[IsGraphvizNode, IsString],
{node, key} -> GraphvizAttrs(node)[key]);

InstallMethod(\[\], "for a graphviz node and an object",
[IsGraphvizNode, IsObject],
{node, key} -> node[String(key)]);

# Setting node attributes

InstallMethod(\[\]\:\=, "for a graphviz node and two strings",
[IsGraphvizNode, IsString, IsString],
function(node, key, val)
  GraphvizAttrs(node)[key] := val;
end);

InstallMethod(\[\]\:\=, "for a graphviz node and two strings",
[IsGraphvizNode, IsObject, IsObject],
function(node, key, val)
  node[String(key)] := String(val);
end);

# Accessing edge attributes

InstallMethod(\[\], "for a graphviz edge and a string",
[IsGraphvizEdge, IsString],
{edge, key} -> GraphvizAttrs(edge)[key]);

InstallMethod(\[\], "for a graphviz edge and an object",
[IsGraphvizEdge, IsObject],
{edge, key} -> edge[String(key)]);

InstallMethod(\[\]\:\=, "for a graphviz edge and a string",
[IsGraphvizEdge, IsString, IsString],
function(edge, key, val)
  GraphvizAttrs(edge)[key] := val;
end);

InstallMethod(\[\]\:\=, "for a graphviz edge and an object",
[IsGraphvizEdge, IsObject, IsObject],
function(edge, key, val)
  edge[GV_EnsureString(key)] := GV_EnsureString(val);
end);

# Accessor for graphs and digraphs

InstallMethod(\[\], "for a graphviz (di)graph and string",
[IsGraphvizGraphOrDigraph, IsString],
{graph, node} -> GraphvizNodes(graph)[node]);

InstallMethod(\[\], "for a graphviz (di)graph and object",
[IsGraphvizGraphOrDigraph, IsObject],
{g, o} -> g[String(o)]);

InstallMethod(GraphvizFindSubgraphRecursive,
"for a graphviz (di)graph and a string",
[IsGraphvizGraphOrDigraph, IsString],
{g, s} -> GV_GraphTreeSearch(g, v -> GraphvizName(v) = s));

InstallMethod(GraphvizFindSubgraphRecursive,
"for a graphviz (di)graph and a string",
[IsGraphvizGraphOrDigraph, IsObject],
{g, o} -> GraphvizFindSubgraphRecursive(g, String(o)));

#############################################################################
# GraphvizSetName
#############################################################################

InstallMethod(GraphvizSetName, "for a graphviz (di)graph and string",
[IsGraphvizGraphOrDigraph, IsString],
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GraphvizSetName, "for a graphviz (di)graph and string",
[IsGraphvizGraphOrDigraph, IsObject],
{g, o} -> GraphvizSetName(g, String(o)));

#############################################################################
# GraphvizSetAttr(s)
#############################################################################

InstallMethod(GraphvizSetAttrs, "for a graphviz object and record",
[IsGraphvizObject, IsRecord],
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GraphvizSetAttr(x, name, attrs.(name));
  od;
  return x;
end);

# TODO combine this and the next method
InstallMethod(GraphvizSetAttr, "for a graphviz object, object, and object",
[IsGraphvizObject, IsObject, IsObject],
function(x, name, value)

  if not name in GV_KNOWN_ATTRS then
    Info(InfoWarning, 1,
         StringFormatted("unknown attribute \"{}\", the", name),
         " graphviz object may no longer be valid, it can",
         " be removed using GraphvizRemoveAttr");
  fi;
  GraphvizAttrs(x)[String(name)] := String(value);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz (di)graph, object and object",
[IsGraphvizGraphOrDigraph, IsObject, IsObject],
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
  if ' ' in value then
    # Replace with call to GV_QuoteName or whatever TODO
    value := StringFormatted("\"{}\"", value);
  fi;

  string := StringFormatted("{}={}", name, value);
  Add(attrs, string);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz (di)graph and object",
[IsGraphvizGraphOrDigraph, IsObject],
function(x, value)
  local attrs;
  attrs := GraphvizAttrs(x);

  Add(attrs, String(value));
  return x;
end);

#############################################################################
# GraphvizAddNode
#############################################################################

InstallMethod(GraphvizAddNode, "for a graphviz (di)graph and string",
[IsGraphvizGraphOrDigraph, IsString],
function(x, name)
  local node;
  node := GV_Node(x, name);
  GV_AddNode(x, node);
  return node;
end);

InstallMethod(GraphvizAddNode, "for a graphviz (di)graph and string",
[IsGraphvizGraphOrDigraph, IsGraphvizNode],
function(gv, name)  # gaplint: disable=analyse-lvars
  ErrorNoReturn("it is not currently possible to add Graphviz node ",
                "objects directly to Graphviz graphs or digraphs, use ",
                "the node's name instead");
end);

InstallMethod(GraphvizAddNode,
"for a graphviz (di)graph and string",
[IsGraphvizGraphOrDigraph, IsObject],
{x, name} -> GraphvizAddNode(x, String(name)));

#############################################################################
# GraphvizAddEdge
#############################################################################

InstallMethod(GraphvizAddEdge,
"for a graphviz (di)graph and two graphviz nodes",
[IsGraphvizGraphOrDigraph, IsGraphvizNode, IsGraphvizNode],
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
"for a graphviz (di)graph and two strings",
[IsGraphvizGraphOrDigraph, IsString, IsString],
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
"for a graphviz (di)graph and two objects",
[IsGraphvizGraphOrDigraph, IsObject, IsObject],
{gv, o1, o2} -> GraphvizAddEdge(gv, String(o1), String(o2)));

#############################################################################
# GraphvizAddSubgraph
#############################################################################

InstallMethod(GraphvizAddSubgraph, "for a graphviz (di)graph and string",
[IsGraphvizGraphOrDigraph, IsString],
function(gv, name)
  local subgraphs, subgraph;

  subgraphs := GraphvizSubgraphs(gv);
  if IsBound(subgraphs[name]) then
    ErrorFormatted("the 1st argument (a graphviz (di)graph) already has ",
                   " a subgraph with name \"{}\"", name);
  fi;

  # TODO why are the graph and context cases conflated here?
  # Shouldn't this be something like
  # if IsGraphvizContext(gv) then
  # root := GraphvizRoot(gv);
  # else
  # root := gv;
  # fi;
  # Then use root instead of gv below?
  if IsGraphvizDigraph(gv) then
    subgraph := GV_Digraph(gv, name);
  elif IsGraphvizGraph(gv) or IsGraphvizContext(gv) then
    subgraph := GV_Graph(gv, name);
  fi;

  subgraphs[name] := subgraph;
  return subgraph;
end);

InstallMethod(GraphvizAddSubgraph, "for a graphviz (di)graph and an object",
[IsGraphvizGraphOrDigraph, IsObject],
{g, o} -> GraphvizAddSubgraph(g, String(o)));

InstallMethod(GraphvizAddSubgraph, "for a graphviz (di)graph",
[IsGraphvizGraphOrDigraph],
graph -> GraphvizAddSubgraph(graph,
                             StringFormatted("no_name_{}",
                                             GV_GetCounter(graph))));

InstallMethod(GraphvizAddContext,
"for a graphviz (di)graph and a string",
[IsGraphvizGraphOrDigraph, IsString],
function(graph, name)
  local subgraphs, ctx;

  subgraphs := GraphvizSubgraphs(graph);
  # TODO is GraphvizSubgraphs appropriately named? It seems to contain both
  # contexts and subgraphs, rather than just subgraphs as the name suggests
  # See https://github.com/digraphs/graphviz/issues/19
  if IsBound(subgraphs[name]) then
    # TODO why are we talking about subgraphs in the error?
    ErrorFormatted("the 1st argument (a graphviz (di)graph) already has ",
                   " a subgraph with name \"{}\"", name);
  fi;

  ctx             := GV_Context(graph, name);
  subgraphs[name] := ctx;
  return ctx;
end);

InstallMethod(GraphvizAddContext,
"for a graphviz (di)graph",
[IsGraphvizGraphOrDigraph],
g -> GraphvizAddContext(g, StringFormatted("no_name_{}", GV_GetCounter(g))));

InstallMethod(GraphvizAddContext,
"for a graphviz (di)graph and an object",
[IsGraphvizGraphOrDigraph, IsObject],
{g, o} -> GraphvizAddContext(g, String(o)));

InstallMethod(GraphvizRemoveNode, "for a graphviz (di)graph and node",
[IsGraphvizGraphOrDigraph, IsGraphvizNode],
{g, node} -> GraphvizRemoveNode(g, GraphvizName(node)));

InstallMethod(GraphvizRemoveNode, "for a graphviz (di)graph and a string",
[IsGraphvizGraphOrDigraph, IsString],
function(g, name)
  local nodes;
  nodes := GraphvizNodes(g);
  if nodes[name] <> fail then
    Unbind(nodes[name]);
  else
    # Don't just silently do nothing
    ErrorFormatted("the 2nd argument (node name string) \"{}\"",
                   " is not a node of the 1st argument (a graphviz (di)graph)",
                   name);
  fi;

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

InstallMethod(GraphvizRemoveNode, "for a graphviz (di)graph and a string",
[IsGraphvizGraphOrDigraph, IsObject],
{g, o} -> GraphvizRemoveNode(g, String(o)));

InstallMethod(GraphvizFilterEdges, "for a graphviz (di)graph and edge filter",
[IsGraphvizGraphOrDigraph, IsFunction],
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

InstallMethod(GraphvizRemoveEdges, "for a graphviz (di)graph and two strings",
[IsGraphvizGraphOrDigraph, IsString, IsString],
function(g, hn, tn)
  GraphvizFilterEdges(g,
    function(e)
      local head, tail, tmp;
      head := GraphvizHead(e);
      tail := GraphvizTail(e);
      if IsGraphvizDigraph(g) then
        return tn <> GraphvizName(tail) or hn <> GraphvizName(head);
      else
        tmp := tn <> GraphvizName(tail) or hn <> GraphvizName(head);
        return tmp and (hn <> GraphvizName(tail) or tn <> GraphvizName(head));
      fi;
    end);

  return g;
end);

InstallMethod(GraphvizRemoveEdges, "for a graphviz (di)graph and two objects",
[IsGraphvizGraphOrDigraph, IsObject, IsObject],
{gv, o1, o2} -> GraphvizRemoveEdges(gv, String(o1), String(o2)));

InstallMethod(GraphvizRemoveAttr, "for a graphviz object and an object",
[IsGraphvizObject, IsObject],
function(obj, attr)
  local attrs;
  attrs := GraphvizAttrs(obj);
  # TODO error if no such attr?
  Unbind(attrs[String(attr)]);
  return obj;
end);

InstallMethod(GraphvizRemoveAttr, "for a graphviz (di)graph and an object",
[IsGraphvizGraphOrDigraph, IsObject],
function(obj, attr)
  local attrs;
  attrs      := GraphvizAttrs(obj);
  obj!.Attrs := Filtered(attrs, item -> item[1] <> String(attr));
  return obj;
end);

#############################################################################
# Stringify
#############################################################################

InstallMethod(String, "for a graphviz (di)graph",
[IsGraphvizGraphOrDigraph], graph -> GV_StringifyGraph(graph, false));

InstallMethod(GraphvizSetNodeLabels,
"for a graphviz (di)graph and list of colors",
[IsGraphvizGraphOrDigraph, IsList],
function(gv, labels)
  local nodes, i;
  if Size(GraphvizNodes(gv)) <> Size(labels) then
    ErrorFormatted("the 2nd argument (list of node labels) ",
                   "has incorrect length, expected {}, but ",
                   "found {}", Size(GraphvizNodes(gv)), Size(labels));
  fi;
  # TODO GV_ErrorIfNotValidLabel
  nodes := GraphvizNodes(gv);
  for i in [1 .. Size(nodes)] do
    GraphvizSetAttr(nodes[i], "label", labels[i]);
  od;
  return gv;
end);

InstallMethod(GraphvizSetNodeColors,
"for a graphviz (di)graph and list of colors",
[IsGraphvizGraphOrDigraph, IsList],
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
