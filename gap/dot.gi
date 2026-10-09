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
name -> GV_GraphOrDigraph(name, IsGraphvizGraph));

InstallMethod(GraphvizGraph, "for an object", [IsObject],
obj -> GraphvizGraph(String(obj)));

InstallMethod(GraphvizGraph, "for no args", [], {} -> GraphvizGraph(""));

InstallMethod(GraphvizDigraph, "for a string", [IsString],
name -> GV_GraphOrDigraph(name, IsGraphvizDigraph));

InstallMethod(GraphvizDigraph, "for an object", [IsObject],
obj -> GraphvizDigraph(String(obj)));

InstallMethod(GraphvizDigraph, "for no args", [], {} -> GraphvizDigraph(""));

#############################################################################
# ViewString
#############################################################################

InstallMethod(PrintString, "for a graphviz node", [IsGraphvizNode],
n -> StringFormatted("<graphviz node \"{}\">", GraphvizName(n)));

InstallMethod(PrintString, "for a graphviz edge", [IsGraphvizEdge],
e -> StringFormatted("<graphviz edge {}>", GraphvizName(e)));

InstallMethod(PrintString, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext],
function(g)
  local result, edges, nodes, kind;

  result := "";
  edges  := 0;
  nodes  := 0;

  GV_GraphSearchChildren(g, function(s)
    nodes := nodes + Length(RecNames(GraphvizNodes(s)));
    edges := edges + Length(GraphvizEdges(s));
    return false;
  end);

  if IsGraphvizContext(g) then
    kind := "context";
  elif IsGraphvizDigraph(g) then
    kind := "digraph";
  else
    kind := "graph";
  fi;

  Append(result, StringFormatted("<graphviz {} ", kind));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("\"{}\" ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", Pluralize(edges, "edge")));
  # TODO add more info like that about number of subgraphs + contexts

  return result;
end);

#############################################################################
# Getters
#############################################################################

InstallMethod(GraphvizName, "for a graphviz object", [IsGraphvizObject],
x -> x!.Name);

InstallMethod(GraphvizAttrs, "for a graphviz object", [IsGraphvizObject],
x -> x!.Attrs);

InstallMethod(GraphvizNodes, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext], x -> x!.Nodes);

InstallMethod(GraphvizNode, "for a graphviz (di)graph or context and object",
[IsGraphvizGraphDigraphOrContext, IsObject],
function(gv, val)
  local graph;
  val := String(val);
  graph := GV_FindGraphWithNode(gv, val);
  if graph = fail then
    return fail;
  fi;
  return GraphvizNodes(graph).(val);
end);

# FIXME the below only counts nodes in the root graph, not in its children
InstallMethod(GraphvizNumberOfNodes, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext], x -> Length(RecNames(GraphvizNodes(x))));

InstallMethod(GraphvizEdges, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext], x -> x!.Edges);

InstallMethod(GraphvizEdges,
"for a graphviz (di)graph or context, object, and object",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject],
function(gv, head, tail)
  local nodes;

    nodes := GraphvizNodes(gv);
    head  := String(head);
    if not IsBound(nodes.(head)) then
      ErrorFormatted("the 2nd argument \"{}\" (head of an edge) is not a ",
                     "node of the 1st argument (a graphviz graph or digraph)",
                     head);
    fi;
    tail := String(tail);
    if not IsBound(nodes.(tail)) then
      ErrorFormatted("the 3rd argument \"{}\" (tail of an edge) is not a ",
                     "node of the 1st argument (a graphviz graph or digraph)",
                     tail);
    fi;
    head := nodes.(head);
    tail := nodes.(tail);
    return Filtered(GraphvizEdges(gv),
                    x -> GraphvizHead(x) = head and GraphvizTail(x) = tail);
end);

InstallMethod(GraphvizSubgraphs, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext], x -> x!.Subgraphs);

InstallMethod(GraphvizContexts, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext], x -> x!.Contexts);

InstallMethod(GraphvizTail, "for a graphviz edge", [IsGraphvizEdge],
x -> x!.Tail);

InstallMethod(GraphvizHead, "for a graphviz edge", [IsGraphvizEdge],
x -> x!.Head);

# Operators for nodes

InstallMethod(\=, "for graphviz nodes",
[IsGraphvizNode, IsGraphvizNode], IsIdenticalObj);

InstallMethod(\=, "for graphviz edges",
[IsGraphvizEdge, IsGraphvizEdge], IsIdenticalObj);

# Accessor for graphs and digraphs

InstallMethod(GraphvizFindSubgraphRecursive,
"for a graphviz (di)graph or context and a string",
[IsGraphvizGraphDigraphOrContext, IsString],
{g, s} -> GV_GraphTreeSearch(g, v -> GraphvizName(v) = s and
                                     not IsGraphvizContext(v)));

