#############################################################################
##
##  standard/dot.tst
##  Copyright (C) 2022                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("graphviz package: dot.tst");
gap> LoadPackage("graphviz", false);;

# Test creating subgraphs (named)
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g, "test-graph");
<graph test-graph with 0 nodes and 0 edges>
gap> g := GV_Digraph();;
gap> GV_AddSubgraph(g, "test-digraph");
<digraph test-digraph with 0 nodes and 0 edges>
gap> g := GV_Graph();;
gap> GV_AddContext(g, "test-context");
<context test-context with 0 nodes and 0 edges>

# Test no-name constructors
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g);
<graph no_name_1 with 0 nodes and 0 edges>
gap> g := GV_Digraph();;
gap> GV_AddSubgraph(g);
<digraph no_name_1 with 0 nodes and 0 edges>
gap> g := GV_Graph();;
gap> GV_AddContext(g);
<context no_name_1 with 0 nodes and 0 edges>

# Test no-name constructor graphs' names increment
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g);
<graph no_name_1 with 0 nodes and 0 edges>
gap> GV_AddSubgraph(g);
<graph no_name_2 with 0 nodes and 0 edges>
gap> GV_AddSubgraph(g);
<graph no_name_3 with 0 nodes and 0 edges>
gap> GV_AddContext(g);
<context no_name_4 with 0 nodes and 0 edges>

# Test no-name constructor graphs' names increment (contexts)
gap> g := GV_Graph();;
gap> GV_AddContext(g);
<context no_name_1 with 0 nodes and 0 edges>
gap> GV_AddContext(g);
<context no_name_2 with 0 nodes and 0 edges>
gap> GV_AddContext(g);
<context no_name_3 with 0 nodes and 0 edges>

# Test getting subgraphs
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g, "a");;
gap> GV_AddContext(g, "b");;
gap> GV_Subgraphs(g);
HashMap([[ "a", <object> ], [ "b", <object> ]])

# Test adding a node to a subgraph (does or does not add to parent???)
# TODO need to nail down expected behaviour!
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, "a");;
gap> GV_AddNode(s, "n");;
gap> GV_Nodes(g);
HashMap([])
gap> GV_Nodes(s);
HashMap([[ "n", <object> ]])

# Test adding a node to a subgraph which is already in parent fails (by name)
gap> g := GV_Graph("r");;
gap> s := GV_AddSubgraph(g, "a");;
gap> GV_AddNode(g, "n");;
gap> GV_AddNode(s, "n");
Error, Already node with name n in graph r.

# Test adding a node to a graph which is already in child fails (by name)
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, "a");;
gap> GV_AddNode(s, "n");;
gap> GV_AddNode(g, "n");
Error, Already node with name n in graph a.

# Test adding a node to a graph which is already in sibling fails (by name)
gap> g := GV_Graph();;
gap> s1 := GV_AddSubgraph(g, "a");;
gap> s2 := GV_AddSubgraph(g, "b");;
gap> GV_AddNode(s1, "n");;
gap> GV_AddNode(s2, "n");
Error, Already node with name n in graph a.

# Test adding edges to subgraphs
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, "a");;
gap> GV_AddEdge(s, "a", "b");
<edge (a, b)>
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, "a");;
gap> GV_AddEdge(s, "a", "b");
<edge (a, b)>
gap> g := GV_Graph();;
gap> s := GV_AddContext(g, "a");;
gap> GV_AddEdge(s, "a", "b");
<edge (a, b)>

# Test removing edge from graph does not remove from children, sibling, parent, etc
gap> parent := GV_Graph();;
gap> main := GV_AddSubgraph(parent, "main");;
gap> sibling := GV_AddSubgraph(parent, "sibling");;
gap> child := GV_AddSubgraph(main, "child");;
gap> GV_AddEdge(parent, "x", "y");;
gap> GV_AddEdge(main, "x", "y");;
gap> GV_AddEdge(sibling, "x", "y");;
gap> GV_AddEdge(child, "x", "y");;
gap> GV_FilterEnds(main, "x", "y");;
gap> GV_Edges(g);
[  ]
gap> GV_Edges(parent);
[ <edge (x, y)> ]
gap> GV_Edges(sibling);
[ <edge (x, y)> ]
gap> GV_Edges(child);
[ <edge (x, y)> ]

