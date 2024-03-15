###############################################################################
# Private functionality
###############################################################################

DeclareOperation("GraphvizGetCounter", [IsGVGraph]);
DeclareOperation("GraphvizIncCounter", [IsGVGraph]);

DeclareOperation("GraphvizStringifyGraphHead", [IsGVGraph]);
DeclareOperation("GraphvizStringifyDigraphHead", [IsGVGraph]);
DeclareOperation("GraphvizStringifySubgraphHead", [IsGVGraph]);
DeclareOperation("GraphvizStringifyContextHead", [IsGVGraph]);
DeclareOperation("GraphvizStringifyGraphEdge", [IsGVEdge]);
DeclareOperation("GraphvizStringifyDigraphEdge", [IsGVEdge]);
DeclareOperation("GraphvizStringifyNode", [IsGVNode]);
DeclareOperation("GraphvizStringifyGraphAttrs", [IsGVGraph]);
DeclareOperation("GraphvizStringifyNodeEdgeAttrs", [IsHashMap]);
DeclareOperation("GraphvizStringifyGraph", [IsGVGraph, IsBool]);

DeclareOperation("GraphvizFindNode", [IsGVGraph, IsObject]);

###############################################################################
# Family + type
###############################################################################

BindGlobal("GraphvizObjectFamily",
           NewFamily("GraphvizObjectFamily",
                     IsGVObject));

