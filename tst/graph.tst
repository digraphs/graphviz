#############################################################################
##
##  graph.tst
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#@local a, ab, b, c, cd, d, g, n, n1, n2, x
gap> START_TEST("graphviz package: graph.tst");
gap> LoadPackage("graphviz", false);;

# Test graph constructor
gap> GraphvizGraph();
<graphviz graph with 0 nodes and 0 edges>

# Test graph constructor
gap> GraphvizGraph("test-name");
<graphviz graph test-name with 0 nodes and 0 edges>

# Test digraph printing
gap> x := GraphvizDigraph("test-name");
<graphviz digraph test-name with 0 nodes and 0 edges>
gap> x := GraphvizDigraph();
<graphviz digraph with 0 nodes and 0 edges>

# Test adding nodes
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");
<graphviz node n>
gap> g;
<graphviz graph with 1 node and 0 edges>
gap> GraphvizNodes(g);
rec( n := <object> )
gap> GraphvizAddNode(g, "x");
<graphviz node x>
gap> g;
<graphviz graph with 2 nodes and 0 edges>
gap> GraphvizNodes(g);
rec( n := <object>, x := <object> )

# Test add node (name)
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, "n");
<graphviz node n>
gap> GraphvizNodes(g);
rec( n := <object> )
gap> GraphvizAddNode(g, "x");
<graphviz node x>
gap> GraphvizNodes(g);
rec( n := <object>, x := <object> )

# Test has nodes
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");
<graphviz node n>
gap> GV_HasNode(g, "n");
true
gap> GV_HasNode(g, "x");
false

# Test adding edges
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> ab := GraphvizAddEdge(g, a, b);;
gap> g;
<graphviz graph with 2 nodes and 1 edge>
gap> GraphvizEdges(g);
[ <graphviz edge (a, b)> ]
gap> c := GraphvizAddNode(g, "c");;
gap> d := GraphvizAddNode(g, "d");;
gap> cd := GraphvizAddEdge(g, c, d);;
gap> g;
<graphviz graph with 4 nodes and 2 edges>
gap> GraphvizEdges(g);
[ <graphviz edge (a, b)>, <graphviz edge (c, d)> ]

# Test adding edges (two strings)
gap> g := GraphvizGraph();;
gap> GraphvizAddEdge(g, "a", "b");
<graphviz edge (a, b)>
gap> g;
<graphviz graph with 2 nodes and 1 edge>
gap> GraphvizEdges(g);
[ <graphviz edge (a, b)> ]
gap> GraphvizAddEdge(g, "c", "d");
<graphviz edge (c, d)>
gap> g;
<graphviz graph with 4 nodes and 2 edges>
gap> GraphvizEdges(g);
[ <graphviz edge (a, b)>, <graphviz edge (c, d)> ]

# Test adding edge with different nodes with the same name
gap> g := GraphvizGraph();;
gap> GraphvizAddEdge(g, "a", "b");;
gap> GraphvizAddEdge(g, "a", "c");
<graphviz edge (a, c)>
gap> GraphvizNodes(g);
rec( a := <object>, b := <object>, c := <object> )
gap> GraphvizAddEdge(g, "c", "a");
<graphviz edge (c, a)>
gap> GraphvizAddEdge(g, "b", "d");
<graphviz edge (b, d)>
gap> GraphvizAddEdge(g, "d", "b");
<graphviz edge (d, b)>
gap> GraphvizAddEdge(g, "a", "b");
<graphviz edge (a, b)>
gap> GraphvizAddEdge(g, "b", "a");
<graphviz edge (b, a)>
gap> GraphvizAddEdge(g, "c", "d");
<graphviz edge (c, d)>
gap> g;
<graphviz graph with 4 nodes and 8 edges>

# Test removing node
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> c := GraphvizAddNode(g, "c");;
gap> d := GraphvizAddNode(g, "d");;
gap> GraphvizAddEdge(g, a, b);;
gap> GraphvizAddEdge(g, c, d);;
gap> GraphvizRemoveNode(g, a);
<graphviz graph with 3 nodes and 1 edge>
gap> GraphvizNodes(g);
rec( b := <object>, c := <object>, d := <object> )
gap> GraphvizEdges(g);
[ <graphviz edge (c, d)> ]
gap> GraphvizRemoveNode(g, b);
<graphviz graph with 2 nodes and 1 edge>
gap> GraphvizNodes(g);
rec( c := <object>, d := <object> )