InstallMethod(GraphvizFindSubgraphRecursive,
"for a graphviz (di)graph or context and a string",
[IsGraphvizGraphDigraphOrContext, IsObject],
{g, o} -> GraphvizFindSubgraphRecursive(g, String(o)));

#############################################################################
# GraphvizSetName
#############################################################################

InstallMethod(GraphvizSetName, "for a graphviz (di)graph or context and string",
[IsGraphvizGraphDigraphOrContext, IsString],
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GraphvizSetName, "for a graphviz (di)graph or context and string",
[IsGraphvizGraphDigraphOrContext, IsObject],
{g, o} -> GraphvizSetName(g, String(o)));

#############################################################################
# GraphvizSetAttr(s)
#############################################################################

InstallMethod(GraphvizSetAttr,
"for a graphviz object, object, and object",
[IsGraphvizObject, IsObject, IsObject],
function(gv, key, val)
  local record;

  key := String(key);
  val := String(val);

  if IsGraphvizGraphDigraphOrContext(gv) then
    # By default setting an attribute of a graph, digraph, or context sets a
    # graph attribute
    record := GraphvizAttrs(gv).graph;
  else
    record := GraphvizAttrs(gv);
  fi;
  record.(key) := val;
  return gv;
end);

InstallMethod(GraphvizSetAttr,
"for a graphviz object, string, and record",
[IsGraphvizGraphDigraphOrContext, IsString, IsRecord],
function(gv, key, val)
  local possible, name;

  possible := ["graph", "node", "edge"];
  if not key in possible then
    ErrorFormatted("invalid argument <key> = {}, when the ",
                   "argument <val> is a record, <key> must be ",
                   "one of {}", key, possible);
  fi;
  for name in RecNames(val) do
    val.(name) := String(val.(name));
  od;
  GraphvizAttrs(gv).(key) := val;
  return gv;
end);

InstallMethod(GraphvizSetAttrs, "for a graphviz object and record",
[IsGraphvizObject, IsRecord],
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GraphvizSetAttr(x, name, attrs.(name));
  od;
  return x;
end);

InstallMethod(GraphvizGetAttr, "for a graphviz object and object",
[IsGraphvizObject, IsObject],
function(gv, key)
  local record;
  if IsGraphvizGraphDigraphOrContext(gv) then
    # By default setting an attribute of a graph, digraph, or context sets a
    # graph attribute
    record := GraphvizAttrs(gv).graph;
  else
    record := GraphvizAttrs(gv);
  fi;

  key := String(key);

  if not IsBound(record.(key)) then
    return fail;
  fi;
  return record.(key);
end);

InstallMethod(GraphvizRemoveAttr,
"for a graphviz (di)graph or context and an object",
[IsGraphvizObject, IsObject],
function(gv, key)
  local record;

  if IsGraphvizGraphDigraphOrContext(gv) then
    # By default setting an attribute of a graph, digraph, or context sets a
    # graph attribute
    record := GraphvizAttrs(gv).graph;
  else
    record := GraphvizAttrs(gv);
  fi;

  key := String(key);

  if not IsBound(record.(key)) then
    ErrorFormatted("the 2nd argument (attribute name) \"{}\" ",
                   "is not defined", key);
  fi;

  Unbind(record.(key));
  return gv;
end);

#############################################################################
# GraphvizAddNode
#############################################################################

InstallMethod(GraphvizAddNode, "for a graphviz (di)graph or context and object",
[IsGraphvizGraphDigraphOrContext, IsObject],
function(gv, val)
  local node;
  val := String(val);

  if Length(val) = 0 then
    ErrorNoReturn("the argument <val> (the name of the node being added) cannot be empty");
  fi;

  # Reuse existing node if available
  node := GraphvizNode(gv, val);
  if node <> fail then
    if not IsIdenticalObj(GV_GetParent(node), gv) then
      ErrorFormatted("The 2nd argument \"{}\" is the name of a node in a ",
                     "(di)graph or context named \"{}\" which is an ",
                     "ancestor, sibling or descendant of the 1st argument ",
                     "(a graphviz (di)graph / context) named \"{}\" (",
                     "adding the node \"{}\" to the 1st argument would ",
                     "silently change the enclosing context of \"{}\")",
                     val,
                     GraphvizName(GV_GetParent(node)),
                     GraphvizName(gv),
                     val,
                     GraphvizName(gv),
                     val);
    fi;
    return node;
  fi;

  node := GV_Node(gv, val);
  GV_AddNode(gv, node);
  return node;
end);

InstallMethod(GraphvizAddNode, "for a graphviz (di)graph or context and string",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode],
function(gv, name)  # gaplint: disable=unused-func-args
  ErrorNoReturn("it is not currently possible to add Graphviz node ",
                "objects directly to Graphviz graphs or digraphs, use ",
                "the node's name instead");
