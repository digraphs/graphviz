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
<graphviz edge (a, b)>

# Test edge constructor (two strings)
gap> g := GraphvizGraph();;
gap> e := GraphvizAddEdge(g, "a", "b");
<graphviz edge (a, b)>
gap> GraphvizHead(e);
<graphviz node a>
gap> GraphvizTail(e);
<graphviz node b>

# Test filtering edges by names (digraph)
gap> g := GraphvizDigraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> c := GraphvizAddNode(g, "c");;
gap> d := GraphvizAddNode(g, "d");;
gap> ab := GraphvizAddEdge(g, a, b);;
gap> cd := GraphvizAddEdge(g, c, d);;
gap> GraphvizFilterEnds(g, "a", "c");
<graphviz digraph with 4 nodes and 2 edges>
gap> GraphvizFilterEnds(g, "b", "d");
<graphviz digraph with 4 nodes and 2 edges>
gap> GraphvizFilterEnds(g, "a", "b");
<graphviz digraph with 4 nodes and 1 edge>
gap> GraphvizEdges(g);
[ <graphviz edge (c, d)> ]
gap> GraphvizFilterEnds(g, "c", "d");
<graphviz digraph with 4 nodes and 0 edges>
gap> GraphvizEdges(g);
[  ]
gap> GraphvizFilterEnds(g, "c", "d");
<graphviz digraph with 4 nodes and 0 edges>

# Test filtering edges by names (graph)
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> c := GraphvizAddNode(g, "c");;
gap> d := GraphvizAddNode(g, "d");;
gap> ab := GraphvizAddEdge(g, a, b);;
gap> cd := GraphvizAddEdge(g, c, d);;
gap> GraphvizFilterEnds(g, "a", "c");
<graphviz graph with 4 nodes and 2 edges>
gap> GraphvizFilterEnds(g, "b", "d");
<graphviz graph with 4 nodes and 2 edges>
gap> GraphvizFilterEnds(g, "b", "a");
<graphviz graph with 4 nodes and 1 edge>
gap> GraphvizEdges(g);
[ <graphviz edge (c, d)> ]
gap> GraphvizFilterEnds(g, "d", "c");
<graphviz graph with 4 nodes and 0 edges>
gap> GraphvizEdges(g);
[  ]
gap> GraphvizFilterEnds(g, "c", "d");
<graphviz graph with 4 nodes and 0 edges>

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
[ <graphviz edge (d, a)> ]

# Test adding an edge resuses a node automatically
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, "a");;
gap> GraphvizAddEdge(g, "a", "a");
<graphviz edge (a, a)>

# Test edges with non-string names
gap> g := GraphvizGraph();;
gap> GraphvizAddEdge(g, "a", 1);
<graphviz edge (a, 1)>
gap> GraphvizAddEdge(g, 1, "a");
<graphviz edge (1, a)>
gap> GraphvizAddEdge(g, 1, 1);
<graphviz edge (1, 1)>

# Test removing edges with non-string names
gap> g := GraphvizDigraph();;
gap> GraphvizAddEdge(g, "a", 1);
<graphviz edge (a, 1)>
gap> GraphvizAddEdge(g, 1, "a");
<graphviz edge (1, a)>
gap> GraphvizAddEdge(g, 1, 1);
<graphviz edge (1, 1)>
gap> GraphvizFilterEnds(g, "a", 1);;
gap> GraphvizEdges(g);
[ <graphviz edge (1, a)>, <graphviz edge (1, 1)> ]
gap> GraphvizFilterEnds(g, 1, "a");;
gap> GraphvizEdges(g);
[ <graphviz edge (1, 1)> ]
gap> GraphvizFilterEnds(g, 1, 1);;
gap> GraphvizEdges(g);
[  ]

# Test setting attributes using the []:= syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizAddEdge(g, "a", "b");;
gap> n["color"] := "red";;
gap> GraphvizAttrs(n);
rec( color := "red" )
gap> n["label"] := 1;;
gap> GraphvizAttrs(n);
rec( color := "red", label := "1" )
gap> n["color"] := "blue";;
gap> GraphvizAttrs(n);
rec( color := "blue", label := "1" )

# Test getting attributes using the [] syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizAddEdge(g, "a", "b");;
gap> n["color"] := "red";;
gap> n["color"];
"red"

# Test set label (edge)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddEdge(g, "n", "m");;
gap> GraphvizSetLabel(n, "test");;
gap> GraphvizAttrs(n);
rec( label := "test" )

# Test set color (edge)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddEdge(g, "n", "m");;
gap> GraphvizSetColor(n, "red");;
gap> GraphvizAttrs(n);
rec( color := "red" )

#
