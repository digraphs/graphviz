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
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> GV_Edge(a, b);
<edge (a, b)>

# Test edge constructor (two strings)
gap> e := GV_Edge("a", "b");
<edge (a, b)>
gap> GV_Head(e);
<node a>
gap> GV_Tail(e);
<node b>

# Test filtering edges by names (digraph)
gap> g := GV_Digraph();;
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> c := GV_Node("c");;
gap> d := GV_Node("d");;
gap> ab := GV_Edge(a, b);;
gap> cd := GV_Edge(c, d);;
gap> GV_AddEdge(g, ab);;
gap> GV_AddEdge(g, cd);;
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
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> c := GV_Node("c");;
gap> d := GV_Node("d");;
gap> ab := GV_Edge(a, b);;
gap> cd := GV_Edge(c, d);;
gap> GV_AddEdge(g, ab);;
gap> GV_AddEdge(g, cd);;
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
gap> a1 := GV_Node("a");;
gap> d := GV_Node("d");;
gap> a2 := GV_Node("a");;
gap> c := GV_Node("c");;
gap> e1 := GV_Edge(d, a1);;
gap> e2 := GV_Edge(a2, c);;
gap> GV_AddEdge(g, e1);;
gap> GV_AddEdge(g, e2);
Error, Different node in graph with name a.
gap> GV_Edges(g);
[ <edge (d, a)> ]

#