end);

#############################################################################
# GraphvizAddEdge
#############################################################################

InstallMethod(GraphvizAddEdge,
"for a graphviz (di)graph or context and two graphviz nodes",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode, IsGraphvizNode],
function(x, head, tail)
  local edge, root_x, root_head, root_tail;

  root_x := GV_GetRoot(x);
  root_head := GV_GetRoot(head);
  root_tail := GV_GetRoot(tail);
  if not IsIdenticalObj(root_x, root_head) then
    ErrorFormatted("The 2nd argument (head) named \"{}\" does not belong to ",
                   "the root digraph containing the 1st argument named \"{}\" ",
                   "(adding the edge would silently change the enclosing ",
                   "context of \"{}\")",
                   GraphvizName(head),
                   GraphvizName(x),
                   GraphvizName(head));
  fi;
  if not IsIdenticalObj(root_x, root_tail) then
    ErrorFormatted("The 3rd argument (tail) named \"{}\" does not belong to ",
                   "the root digraph containing the 1st argument named \"{}\" ",
                   "(adding the edge would silently change the enclosing ",
                   "context of \"{}\")",
                   GraphvizName(tail),
                   GraphvizName(x),
                   GraphvizName(tail));
  fi;

  edge := GV_Edge(x, head, tail);
  GV_AddEdge(x, edge);
  return edge;
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz (di)graph or context and two strings",
[IsGraphvizGraphDigraphOrContext, IsString, IsString],
function(x, head, tail)
  local head_node, tail_node;

  head_node := GraphvizNode(x, head);
  if head_node = fail then
    Info(InfoGraphviz, 3, "the head of the edge \"", head,
         "\" is not an existing node, adding node \"", head, "\"");
    head_node := GV_Node(x, head);
    GV_AddNode(x, head_node);
  fi;

  tail_node := GraphvizNode(x, tail);
  if tail_node = fail then
    Info(InfoGraphviz, 3, "the tail of the edge \"", tail,
         "\" is not an existing node, adding node \"", tail, "\"");
    tail_node := GV_Node(x, tail);
    GV_AddNode(x, tail_node);
  fi;

  return GraphvizAddEdge(x, head_node, tail_node);
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz (di)graph or context and two objects",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject],
function(gv, head, tail)
  local head_name, tail_name;
  if IsGraphvizNode(head) then
    head_name := GraphvizName(head);
  else
    head_name := String(head);
  fi;
  if IsGraphvizNode(tail) then
    tail_name := GraphvizName(tail);
  else
    tail_name := String(tail);
  fi;
  return GraphvizAddEdge(gv, head_name, tail_name);
end);

#############################################################################
# GraphvizAddSubgraph
#############################################################################

InstallMethod(GraphvizAddSubgraph,
"for a graphviz (di)graph or context and string",
[IsGraphvizGraphDigraphOrContext, IsString],
function(gv, name)
  local subgraphs, subgraph;

  subgraphs := GraphvizSubgraphs(gv);
  if IsBound(subgraphs.(name)) then
    ErrorFormatted("the 1st argument (a graphviz (di)graph/context) ",
                   "already has a subgraph with name \"{}\"", name);
  fi;

  subgraph := GV_Subgraph(gv, name);
  # TODO(reiniscirpons): Why not just do this in the internal func?
  subgraphs.(name) := subgraph;
  return subgraph;
end);

InstallMethod(GraphvizAddSubgraph,
"for a graphviz (di)graph or context and an object",
[IsGraphvizGraphDigraphOrContext, IsObject],
{g, o} -> GraphvizAddSubgraph(g, String(o)));

InstallMethod(GraphvizAddSubgraph, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext],
graph -> GraphvizAddSubgraph(graph,
                             StringFormatted("no_name_{}",
                                             GV_GetCounter(graph))));

InstallMethod(GraphvizAddContext,
"for a graphviz (di)graph or context and a string",
[IsGraphvizGraphDigraphOrContext, IsString],
function(graph, name)
  local contexts, ctx;

  contexts := GraphvizContexts(graph);
  if IsBound(contexts.(name)) then
    ErrorFormatted("the 1st argument (a graphviz (di)graph/context) ",
                   "already has a context with name \"{}\"",
                   name);
  fi;

  ctx             := GV_Context(graph, name);
  contexts.(name) := ctx;
  return ctx;
end);

InstallMethod(GraphvizAddContext,
"for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext],
g -> GraphvizAddContext(g, StringFormatted("no_name_{}", GV_GetCounter(g))));

InstallMethod(GraphvizAddContext,
"for a graphviz (di)graph or context and an object",
[IsGraphvizGraphDigraphOrContext, IsObject],
{g, o} -> GraphvizAddContext(g, String(o)));

# Removal

