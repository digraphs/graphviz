#############################################################################
##
##  dot.gi
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# TODO
# 2. ensure arg names are consistent (using gv, name, e, n, key, val, head,
#    tail)
# 3. Use GraphvizStringify which for a string does nothing (no copy); for an
#    object calls String; for a IsGraphvizObject returns its name;

#############################################################################
# Constructors
#############################################################################

InstallMethod(GraphvizGraph, "for an object", [IsObject],
obj -> GV_GraphOrDigraph(String(obj), IsGraphvizGraph));

InstallMethod(GraphvizGraph, "for no args", [], {} -> GraphvizGraph(""));

InstallMethod(GraphvizDigraph, "for an object", [IsObject],
obj -> GV_GraphOrDigraph(String(obj), IsGraphvizDigraph));

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
function(gv)
  local result, edges, nodes, kind;

  result := "";
  edges  := GraphvizNumberOfEdges(gv);
  nodes  := GraphvizNumberOfNodes(gv);

  if IsGraphvizContext(gv) then
    kind := "context";
  elif IsGraphvizDigraph(gv) then
    kind := "digraph";
  else
    kind := "graph";
  fi;

  Append(result, StringFormatted("<graphviz {} ", kind));

  if GraphvizName(gv) <> "" then
    Append(result, StringFormatted("\"{}\" ", GraphvizName(gv)));
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
gv -> gv!.Name);

InstallMethod(GraphvizAttrs, "for a graphviz object", [IsGraphvizObject],
gv -> gv!.Attrs);

InstallMethod(GraphvizNodes, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext], gv -> gv!.Nodes);

InstallMethod(GraphvizNode, "for a graphviz (di)graph or context and object",
[IsGraphvizGraphDigraphOrContext, IsObject],
function(gv, obj)
  local name, subgraph;

  name := String(obj);
  subgraph := GV_FindGraphWithNode(gv, name);
  if subgraph = fail then
    return fail;
  fi;
  return GraphvizNodes(subgraph).(name);
end);

InstallMethod(GraphvizNumberOfNodes, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext],
function(gv)
  local nodes;

  nodes := 0;
  GV_GraphSearchChildren(gv, function(subgraph)
    nodes := nodes + Length(RecNames(GraphvizNodes(subgraph)));
    return false;
  end);
  return nodes;
end);

InstallMethod(GraphvizNumberOfEdges, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext],
function(gv)
  local edges;

  edges := 0;
  GV_GraphSearchChildren(gv, function(subgraph)
    edges := edges + Length(GraphvizEdges(subgraph));
    return false;
  end);
  return edges;
end);

InstallMethod(GraphvizEdges, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext], gv -> gv!.Edges);

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
[IsGraphvizGraphDigraphOrContext], gv -> gv!.Subgraphs);

InstallMethod(GraphvizContexts, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext], gv -> gv!.Contexts);

InstallMethod(GraphvizTail, "for a graphviz edge", [IsGraphvizEdge],
e -> e!.Tail);

InstallMethod(GraphvizHead, "for a graphviz edge", [IsGraphvizEdge],
e -> e!.Head);

# Operators for graphviz objects

InstallMethod(\=, "for graphviz objects",
[IsGraphvizObject, IsGraphvizObject], IsIdenticalObj);

# Accessor for graphs and digraphs

InstallMethod(GraphvizFindSubgraphRecursive,
"for a graphviz (di)graph or context and an object",
[IsGraphvizGraphDigraphOrContext, IsObject],
{gv, obj} -> GV_GraphTreeSearch(gv, subgraph -> GraphvizName(subgraph) = String(obj)
                                     and not IsGraphvizContext(subgraph)));

#############################################################################
# GraphvizSetName
#############################################################################

