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
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> GraphvizAddEdge(g, a, b);
<edge (a, b)>

# Test edge constructor (two strings)
gap> g := GraphvizGraph();;
gap> e := GraphvizAddEdge(g, "a", "b");
<edge (a, b)>
gap> GraphvizHead(e);
<node a>
gap> GraphvizTail(e);
<node b>

# Test filtering edges by names (digraph)
gap> g := GraphvizDigraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> c := GraphvizAddNode(g, "c");;
gap> d := GraphvizAddNode(g, "d");;
gap> ab := GraphvizAddEdge(g, a, b);;
gap> cd := GraphvizAddEdge(g, c, d);;
gap> GraphvizFilterEnds(g, "a", "c");
<digraph with 4 nodes and 2 edges>
gap> GraphvizFilterEnds(g, "b", "d");
<digraph with 4 nodes and 2 edges>
gap> GraphvizFilterEnds(g, "a", "b");
<digraph with 4 nodes and 1 edge>
gap> GraphvizEdges(g);
[ <edge (c, d)> ]
gap> GraphvizFilterEnds(g, "c", "d");
<digraph with 4 nodes and 0 edges>
gap> GraphvizEdges(g);
[  ]
gap> GraphvizFilterEnds(g, "c", "d");
<digraph with 4 nodes and 0 edges>

# Test filtering edges by names (graph)
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> c := GraphvizAddNode(g, "c");;
gap> d := GraphvizAddNode(g, "d");;
gap> ab := GraphvizAddEdge(g, a, b);;
gap> cd := GraphvizAddEdge(g, c, d);;
gap> GraphvizFilterEnds(g, "a", "c");
<graph with 4 nodes and 2 edges>
gap> GraphvizFilterEnds(g, "b", "d");
<graph with 4 nodes and 2 edges>
gap> GraphvizFilterEnds(g, "b", "a");
<graph with 4 nodes and 1 edge>
gap> GraphvizEdges(g);
[ <edge (c, d)> ]
gap> GraphvizFilterEnds(g, "d", "c");
<graph with 4 nodes and 0 edges>
gap> GraphvizEdges(g);
[  ]
gap> GraphvizFilterEnds(g, "c", "d");
<graph with 4 nodes and 0 edges>

# Test adding edge between nodes which are not in the graph, but there exists nodes in the graph which share their names.
gap> g := GraphvizGraph();;
gap> g1 := GraphvizGraph();;
gap> a1 := GraphvizAddNode(g, "a");;
gap> d := GraphvizAddNode(g, "d");;
gap> a2 := GraphvizAddNode(g1, "a");;
gap> c := GraphvizAddNode(g1, "c");;
gap> e1 := GraphvizAddEdge(g, d, a1);;
gap> e2 := GraphvizAddEdge(g, a2, c);;
Error, Different node in graph  with name a.
gap> GraphvizEdges(g);
[ <edge (d, a)> ]

# Test adding an edge resuses a node automatically
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, "a");;
gap> GraphvizAddEdge(g, "a", "a");
<edge (a, a)>

# Test edges with non-string names
gap> g := GraphvizGraph();;
gap> GraphvizAddEdge(g, "a", 1);
<edge (a, 1)>
gap> GraphvizAddEdge(g, 1, "a");
<edge (1, a)>
gap> GraphvizAddEdge(g, 1, 1);
<edge (1, 1)>

# Test removing edges with non-string names
gap> g := GraphvizDigraph();;
gap> GraphvizAddEdge(g, "a", 1);
<edge (a, 1)>
gap> GraphvizAddEdge(g, 1, "a");
<edge (1, a)>
gap> GraphvizAddEdge(g, 1, 1);
<edge (1, 1)>
gap> GraphvizFilterEnds(g, "a", 1);;
gap> GraphvizEdges(g);
[ <edge (1, a)>, <edge (1, 1)> ]
gap> GraphvizFilterEnds(g, 1, "a");;
gap> GraphvizEdges(g);
[ <edge (1, 1)> ]
gap> GraphvizFilterEnds(g, 1, 1);;
gap> GraphvizEdges(g);
[  ]

# Test setting attributes using the []:= syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizAddEdge(g, "a", "b");;
gap> n["color"] := "red";;
gap> GraphvizAttrs(n);
HashMap([[ "color", "red" ]])
gap> n["label"] := 1;;
gap> GraphvizAttrs(n);
HashMap([[ "color", "red" ], [ "label", "1" ]])
gap> n["color"] := "blue";;
gap> GraphvizAttrs(n);
HashMap([[ "color", "blue" ], [ "label", "1" ]])

# Test getting attributes using the [] syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizAddEdge(g, "a", "b");;
gap> n["color"] := "red";;
gap> n["color"];
"red"

#