InstallMethod(GraphvizRemoveNode,
"for a graphviz (di)graph or context and node",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode],
{g, node} -> GraphvizRemoveNode(g, GraphvizName(node)));

InstallMethod(GraphvizRemoveNode,
"for a graphviz (di)graph or context and a string",
[IsGraphvizGraphDigraphOrContext, IsString],
function(g, name)
  local nodes;
  nodes := GraphvizNodes(g);
  if IsBound(nodes.(name)) then
    Unbind(nodes.(name));
  else
    ErrorFormatted("the 2nd argument (node name string) \"{}\"",
                   " is not a node of the 1st argument (a graphviz",
                   " (di)graph/context)",
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

InstallMethod(GraphvizRemoveNode,
"for a graphviz (di)graph or context and a string",
[IsGraphvizGraphDigraphOrContext, IsObject],
{g, o} -> GraphvizRemoveNode(g, String(o)));

InstallMethod(GraphvizFilterEdges,
"for a graphviz (di)graph or context and edge filter",
[IsGraphvizGraphDigraphOrContext, IsFunction],
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

InstallMethod(GraphvizRemoveEdges,
"for a graphviz (di)graph or context, string, and string",
[IsGraphvizGraphDigraphOrContext, IsString, IsString],
function(g, hn, tn)
  local lh, lt, len;

  # if no such nodes exist -> error out
  lh := GraphvizNode(g, hn) = fail;
  lt := GraphvizNode(g, tn) = fail;
  if lh and lt then
    ErrorFormatted("no nodes with names \"{}\" or \"{}\"", hn, tn);
  elif lh then
    ErrorFormatted("no node with name \"{}\"", hn);
  elif lt then
    ErrorFormatted("no node with name \"{}\"", tn);
  fi;

  len := Length(GraphvizEdges(g));
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
  if len - Length(GraphvizEdges(g)) = 0 then
    ErrorFormatted("no edges exist from \"{}\" to \"{}\"",
                   tn, hn);
  fi;

  return g;
end);

InstallMethod(GraphvizRemoveEdges,
"for a graphviz (di)graph or context, object, and object",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject],
{gv, o1, o2} -> GraphvizRemoveEdges(gv, String(o1), String(o2)));

#############################################################################
# Stringify
#############################################################################

# It might be more natural for the next method to be one for String rather than
# AsString, but unfortunately String is an attribute, which means it is
# immutable, and hence cannot be changed after it is first set.

InstallMethod(AsString, "for a graphviz (di)graph",
[IsGraphvizGraphDigraphOrContext], graph -> GV_StringifyGraph(graph, false));

# Can't do the following because it conflicts with the PrintString above, we
# leave this here as a reminder.

# InstallMethod(PrintObj, "for a graphviz object with subobjects",
# [IsGraphvizGraphDigraphOrContext],
# function(gv)
#   Print(String(gv));
# end);

InstallMethod(GraphvizSetNodeLabels,
"for a graphviz (di)graph or context and list of colors",
[IsGraphvizGraphDigraphOrContext, IsList],
function(gv, labels)
  local nodes, i;
  if GraphvizNumberOfNodes(gv) <> Size(labels) then
    ErrorFormatted("the 2nd argument (list of node labels) ",
                   "has incorrect length, expected {}, but ",
                   "found {}", GraphvizNumberOfNodes(gv), Size(labels));
  fi;

  nodes := GraphvizNodes(gv);
  for i in [1 .. GraphvizNumberOfNodes(gv)] do
    labels[i] := String(labels[i]);
    if not StartsWith(labels[i], "\"") or not EndsWith(labels[i], "\"") then
      labels[i] := Concatenation("\"", labels[i], "\"");
    fi;
    GraphvizSetAttr(nodes.(i), "label", labels[i]);
  od;
  return gv;
end);

InstallMethod(GraphvizSetNodeColors,
"for a graphviz (di)graph or context and list of colors",
[IsGraphvizGraphDigraphOrContext, IsList],
function(gv, colors)
  local nodes, i;

  GV_ErrorIfNotNodeColoring(gv, colors);

  nodes := GraphvizNodes(gv);

  for i in [1 .. GraphvizNumberOfNodes(gv)] do
    GraphvizSetAttr(nodes.(i), "color", colors[i]);
    GraphvizSetAttr(nodes.(i), "style", "filled");
  od;
  return gv;
end);

InstallGlobalFunction(ErrorIfNotValidColor,
function(c)
  if not GV_IsValidColor(c) then
    if IsString(c) then
      c := StringFormatted("\"{}\"", c);
    fi;
    ErrorFormatted("invalid color {} ({}), valid colors are RGB values ",
                   "or names from the GraphViz 2.44.1 X11 Color Scheme",
                   " http://graphviz.org/doc/info/colors.html",
                   c,
                   TNAM_OBJ(c));
  fi;
end);