InstallMethod(GraphvizSetName,
"for a graphviz (di)graph or context and object",
[IsGraphvizGraphDigraphOrContext, IsObject],
function(gv, name)
  gv!.Name := String(name);
  return gv;
end);

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
function(gv, obj)
  local node, name;
  name := String(obj);

  if Length(name) = 0 then
    ErrorNoReturn("the value returned by `String(obj)` must not be empty");
  fi;

  # Reuse existing node if available
  node := GraphvizNode(gv, name);
  if node <> fail then
    if not IsIdenticalObj(GV_GetParent(node), gv) then
      ErrorFormatted("The 2nd argument \"{}\" is the name of a node in a ",
                     "(di)graph or context named \"{}\" which is an ",
                     "ancestor, sibling or descendant of the 1st argument ",
                     "(a graphviz (di)graph / context) named \"{}\" (",
                     "adding the node \"{}\" to the 1st argument would ",
                     "silently change the enclosing context of \"{}\")",
                     name,
                     GraphvizName(GV_GetParent(node)),
                     GraphvizName(gv),
                     name,
                     GraphvizName(gv),
                     name);
    fi;
    return node;
  fi;

  node := GV_Node(gv, name);
  GV_AddNode(gv, node);
  return node;
end);

InstallMethod(GraphvizAddNode, "for a graphviz (di)graph or context and string",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode],
function(gv, n)  # gaplint: disable=unused-func-args
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
function(gv, head, tail)
  local edge, root_x, root_head, root_tail;

  root_x    := GV_GetRoot(gv);
  root_head := GV_GetRoot(head);
  root_tail := GV_GetRoot(tail);
  if not IsIdenticalObj(root_x, root_head) then
    ErrorFormatted("The 2nd argument (head) named \"{}\" does not belong to ",
                   "the root digraph containing the 1st argument named \"{}\" ",
                   "(adding the edge would silently change the enclosing ",
                   "context of \"{}\")",
                   GraphvizName(head),
                   GraphvizName(gv),
                   GraphvizName(head));
  fi;
  if not IsIdenticalObj(root_x, root_tail) then
    ErrorFormatted("The 3rd argument (tail) named \"{}\" does not belong to ",
                   "the root digraph containing the 1st argument named \"{}\" ",
                   "(adding the edge would silently change the enclosing ",
                   "context of \"{}\")",
                   GraphvizName(tail),
                   GraphvizName(gv),
                   GraphvizName(tail));
  fi;

  edge := GV_Edge(gv, head, tail);
  GV_AddEdge(gv, edge);
  return edge;
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz (di)graph or context and two objects",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject],
function(gv, head, tail)
  local head_name, tail_name, head_node, tail_node;

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

  head_node := GraphvizNode(gv, head_name);
  if head_node = fail then
    Info(InfoGraphviz, 3, "the head of the edge \"", head_name,
         "\" is not an existing node, adding node \"", head_name, "\"");
    head_node := GV_Node(gv, head_name);
    GV_AddNode(gv, head_node);
  fi;

  tail_node := GraphvizNode(gv, tail_name);
  if tail_node = fail then
    Info(InfoGraphviz, 3, "the tail of the edge \"", tail_name,
         "\" is not an existing node, adding node \"", tail_name, "\"");
    tail_node := GV_Node(gv, tail_name);
    GV_AddNode(gv, tail_node);
  fi;

  return GraphvizAddEdge(gv, head_node, tail_node);
end);

#############################################################################
# GraphvizAddSubgraph
#############################################################################

InstallMethod(GraphvizAddSubgraph,
"for a graphviz (di)graph or context and object",
[IsGraphvizGraphDigraphOrContext, IsObject],
function(gv, obj)
  local subgraphs, subgraph, name;

  name := String(obj);

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

InstallMethod(GraphvizAddSubgraph, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext],
gv -> GraphvizAddSubgraph(gv, StringFormatted("no_name_{}", GV_GetCounter(gv))));