# Test stringifying subgraph digraph
gap> g := GV_Digraph();;
gap> s := GV_AddSubgraph(g, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_SetAttr(s, "color", "red");;
gap> GV_SetAttr(s, "node [color=red]");;
gap> GV_SetAttr(s, "edge [color=red]");;
gap> GV_String(g);
"digraph  {\nsubgraph a {\n\tcolor=\"red\" node [color=red] edge [color=red] \
\n}\n\t\"x\"\n\t\"y\"\n\t\"x\" -> \"y\"\n}\n"

# Test stringifying subgraph graph
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_SetAttr(s, "color", "red");;
gap> GV_SetAttr(s, "node [color=red]");;
gap> GV_SetAttr(s, "edge [color=red]");;
gap> GV_String(g);
"graph  {\nsubgraph a {\n\tcolor=\"red\" node [color=red] edge [color=red] \n}\
\n\t\"x\"\n\t\"y\"\n\t\"x\" -- \"y\"\n}\n"

# Test stringifying subgraph context (graph)
gap> g := GV_Graph();;
gap> s := GV_AddContext(g, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_SetAttr(s, "color", "red");;
gap> GV_SetAttr(s, "node [color=red]");;
gap> GV_SetAttr(s, "edge [color=red]");;
gap> GV_String(g);
"graph  {\n// a context \n\tcolor=\"red\" node [color=red] edge [color=red] \n\
\n\t\"x\"\n\t\"y\"\n\t\"x\" -- \"y\"\n}\n"

# Test stringifying subgraph context (digraph)
gap> g := GV_Digraph();;
gap> s := GV_AddContext(g, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_SetAttr(s, "color", "red");;
gap> GV_SetAttr(s, "node [color=red]");;
gap> GV_SetAttr(s, "edge [color=red]");;
gap> GV_String(g);
"digraph  {\n// a context \n\tcolor=\"red\" node [color=red] edge [color=red] \
\n\n\t\"x\"\n\t\"y\"\n\t\"x\" -> \"y\"\n}\n"

# Test stringifying subgraph w/o name
gap> g := GV_Digraph();;
gap> s := GV_AddSubgraph(g);;
gap> GV_String(g);
"digraph  {\nsubgraph no_name_1 {\n}\n}\n"

# finding a node in a sibling graph
gap> g := GV_Digraph();;
gap> s1 := GV_AddSubgraph(g);;
gap> GV_AddNode(s1, "a");;
gap> s2 := GV_AddSubgraph(g);;
gap> GV_FindNodeS(s2, "a");
<node a>
gap> GV_FindNodeS(s2, "b");
fail

# finding a node in a child graph
gap> g := GV_Digraph();;
gap> s1 := GV_AddSubgraph(g);;
gap> GV_AddNode(s1, "a");;
gap> GV_FindNodeS(g, "a");
<node a>
gap> GV_FindNodeS(g, "b");
fail

# finding a node in a parent graph
gap> g := GV_Digraph();;
gap> s1 := GV_AddSubgraph(g);;
gap> GV_AddNode(g, "a");;
gap> GV_FindNodeS(s1, "a");
<node a>
gap> GV_FindNodeS(s1, "b");
fail

# finding a node in a parent's sibling graph
gap> g := GV_Digraph();;
gap> s1 := GV_AddSubgraph(g);;
gap> s2 := GV_AddSubgraph(g);;
gap> s11 := GV_AddSubgraph(s1);;
gap> GV_AddNode(s2, "a");;
gap> GV_FindNodeS(s11, "a");
<node a>
gap> GV_FindNodeS(s11, "b");
fail

# Test removing a node from a graph
gap> parent := GV_Digraph();;
gap> g := GV_AddSubgraph(parent);;
gap> sibling := GV_AddSubgraph(parent);;
gap> child := GV_AddSubgraph(g);;
gap> a := GV_AddNode(parent, "a");;
gap> GV_AddNode(sibling, "b");;
gap> GV_AddNode(child, "c");;
gap> GV_AddNode(g, "d");;
gap> GV_RemoveNode(g, "d");;
gap> GV_Nodes(g);
HashMap([])
gap> GV_Nodes(parent);
HashMap([[ "a", <object> ]])
gap> GV_Nodes(sibling);
HashMap([[ "b", <object> ]])
gap> GV_Nodes(child);
HashMap([[ "c", <object> ]])

# Test context attribute resetting
gap> g := GV_Digraph();;
gap> ctx := GV_AddContext(g);;
gap> GV_SetAttr(g, "color", "green");;
gap> GV_SetAttr(g, "edge [label=\"testing123\"]");;
gap> GV_SetAttr(g, "node[color=\"blue\"]");;
gap> GV_SetAttr(g, "edge[color=\"blue\"]");;
gap> GV_SetAttr(ctx, "node[color=\"red\"]");;
gap> GV_AddNode(ctx, "a");;
gap> GV_String(g);
"digraph  {\n\tcolor=\"green\" edge [label=\"testing123\"] node[color=\"blue\"\
] edge[color=\"blue\"] \n// no_name_1 context \n\tnode[color=\"red\"] \n\t\"a\
\"\n\tcolor=\"green\" edge [label=\"testing123\"] node[color=\"blue\"] edge[co\
lor=\"blue\"] \n\n}\n"

# Test adding subgraphs with the same name
gap> g := GV_Digraph();;
gap> s1 := GV_AddSubgraph(g, "a");;
gap> s2 := GV_AddSubgraph(g, "a");
Error, The graph already contains a subgraph with name a.

# Test getting subgraphs by name
gap> g := GV_Digraph();;
gap> s1 := GV_AddSubgraph(g, "a");;
gap> s2 := GV_AddSubgraph(g, "b");;
gap> GV_GetSubgraph(g, "a");
<digraph a with 0 nodes and 0 edges>
gap> GV_GetSubgraph(g, "b");
<digraph b with 0 nodes and 0 edges>
gap> GV_GetSubgraph(g, "d");
fail

# Test getting context (subgraph) by name
gap> g := GV_Digraph();;
gap> s1 := GV_AddSubgraph(g, "a");;
gap> s2 := GV_AddContext(g, "c");;
gap> GV_GetSubgraph(g, "a");
<digraph a with 0 nodes and 0 edges>
gap> GV_GetSubgraph(g, "c");
<context c with 0 nodes and 0 edges>

# Test adding a nested subgraph
gap> g := GV_Graph();;
gap> s1 := GV_AddSubgraph(g, "a");;
gap> s2 := GV_AddSubgraph(s1, "c");;
gap> GV_GetSubgraph(g, "a");
<graph a with 0 nodes and 0 edges>
gap> GV_GetSubgraph(g, "c");
fail
gap> GV_GetSubgraph(s1, "c");
<graph c with 0 nodes and 0 edges>

# Test displaying a nested subgraph
gap> g := GV_Graph();;
gap> s1 := GV_AddSubgraph(g, "a");;
gap> s2 := GV_AddSubgraph(s1, "c");;
gap> GV_String(g);
"graph  {\nsubgraph a {\nsubgraph c {\n}\n}\n}\n"

# Test subgraphs with non-string names
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g, 11);
<graph 11 with 0 nodes and 0 edges>

# Test contexts with non-string names
gap> g := GV_Graph();;
gap> GV_AddContext(g, 11);
<context 11 with 0 nodes and 0 edges>

# Test getting subgraphs with non-string names
gap> g := GV_Graph();;
gap> GV_AddContext(g, [ "a" ]);;
gap> GV_GetSubgraph(g, [ "a" ]);
<context [ "a" ] with 0 nodes and 0 edges>

# Test finding subgraph (parent)
gap> g := GV_Graph("a");;
gap> s := GV_AddSubgraph(g, "b");;
gap> o := GV_FindGraph(s, "a");
<graph a with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, g);
true

# Test finding subgraph (child)
gap> g := GV_Graph("a");;
gap> s := GV_AddSubgraph(g, "b");;
gap> o := GV_FindGraph(g, "b");
<graph b with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s);
true

# Test finding subgraph (sibling)
gap> g := GV_Graph("a");;
gap> s := GV_AddSubgraph(g, "b");;
gap> s2 := GV_AddSubgraph(g, "c");;
gap> o := GV_FindGraph(s, "c");
<graph c with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s2);
true

# Test finding subgraph (self)
gap> g := GV_Graph("a");;
gap> o := GV_FindGraph(g, "a");
<graph a with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, g);
true

# Test finding subgraph (far)
gap> g := GV_Graph("r");;
gap> a1 := GV_AddSubgraph(g, "a1");;
gap> a2 := GV_AddSubgraph(a1, "a2");;
gap> a3 := GV_AddSubgraph(a2, "a3");;
gap> b1 := GV_AddSubgraph(g, "b1");;
gap> b2 := GV_AddSubgraph(b1, "b2");;
gap> b3 := GV_AddSubgraph(b2, "b3");;
gap> o := GV_FindGraph(a3, "b3");
<graph b3 with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, b3);
true

# Test finding subgraph (non-string name)
gap> g := GV_Graph("r");;
gap> s := GV_AddSubgraph(g, 1);;
gap> o := GV_FindGraph(g, 1);
<graph 1 with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s);
true

#