# Test removing node
gap> g := GraphvizGraph();;
gap> GraphvizAddEdge(g, "a", "b");;
gap> GraphvizAddEdge(g, "c", "d");;
gap> GraphvizRemoveNode(g, "a");
<graphviz graph with 3 nodes and 1 edge>
gap> GraphvizNodes(g);
rec( b := <object>, c := <object>, d := <object> )
gap> GraphvizEdges(g);
[ <graphviz edge (c, d)> ]
gap> GraphvizRemoveNode(g, "b");
<graphviz graph with 2 nodes and 1 edge>
gap> GraphvizNodes(g);
rec( c := <object>, d := <object> )

# Test renaming graph
gap> g := GraphvizGraph();;
gap> GraphvizSetName(g, "test");
<graphviz graph test with 0 nodes and 0 edges>

# Test global attributes graph
gap> g := GraphvizGraph();;
gap> GraphvizSetName(g, "test");
<graphviz graph test with 0 nodes and 0 edges>

# Test global attributes graph
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "color", "red");;
gap> GraphvizAttrs(g);
[ "color=red" ]

# Test global attributes graph (duplicates)
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "color", "red");;
gap> GraphvizSetAttr(g, "color", "blue");;
gap> GraphvizAttrs(g);
[ "color=red", "color=blue" ]

# Test stringify attributes graph
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "color", "red");;
gap> GraphvizSetAttr(g, "color", "blue");;
gap> AsString(g);
"//dot\ngraph  {\n\tcolor=red color=blue \n}\n"

# # Test removing attributes from a graph TODO uncomment or delete
# gap> g := GraphvizGraph();;
# gap> GraphvizSetAttr(g, "color", "red");;
# gap> GraphvizSetAttr(g, "shape", "circle");;
# gap> GraphvizRemoveAttr(g, "color");;
# gap> GraphvizAttrs(g);
# [ "color=\"blue\"" ]
# gap> GraphvizSetAttr(g, "shape", "square");;
# gap> GraphvizRemoveAttr(g, "shape");;
# gap> GraphvizAttrs(g);
# [  ]

# Test getting a node using bracket notation
gap> g := GraphvizGraph();;
gap> n1 := GraphvizAddNode(g, "test");;
gap> n2 := GraphvizAddNode(g, "abc");;
gap> g["test"];
<graphviz node test>
gap> g["abc"];
<graphviz node abc>

# Test getting a node with a non-string name using bracket notation
gap> g := GraphvizGraph();;
gap> n1 := GraphvizAddNode(g, 1);;
gap> n2 := GraphvizAddNode(g, ["a"]);;
gap> g[1];
<graphviz node 1>
gap> g[["a"]];
<graphviz node [ "a" ]>

# Test making a graph with a non-string name
gap> g := GraphvizGraph(11);
<graphviz graph 11 with 0 nodes and 0 edges>

# Test setting a graph name to a non-string value
gap> g := GraphvizGraph(11);
<graphviz graph 11 with 0 nodes and 0 edges>
gap> GraphvizSetName(g, ["a"]);
<graphviz graph [ "a" ] with 0 nodes and 0 edges>

# Test making a digraph with a non-string name
gap> g := GraphvizDigraph(11);
<graphviz digraph 11 with 0 nodes and 0 edges>

# Test setting a digraph name to a non-string value
gap> g := GraphvizDigraph(11);
<graphviz digraph 11 with 0 nodes and 0 edges>
gap> GraphvizSetName(g, ["a"]);
<graphviz digraph [ "a" ] with 0 nodes and 0 edges>

# Test set label (graph)
gap> g := GraphvizGraph();;
gap> GraphvizSetLabel(g, "test");;
gap> GraphvizAttrs(g);
[ "label=test" ]

# Test set color (graph)
gap> g := GraphvizGraph();;
gap> GraphvizSetColor(g, "red");;
gap> GraphvizAttrs(g);
[ "color=red" ]

# testing removing attributes from graphs
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "label", "test");;
gap> GraphvizAttrs(g);
[ "label=test" ]
gap> GraphvizSetAttr(g, 1, 2);
#I  unknown attribute "1", the graphviz object may no longer be valid, it can be removed using GraphvizRemoveAttr
<graphviz graph with 0 nodes and 0 edges>
gap> GraphvizAttrs(g);
[ "label=test", "1=2" ]
gap> GraphvizRemoveAttr(g, "1=2");
<graphviz graph with 0 nodes and 0 edges>
gap> GraphvizAttrs(g);
[ "label=test" ]

#
gap> STOP_TEST("graphviz package: graph.tst", 0);