InstallMethod(GraphvizAddContext,
"for a graphviz (di)graph or context and object",
[IsGraphvizGraphDigraphOrContext, IsObject],
function(gv, obj)
  local contexts, ctx, name;

  name := String(obj);
  contexts := GraphvizContexts(gv);
  if IsBound(contexts.(name)) then
    ErrorFormatted("the 1st argument (a graphviz (di)graph/context) ",
                   "already has a context with name \"{}\"",
                   name);
  fi;

  ctx             := GV_Context(gv, name);
  contexts.(name) := ctx;
  return ctx;
end);

InstallMethod(GraphvizAddContext, "for a graphviz (di)graph or context",
[IsGraphvizGraphDigraphOrContext],
gv -> GraphvizAddContext(gv, StringFormatted("no_name_{}", GV_GetCounter(gv))));

# Removal

InstallMethod(GraphvizRemoveNode,
"for a graphviz (di)graph or context and node",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode],
{gv, n} -> GraphvizRemoveNode(gv, GraphvizName(n)));

InstallMethod(GraphvizRemoveNode,
"for a graphviz (di)graph or context and a string",
[IsGraphvizGraphDigraphOrContext, IsObject],
function(gv, obj)
  local nodes, name;
  name := String(obj);
  nodes := GraphvizNodes(gv);
  if IsBound(nodes.(name)) then
    Unbind(nodes.(name));
  else
    ErrorFormatted("the 2nd argument (node name string) \"{}\"",
                   " is not a node of the 1st argument (a graphviz",
                   " (di)graph/context)",
                   name);
  fi;

  # remove incident edges
  GraphvizFilterEdges(gv,
    function(e)
      local head, tail;
      head := GraphvizHead(e);
      tail := GraphvizTail(e);
      return name <> GraphvizName(tail) and name <> GraphvizName(head);
    end);

  return gv;
end);

InstallMethod(GraphvizFilterEdges,
"for a graphviz (di)graph or context and edge filter",
[IsGraphvizGraphDigraphOrContext, IsFunction],
function(gv, func)
  local edge, idx, edges;
  # TODO check func has correct number of args

  edges := GraphvizEdges(gv);
  idx   := Length(edges);
  while idx > 0 do
    edge := edges[idx];
    if not func(edge) then
      Remove(edges, idx);
    fi;
    idx := idx - 1;
  od;

  return gv;
end);

InstallMethod(GraphvizRemoveEdges,
"for a graphviz (di)graph or context, object, and object",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject],
function(gv, head_obj, tail_obj)
  local lh, lt, len, hn, tn;

  hn := String(head_obj);
  tn := String(tail_obj);

  # if no such nodes exist -> error out
  lh := GraphvizNode(gv, hn) = fail;
  lt := GraphvizNode(gv, tn) = fail;
  if lh and lt then
    ErrorFormatted("no nodes with names \"{}\" or \"{}\"", hn, tn);
  elif lh then
    ErrorFormatted("no node with name \"{}\"", hn);
  elif lt then
    ErrorFormatted("no node with name \"{}\"", tn);
  fi;

  len := Length(GraphvizEdges(gv));
  GraphvizFilterEdges(gv,
    function(e)
      local head, tail, tmp;
      head := GraphvizHead(e);
      tail := GraphvizTail(e);
      if IsGraphvizDigraph(gv) then
        return tn <> GraphvizName(tail) or hn <> GraphvizName(head);
      else
        tmp := tn <> GraphvizName(tail) or hn <> GraphvizName(head);
        return tmp and (hn <> GraphvizName(tail) or tn <> GraphvizName(head));
      fi;
    end);
  if len - Length(GraphvizEdges(gv)) = 0 then
    ErrorFormatted("no edges exist from \"{}\" to \"{}\"",
                   tn, hn);
  fi;

  return gv;
end);

#############################################################################
# Stringify
#############################################################################

# It might be more natural for the next method to be one for String rather than
# AsString, but unfortunately String is an attribute, which means it is
# immutable, and hence cannot be changed after it is first set.

InstallMethod(AsString, "for a graphviz (di)graph",
[IsGraphvizGraphDigraphOrContext], gv -> GV_StringifyGraph(gv, false));

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