BindGlobal("GraphvizDigraphType", NewType(GraphvizObjectFamily,
                                    IsGVDigraph and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GraphvizGraphType", NewType(GraphvizObjectFamily,
                                    IsGVGraph and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GraphvizNodeType", NewType(GraphvizObjectFamily,
                                    IsGVNode and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GraphvizEdgeType", NewType(GraphvizObjectFamily,
                                    IsGVEdge and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GraphvizContextType", NewType(GraphvizObjectFamily,
                                    IsGVContext and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

###############################################################################
# Constuctors etc
###############################################################################
DeclareOperation("GraphvizNode", [IsGVGraph, IsString]);
DeclareOperation("GraphvizEdge", [IsGVGraph, IsGVNode, IsGVNode]);
DeclareOperation("GraphvizGraph", [IsGVGraph, IsString]);
DeclareOperation("GraphvizDigraph", [IsGVDigraph, IsString]);
DeclareOperation("GraphvizContext", [IsGVGraph, IsString]);

InstallMethod(GraphvizNode, 
"for a string", 
[IsGVGraph, IsString],
function(graph, name)
  local out;
  if Length(name) = 0 then
    return ErrorNoReturn("Node name cannot be empty.");
  fi;
  out := Objectify(GraphvizNodeType, 
                  rec(
                    Name  := name,
                    Attrs := HashMap(),
                    Idx   := GraphvizGetCounter(graph)                
                  ));
  GraphvizIncCounter(graph);
  return out;
end);

InstallMethod(GraphvizEdge, "for two graphviz nodes", 
[IsGVGraph, IsGVNode, IsGVNode],
function(graph, head, tail)
  local out;
  out :=  Objectify(GraphvizEdgeType, 
                rec(
                  Name  := "",
                  Head  := head,
                  Tail  := tail,
                  Attrs := HashMap(),
                  Idx   := GraphvizGetCounter(graph)                
                ));
  GraphvizIncCounter(graph);
  return out;
end);

# Graph constructors

InstallMethod(GraphvizDigraph, 
"for a graphviz digraph and a string", 
[IsGVDigraph, IsString],
function(parent, name)
  local out;

  out         := GraphvizDigraph(name);
  out!.Parent := parent;
  out!.Idx    := GraphvizGetCounter(parent);
  
  GraphvizIncCounter(parent);
  return out;
end);

InstallMethod(GraphvizGraph, 
"for a graphviz graph and a string", 
[IsGVGraph, IsString],
function(parent, name)
  local out;

  out         := GraphvizGraph(name);
  out!.Parent := parent;
  out!.Idx    := GraphvizGetCounter(parent);
  
  GraphvizIncCounter(parent);
  return out;
end);

InstallMethod(GraphvizContext, 
"for a string and a positive integer", 
[IsGVGraph, IsString],
function(parent, name)
  local out;

  out := Objectify(GraphvizContextType,
                      rec(
                        Name      := name,
                        Subgraphs := HashMap(),
                        Nodes     := HashMap(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := parent,
                        Idx       := GraphvizGetCounter(parent),               
                        Counter   := 1
                      ));
  
  GraphvizIncCounter(parent);
  return out;
end);

# public constructors


InstallMethod(GraphvizGraph, 
"for a string", 
[IsString],
function(name)
  return Objectify(GraphvizGraphType,
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

InstallMethod(GraphvizGraph,
"for an object",
[IsObject],
o -> GraphvizGraph(ViewString(o)));

InstallMethod(GraphvizDigraph, 
"for a string", 
[IsString],
function(name)
  return Objectify(GraphvizDigraphType,
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

InstallMethod(GraphvizDigraph,
"for an object",
[IsObject],
o -> GraphvizDigraph(ViewString(o)));

InstallMethod(GraphvizGraph, "for no args", [], {} -> GraphvizGraph(""));
InstallMethod(GraphvizDigraph, "for no args", [], {} -> GraphvizDigraph(""));

############################################################
# Stringify
############################################################
InstallMethod(ViewString, "for a graphviz node", [IsGVNode], n -> StringFormatted("<node {}>", GraphvizName(n)));
InstallMethod(ViewString, "for a graphviz edge", [IsGVEdge], 
function(e)
  local head, tail;
  head := GraphvizHead(e);
  tail := GraphvizTail(e);
  return StringFormatted("<edge ({}, {})>", GraphvizName(head), GraphvizName(tail));
end);

InstallMethod(ViewString, "for a graphviz graph", [IsGVGraph], 
function(g)
  local result, edges, nodes;
  result := "";
  edges := Length(GraphvizEdges(g));
  nodes := Size(GraphvizNodes(g));

  Append(result, StringFormatted("<graph ", GraphvizName(g)));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("{} ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", Pluralize(edges, "edge")));

  return result;
end);

InstallMethod(ViewString, "for a graphviz digraph", [IsGVDigraph], 
function(g)
  local result, edges, nodes;
  result := "";
  edges := Length(GraphvizEdges(g));
  nodes := Size(GraphvizNodes(g));

  Append(result, StringFormatted("<digraph ", GraphvizName(g)));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("{} ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", Pluralize(edges, "edge")));

  return result;
end);

InstallMethod(ViewString, "for a graphviz context", [IsGVContext], 
function(g)
  local result, edges, nodes;
  result := "";
  edges := Length(GraphvizEdges(g));
  nodes := Size(GraphvizNodes(g));

  Append(result, StringFormatted("<context ", GraphvizName(g)));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("{} ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", Pluralize(edges, "edge")));

  return result;
end);

############################################################
# Getters
############################################################
InstallMethod(GraphvizName, "for a graphviz object", [IsGVObject], x -> x!.Name);
InstallMethod(GraphvizAttrs, "for a graphviz object", [IsGVObject], x -> x!.Attrs);

InstallMethod(GraphvizNodes, "for a graphviz graph", [IsGVGraph], x -> x!.Nodes);
InstallMethod(GraphvizEdges, "for a graphviz graph", [IsGVGraph], x -> x!.Edges);
InstallMethod(GraphvizSubgraphs, "for a graphviz graph", [IsGVGraph], x -> x!.Subgraphs);

InstallMethod(GraphvizTail, "for a graphviz edge", [IsGVEdge], x -> x!.Tail);
InstallMethod(GraphvizHead, "for a graphviz edge", [IsGVEdge], x -> x!.Head);

InstallMethod(GraphvizGetSubgraph, 
"for a graphviz graph and string", 
[IsGVGraph, IsString], 
{x, name} -> GraphvizSubgraphs(x)[name]);

InstallMethod(GraphvizGetSubgraph, 
"for a graphviz graph and an object", 
[IsGVGraph, IsObject], 
{x, o} -> GraphvizSubgraphs(x)[ViewString(o)]);

InstallMethod(GraphvizIncCounter, 
"for a graphviz graph",
[IsGVGraph], 
function(x) 
  x!.Counter := x!.Counter + 1;
end);

InstallMethod(GraphvizGetCounter, 
"for a graphviz graph",
[IsGVGraph], 
x -> x!.Counter);

# Converting strings

DeclareOperation("GraphvizEnsureString", [IsObject]);
InstallMethod(GraphvizEnsureString,
"for an object",
[IsObject],
x -> ViewString(x));

InstallMethod(GraphvizEnsureString,
"for a string",
[IsString],
x -> x);

# Accessing node attributes

InstallMethod(\[\],
"for a graphviz node and a string",
[IsGVNode, IsString],
{node, key} -> GraphvizAttrs(node)[key]);

InstallMethod(\[\],
"for a graphviz node and an object",
[IsGVNode, IsObject],
{node, key} -> node[GraphvizEnsureString(key)]);

# Setting node attributes

InstallMethod(\[\]\:\=,
"for a graphviz node and two strings",
[IsGVNode, IsString, IsString],
function(node, key, val) 
  GraphvizAttrs(node)[key] := val;
end);

InstallMethod(\[\]\:\=,
"for a graphviz node and two strings",
[IsGVNode, IsObject, IsObject],
function(node, key, val) 
  node[GraphvizEnsureString(key)] := GraphvizEnsureString(val);
end);

# Accessing edge attributes

InstallMethod(\[\],
"for a graphviz node and a string",
[IsGVEdge, IsString],
{edge, key} -> GraphvizAttrs(edge)[key]);

InstallMethod(\[\],
"for a graphviz node and an object",
[IsGVEdge, IsObject],
{edge, key} -> edge[GraphvizEnsureString(key)]);

InstallMethod(\[\]\:\=,
"for a graphviz node and a string",
[IsGVEdge, IsString, IsString],
function(edge, key, val)
  GraphvizAttrs(edge)[key] := val;
end);

InstallMethod(\[\]\:\=,
"for a graphviz node and an object",
[IsGVEdge, IsObject, IsObject],
function(edge, key, val)
  edge[GraphvizEnsureString(key)] := GraphvizEnsureString(val);
end);

DeclareOperation("GraphvizHasNode",[IsGVGraph, IsObject]);
InstallMethod(GraphvizHasNode, 
"for a graphviz graph", 
[IsGVGraph, IsString], 
function(g, name)
  return name in Keys(GraphvizNodes(g));
end);

DeclareOperation("GraphvizGetParent", [IsGVGraph]);
InstallMethod(GraphvizGetParent, 
"for a graphviz graph", 
[IsGVGraph],
function(graph)
  return graph!.Parent;
end);


DeclareOperation("GraphvizGraphTreeSearch", [IsGVGraph, IsFunction]);
InstallMethod(GraphvizGraphTreeSearch, 
"for a graphviz graph and a predicate",
[IsGVGraph, IsFunction],
function(graph, pred)
  local seen, to_visit, g, subgraph, parent;
  seen     := [graph];
  to_visit := [graph];

  while Length(to_visit) > 0 do
    g := Remove(to_visit, Length(to_visit));

    # Check this graph
    if pred(g) then
      return g;
    fi;

    # add subgraphs to list of to visit if not visited
    for subgraph in Values(GraphvizSubgraphs(g)) do
      if not ForAny(seen, s -> IsIdenticalObj(s, subgraph)) then
        Add(seen, subgraph);
        Add(to_visit, subgraph);
      fi;
    od;

    # add parent if not visited
    parent := GraphvizGetParent(g);
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

DeclareOperation("GraphvizFindGraphWithNode", [IsGVGraph, IsString]);
InstallMethod(GraphvizFindGraphWithNode, 
"for a graphviz graph and a node",
[IsGVGraph, IsString],
{g, n} -> GraphvizGraphTreeSearch(g, v -> v[n] <> fail));

InstallMethod(GraphvizFindGraph, 
"for a graphviz graph and a string",
[IsGVGraph, IsString],
{g, s} -> GraphvizGraphTreeSearch(g, v -> GraphvizName(v) = s));

InstallMethod(GraphvizFindGraph, 
"for a graphviz graph and a string",
[IsGVGraph, IsObject],
{g, o} -> GraphvizFindGraph(g, ViewString(o)));

DeclareOperation("GraphvizGetRoot", [IsGVGraph]);
InstallMethod(GraphvizGetRoot,
"for a graphviz graph",
[IsGVGraph],
function(graph)
  while GraphvizGetParent(graph) <> fail do
    graph := GraphvizGetParent(graph);
  od;
  return graph;
end);

InstallMethod(GraphvizFindNode, 
"for a graphviz graph and a string",
[IsGVGraph, IsString],
function(g, n) 
  local graph;
  graph := GraphvizFindGraphWithNode(g, n);
  if graph = fail then
    return graph;
  fi;
  return graph[n];
end);

############################################################
# Setters
############################################################
InstallMethod(GraphvizSetName, "for a graphviz object and string",
[IsGVGraph, IsString], 
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GraphvizSetName, "for a graphviz object and string",
[IsGVGraph, IsObject], 
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
  GraphvizAttrs(x)[String(name)] := String(value);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz graph, object and object",
[IsGVGraph, IsObject, IsObject], 
function(x, name, value)
  local attrs, string;
  
  attrs := GraphvizAttrs(x);
  if name = "label" then
    string := StringFormatted("{}={}", String(name), String(value));
  else 
    string := StringFormatted("{}=\"{}\"", String(name), String(value));
  fi;

  Add(attrs, string);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz object, object and object",
[IsGVGraph, IsObject], 
function(x, value)
  local attrs;
  attrs := GraphvizAttrs(x);

  Add(attrs, String(value));
  return x;
end);

InstallMethod(\[\],
"for a graphviz graph and string",
[IsGVGraph, IsString],
function(graph, node)
  return GraphvizNodes(graph)[node];
end);

InstallMethod(\[\],
"for a graphviz graph and string",
[IsGVGraph, IsObject],
{g, o} ->  g[ViewString(o)]);

DeclareOperation("GraphvizAddNodePriv", [IsGVGraph, IsGVNode]);
InstallMethod(GraphvizAddNodePriv, 
"for a graphviz graph and node",
[IsGVGraph, IsGVNode], 
function(x, node)
  local found, name, nodes;
  name := GraphvizName(node);
  nodes := GraphvizNodes(x);

  # dont add if already node with the same name
  found := GraphvizFindGraphWithNode(x, name);
  if found <> fail then
    return ErrorNoReturn(StringFormatted("Already node with name {} in graph {}.", name, GraphvizName(found)));
  fi;

  nodes[name] := node;
  return x;
end);

InstallMethod(GraphvizAddNode, "for a graphviz graph and string",
[IsGVGraph, IsString], 
function(x, name)
  local node;
  node := GraphvizNode(x, name);
  GraphvizAddNodePriv(x, node);
  return node;
end);

InstallMethod(GraphvizAddNode, "for a graphviz graph and string",
[IsGVGraph, IsGVNode], 
{_, __} -> ErrorNoReturn("Cannot add node objects directly to graphs. Please use the node's name."));

InstallMethod(GraphvizAddNode, 
"for a graphviz graph and string",
[IsGVGraph, IsObject], 
function(x, name)
  return GraphvizAddNode(x, ViewString(name));
end);

DeclareOperation("GraphvizAddEdgePriv", [IsGVGraph, IsGVEdge]);
InstallMethod(GraphvizAddEdgePriv, 
"for a graphviz graph and edge",
[IsGVGraph, IsGVEdge], 
function(x, edge)
  local head, head_name, tail_name, tail, hg, tg;

  head := GraphvizHead(edge);
  tail := GraphvizTail(edge);
  head_name := GraphvizName(head);
  tail_name := GraphvizName(tail);
  hg := GraphvizFindGraphWithNode(x, head_name);
  tg := GraphvizFindGraphWithNode(x, tail_name);

  # if not already existing, add the nodes to the graph
  if hg = fail then
    GraphvizAddNodePriv(x, head);
  fi;
  if tg = fail then
    GraphvizAddNodePriv(x, tail);
  fi;

  # make sure the nodes exist / are the same as existing ones
  if hg <> fail and not IsIdenticalObj(head, hg[head_name]) then
    return ErrorNoReturn(StringFormatted("Different node in graph {} with name {}.",
                                        GraphvizName(hg),
                                        head_name));
  fi;
  if tg <> fail and not IsIdenticalObj(tail, tg[tail_name]) then
    return ErrorNoReturn(StringFormatted("Different node in graph {} with name {}.", 
                                         GraphvizName(tg), 
                                         tail_name));
  fi;

  Add(x!.Edges, edge);
  return x;
end);

InstallMethod(GraphvizAddEdge, 
"for a graphviz graph and two graphviz nodes", 
[IsGVGraph, IsGVNode, IsGVNode],
function(x, head, tail)
  local edge, head_name, tail_name;

  head_name := GraphvizName(head);
  tail_name := GraphvizName(tail);

  # add the nodes to the graph if not present
  if GraphvizFindNode(x, head_name) = fail then
    GraphvizAddNodePriv(x, head);
  fi;
  if GraphvizFindNode(x, tail_name) = fail then
    GraphvizAddNodePriv(x, tail);
  fi;

  edge := GraphvizEdge(x, head, tail);
  GraphvizAddEdgePriv(x, edge);
  return edge;
end);

InstallMethod(GraphvizAddEdge, 
"for a graphviz graph and two strings", 
[IsGVGraph, IsString, IsString],
function(x, head, tail)
  local head_node, tail_node;

  head_node := GraphvizFindNode(x, head);
  if head_node = fail then
    head_node := GraphvizNode(x, head);
  fi;

  tail_node := GraphvizFindNode(x, tail);
  if tail_node = fail then
    tail_node := GraphvizNode(x, tail);
  fi;

  return GraphvizAddEdge(x, head_node, tail_node);
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz graph and two objects",
[IsGVGraph, IsObject, IsObject],
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
[IsGVGraph, IsString],
function(graph, name)
  local subgraphs, subgraph;

  subgraphs := GraphvizSubgraphs(graph);
  if IsBound(subgraphs[name]) then
    return ErrorNoReturn(StringFormatted("The graph already contains a subgraph with name {}.",
                        name));
  fi;

  if IsGVDigraph(graph) then
    subgraph := GraphvizDigraph(graph, name);
  elif IsGVGraph(graph) then
    subgraph := GraphvizGraph(graph, name);
  else
    return ErrorNoReturn("Filter must be a filter for a graph category.");
  fi;

  subgraphs[name] := subgraph;
  return subgraph;
end);

InstallMethod(GraphvizAddSubgraph,
"for a graphviz graph and an object",
[IsGVGraph, IsObject],
{g, o} -> GraphvizAddSubgraph(g, ViewString(o)));

InstallMethod(GraphvizAddSubgraph, 
"for a grpahviz graph",
[IsGVGraph],
function(graph)
  return GraphvizAddSubgraph(graph, StringFormatted("no_name_{}", 
                                               String(GraphvizGetCounter(graph))));
end);

InstallMethod(GraphvizAddContext, 
"for a graphviz graph and a string",
[IsGVGraph, IsString],
function(graph, name)
  local ctx, subgraphs;

  subgraphs := GraphvizSubgraphs(graph);
  if IsBound(subgraphs[name]) then
    return ErrorNoReturn(StringFormatted("The graph already contains a subgraph with name {}.",
                                         name));
  fi;

  ctx := GraphvizContext(graph, name);
  subgraphs[name] := ctx;
  return ctx;
end);

InstallMethod(GraphvizAddContext, 
"for a graphviz graph",
[IsGVGraph],
g -> GraphvizAddContext(g, StringFormatted("no_name_{}", 
                                      String(GraphvizGetCounter(g)))));

InstallMethod(GraphvizAddContext, 
"for a graphviz graph and an object",
[IsGVGraph, IsObject],
{g, o} -> GraphvizAddContext(g, ViewString(o)));

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode],
function(g, node)
  return GraphvizRemoveNode(g, GraphvizName(node));
end);

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and a string",
[IsGVGraph, IsString],
function(g, name)
  local nodes;
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
[IsGVGraph, IsObject],
{g, o} -> GraphvizRemoveNode(g, ViewString(o)));

InstallMethod(GraphvizFilterEdges, "for a graphviz graph and edge filter",
[IsGVGraph, IsFunction],
function(g, filter)
  local edge, idx, edges;

  edges := GraphvizEdges(g);
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

InstallMethod(GraphvizFilterEnds, "for a graphviz graph and two strings",
[IsGVGraph, IsString, IsString],
function(g, hn, tn)
  GraphvizFilterEdges(g,
    function(e)
      local head, tail;
      head := GraphvizHead(e);
      tail := GraphvizTail(e);
      if IsGVDigraph(g) then
        return tn <> GraphvizName(tail) or hn <> GraphvizName(head);
      else 
        return (tn <> GraphvizName(tail) or hn <> GraphvizName(head)) and (hn <> GraphvizName(tail) or tn <> GraphvizName(head));
      fi;    
    end);

  return g;
end);

InstallMethod(GraphvizFilterEnds, "for a graphviz graph and two strings",
[IsGVGraph, IsObject, IsObject],
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
[IsGVGraph, IsObject],
function(obj, attr)
  local attrs;
  attrs := GraphvizAttrs(obj);
  obj!.Attrs := Filtered(attrs, item -> item[1] <> String(attr));
  return obj;
end);

###############################################################################
# Stringifying
###############################################################################

#@ Return DOT graph head line.
InstallMethod(GraphvizStringifyGraphHead, "for a string", [IsGVGraph],
function(graph)
  return StringFormatted("graph {} {{\n", GraphvizName(graph));
end);

#@ Return DOT digraph head line.
InstallMethod(GraphvizStringifyDigraphHead, "for a string", [IsGVDigraph],
function(graph)
  return StringFormatted("digraph {} {{\n", GraphvizName(graph));
end);

#@ Return DOT subgraph head line.
InstallMethod(GraphvizStringifySubgraphHead, "for a string", [IsGVGraph],
function(graph)
  return StringFormatted("subgraph {} {{\n", GraphvizName(graph));
end);

#@ Return DOT subgraph head line.
InstallMethod(GraphvizStringifyContextHead, "for a string", [IsGVContext],
function(graph)
  return StringFormatted("// {} context \n", GraphvizName(graph));
end);

#@ Return DOT node statement line.
InstallMethod(GraphvizStringifyNode, "for string and record",
[IsGVNode],
function(node)
  local attrs, name, split;
  
  name  := GraphvizName(node);
  attrs := GraphvizAttrs(node);
  if ':' in name then
    split := SplitString(name, ":");
    name  := StringFormatted("\"{}\":{}", split[1], split[2]);
  else
    name := StringFormatted("\"{}\"", name);
  fi;

  return StringFormatted("\t{}{}\n", name, GraphvizStringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT graph edge statement line.
InstallMethod(GraphvizStringifyGraphEdge, "for a graphviz edge",
[IsGVEdge],
function(edge)
  local head, split, tail, attrs;
  head := GraphvizName(GraphvizHead(edge));
  tail := GraphvizName(GraphvizTail(edge));
  attrs := GraphvizAttrs(edge);

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
                         GraphvizStringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT digraph edge statement line.
InstallMethod(GraphvizStringifyDigraphEdge, "for a graphviz edge",
[IsGVEdge],
function(edge)
  local head, tail, attrs, split;
  head  := GraphvizName(GraphvizHead(edge));
  tail  := GraphvizName(GraphvizTail(edge));
  attrs := GraphvizAttrs(edge);

  # handle : syntax
  if ':' in head then
    split := SplitString(head, ':');
    head  := StringFormatted("\"{}\":{}", split[1], split[2]);
  else 
    head := StringFormatted("\"{}\"", head);
  fi;
  if ':' in tail then
    split := SplitString(tail, ':');
    tail  := StringFormatted("\"{}\":{}", split[1], split[2]);
  else 
    tail := StringFormatted("\"{}\"", tail);
  fi;

  return StringFormatted("\t{} -> {}{}\n",
                         head,
                         tail,
                         GraphvizStringifyNodeEdgeAttrs(attrs));
end);

InstallMethod(GraphvizStringifyGraphAttrs, 
"for a graphviz graph",
[IsGVGraph],
function(graph)
  local result, attrs, kv;
  attrs  := GraphvizAttrs(graph);
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

InstallMethod(GraphvizStringifyNodeEdgeAttrs, 
"for a record",
[IsHashMap],
function(attrs)
  local result, keys, key, n, i;

  result := "";
  n      := Size(attrs);
  keys   := SSortedList(Keys(attrs));

  if n <> 0 then
    Append(result, " [");
    for i in [1..n - 1] do
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

DeclareOperation("GraphvizGetIdx", [IsGVObject]);
InstallMethod(GraphvizGetIdx,
"for a graphviz object",
[IsGVObject],
x -> x!.Idx);

DeclareOperation("GraphvizConstructHistory", [IsGVGraph]);
InstallMethod(GraphvizConstructHistory,
"for a graphviz graph",
[IsGVGraph],
function(graph)
  local nodes, edges, subs, node_hist, edge_hist, subs_hist, hist;

  nodes := GraphvizNodes(graph);
  edges := GraphvizEdges(graph);
  subs  := GraphvizSubgraphs(graph);

  node_hist := List(Values(nodes), n -> [GraphvizGetIdx(n), n]);
  subs_hist := List(Values(subs), s -> [GraphvizGetIdx(s), s]);
  edge_hist := List(edges, e -> [GraphvizGetIdx(e), e]);

  hist := Concatenation(node_hist, edge_hist, subs_hist);
  SortBy(hist, v -> v[1]);

  Apply(hist, x -> x[2]);
  return hist;
end);

InstallMethod(GraphvizStringifyGraph,
"for a graphviz graph and a string",
[IsGVGraph, IsBool],
function(graph, is_subgraph)
  local result, obj;
  result := "";

  # get the correct head to use
  if is_subgraph then
    if IsGVContext(graph) then
      Append(result, GraphvizStringifyContextHead(graph));
    elif IsGVGraph(graph) or IsGVDigraph(graph) then
      Append(result, GraphvizStringifySubgraphHead(graph));
    else
      return ErrorNoReturn("Invalid subgraph type.");
    fi;
  elif IsGVDigraph(graph) then
    Append(result, GraphvizStringifyDigraphHead(graph));
  elif IsGVGraph(graph) then
    Append(result, GraphvizStringifyGraphHead(graph));
  elif IsGVContext(graph) then
    Append(result, GraphvizStringifyContextHead(graph));
  else
    return ErrorNoReturn("Invalid graph type.");
  fi;

  Append(result, GraphvizStringifyGraphAttrs(graph));

  # Add child graphviz objects
  for obj in GraphvizConstructHistory(graph) do
    if IsGVGraph(obj) then
      Append(result, GraphvizStringifyGraph(obj, true));
    elif IsGVNode(obj) then
      Append(result, GraphvizStringifyNode(obj));
    elif IsGVEdge(obj) then
      if IsGVDigraph(graph) or (IsGVContext(graph) and IsGVDigraph(GraphvizGetParent(graph))) then
        Append(result, GraphvizStringifyDigraphEdge(obj));
      else
        Append(result, GraphvizStringifyGraphEdge(obj));
      fi;
    else
      return ErrorNoReturn("Invalid graphviz object type.");
    fi;
  od;

  if IsGVContext(graph) then
    # reset attributes following the context
    if GraphvizGetParent(graph) <> fail then
      Append(result, GraphvizStringifyGraphAttrs(GraphvizGetParent(graph)));
    fi;
    Append(result, "\n");
  else
    Append(result, "}\n");
  fi;
  return result;
end);

InstallMethod(AsString, "for a graphviz graph",
[IsGVGraph],
function(graph)
  return GraphvizStringifyGraph(graph, false);
end);


