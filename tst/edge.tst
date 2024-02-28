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

# Test edge constructor
gap> g := GV_Graph();;
gap> a := GV_AddNode(g, "a");;
gap> b := GV_AddNode(g, "b");;
gap> GV_AddEdge(g, a, b);
<edge (a, b)>

# Test edge constructor (two strings)
gap> g := GV_Graph();;
gap> e := GV_AddEdge(g, "a", "b");
<edge (a, b)>
gap> GV_Head(e);
<node a>
gap> GV_Tail(e);
<node b>

# Test filtering edges by names (digraph)
gap> g := GV_Digraph();;
gap> a := GV_AddNode(g, "a");;
gap> b := GV_AddNode(g, "b");;
gap> c := GV_AddNode(g, "c");;
gap> d := GV_AddNode(g, "d");;
gap> ab := GV_AddEdge(g, a, b);;
gap> cd := GV_AddEdge(g, c, d);;
gap> GV_FilterEnds(g, "a", "c");
<digraph with 4 nodes and 2 edges>
gap> GV_FilterEnds(g, "b", "d");
<digraph with 4 nodes and 2 edges>
gap> GV_FilterEnds(g, "a", "b");
<digraph with 4 nodes and 1 edge>
gap> GV_Edges(g);
[ <edge (c, d)> ]
gap> GV_FilterEnds(g, "c", "d");
<digraph with 4 nodes and 0 edges>
gap> GV_Edges(g);
[  ]
gap> GV_FilterEnds(g, "c", "d");
<digraph with 4 nodes and 0 edges>

# Test filtering edges by names (graph)
gap> g := GV_Graph();;
gap> a := GV_AddNode(g, "a");;
gap> b := GV_AddNode(g, "b");;
gap> c := GV_AddNode(g, "c");;
gap> d := GV_AddNode(g, "d");;
gap> ab := GV_AddEdge(g, a, b);;
gap> cd := GV_AddEdge(g, c, d);;
gap> GV_FilterEnds(g, "a", "c");
<graph with 4 nodes and 2 edges>
gap> GV_FilterEnds(g, "b", "d");
<graph with 4 nodes and 2 edges>
gap> GV_FilterEnds(g, "b", "a");
<graph with 4 nodes and 1 edge>
gap> GV_Edges(g);
[ <edge (c, d)> ]
gap> GV_FilterEnds(g, "d", "c");
<graph with 4 nodes and 0 edges>
gap> GV_Edges(g);
[  ]
gap> GV_FilterEnds(g, "c", "d");
<graph with 4 nodes and 0 edges>

# Test adding edge between nodes which are not in the graph, but there exists nodes in the graph which share their names.
gap> g := GV_Graph();;
gap> g1 := GV_Graph();;
gap> a1 := GV_AddNode(g, "a");;
gap> d := GV_AddNode(g, "d");;
gap> a2 := GV_AddNode(g1, "a");;
gap> c := GV_AddNode(g1, "c");;
gap> e1 := GV_AddEdge(g, d, a1);;
gap> e2 := GV_AddEdge(g, a2, c);;
Error, Different node in graph with name a.
gap> GV_Edges(g);
[ <edge (d, a)> ]

# Test adding an edge resuses a node automatically
gap> g := GV_Graph();;
gap> GV_AddNode(g, "a");;
gap> GV_AddEdge(g, "a", "a");
<edge (a, a)>

# Test edges with non-string names
gap> g := GV_Graph();;
gap> GV_AddEdge(g, "a", 1);
<edge (a, 1)>
gap> GV_AddEdge(g, 1, "a");
<edge (1, a)>
gap> GV_AddEdge(g, 1, 1);
<edge (1, 1)>

# Test removing edges with non-string names
gap> g := GV_Digraph();;
gap> GV_AddEdge(g, "a", 1);
<edge (a, 1)>
gap> GV_AddEdge(g, 1, "a");
<edge (1, a)>
gap> GV_AddEdge(g, 1, 1);
<edge (1, 1)>
gap> GV_FilterEnds(g, "a", 1);;
gap> GV_Edges(g);
[ <edge (1, a)>, <edge (1, 1)> ]
gap> GV_FilterEnds(g, 1, "a");;
gap> GV_Edges(g);
[ <edge (1, 1)> ]
gap> GV_FilterEnds(g, 1, 1);;
gap> GV_Edges(g);
[  ]

#
