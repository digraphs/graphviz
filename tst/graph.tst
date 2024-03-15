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

# Test graph constructor
gap> GraphvizGraph();
<graph with 0 nodes and 0 edges>

# Test graph constructor
gap> GraphvizGraph("test-name");
<graph test-name with 0 nodes and 0 edges>

# Test digraph printing
gap> x := GraphvizDigraph("test-name");
<digraph test-name with 0 nodes and 0 edges>
gap> x := GraphvizDigraph();
<digraph with 0 nodes and 0 edges>

# Test adding nodes
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");
<node n>
gap> g;
<graph with 1 node and 0 edges>
gap> GraphvizNodes(g);
rec( n := <object> )
gap> GraphvizAddNode(g, "x");
<node x>
gap> g;
<graph with 2 nodes and 0 edges>
gap> GraphvizNodes(g);
rec( n := <object>, x := <object> )

# Test add node (name)
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, "n");
<node n>
gap> GraphvizNodes(g);
rec( n := <object> )
gap> GraphvizAddNode(g, "x");
<node x>
gap> GraphvizNodes(g);
rec( n := <object>, x := <object> )

# Test has nodes
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");
<node n>
gap> GraphvizHasNode(g, "n");
true
gap> GraphvizHasNode(g, "x");
false

# Test adding edges
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> ab := GraphvizAddEdge(g, a, b);;
gap> g;
<graph with 2 nodes and 1 edge>
gap> GraphvizEdges(g);
[ <edge (a, b)> ]
gap> c := GraphvizAddNode(g, "c");;
gap> d := GraphvizAddNode(g, "d");;
gap> cd := GraphvizAddEdge(g, c, d);;
gap> g;
<graph with 4 nodes and 2 edges>
gap> GraphvizEdges(g);
[ <edge (a, b)>, <edge (c, d)> ]

# Test adding edges (two strings)
gap> g := GraphvizGraph();;
gap> GraphvizAddEdge(g, "a", "b");
<edge (a, b)>
gap> g;
<graph with 2 nodes and 1 edge>
gap> GraphvizEdges(g);
[ <edge (a, b)> ]
gap> GraphvizAddEdge(g, "c", "d");
<edge (c, d)>
gap> g;
<graph with 4 nodes and 2 edges>
gap> GraphvizEdges(g);
[ <edge (a, b)>, <edge (c, d)> ]

# Test adding edge with different nodes with the same name
gap> g := GraphvizGraph();;
gap> GraphvizAddEdge(g, "a", "b");;
gap> GraphvizAddEdge(g, "a", "c");
<edge (a, c)>
gap> GraphvizNodes(g);
rec( a := <object>, b := <object>, c := <object> )
gap> GraphvizAddEdge(g, "c", "a");
<edge (c, a)>
gap> GraphvizAddEdge(g, "b", "d");
<edge (b, d)>
gap> GraphvizAddEdge(g, "d", "b");
<edge (d, b)>
gap> GraphvizAddEdge(g, "a", "b");
<edge (a, b)>
gap> GraphvizAddEdge(g, "b", "a");
<edge (b, a)>
gap> GraphvizAddEdge(g, "c", "d");
<edge (c, d)>
gap> g;
<graph with 4 nodes and 8 edges>

# Test removing node
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> c := GraphvizAddNode(g, "c");;
gap> d := GraphvizAddNode(g, "d");;
gap> GraphvizAddEdge(g, a, b);;
gap> GraphvizAddEdge(g, c, d);;
gap> GraphvizRemoveNode(g, a);
<graph with 3 nodes and 1 edge>
gap> GraphvizNodes(g);
rec( b := <object>, c := <object>, d := <object> )
gap> GraphvizEdges(g);
[ <edge (c, d)> ]
gap> GraphvizRemoveNode(g, b);
<graph with 2 nodes and 1 edge>
gap> GraphvizNodes(g);
rec( c := <object>, d := <object> )

# Test removing node
gap> g := GraphvizGraph();;
gap> GraphvizAddEdge(g, "a", "b");;
gap> GraphvizAddEdge(g, "c", "d");;
gap> GraphvizRemoveNode(g, "a");
<graph with 3 nodes and 1 edge>
gap> GraphvizNodes(g);
rec( b := <object>, c := <object>, d := <object> )
gap> GraphvizEdges(g);
[ <edge (c, d)> ]
gap> GraphvizRemoveNode(g, "b");
<graph with 2 nodes and 1 edge>
gap> GraphvizNodes(g);
rec( c := <object>, d := <object> )

# Test renaming graph
gap> g := GraphvizGraph();;
gap> GraphvizSetName(g, "test");
<graph test with 0 nodes and 0 edges>

# Test global attributes graph
gap> g := GraphvizGraph();;
gap> GraphvizSetName(g, "test");
<graph test with 0 nodes and 0 edges>

# Test global attributes graph
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "color", "red");;
gap> GraphvizAttrs(g);
[ "color=\"red\"" ]

# Test global attributes graph (duplicates)
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "color", "red");;
gap> GraphvizSetAttr(g, "color", "blue");;
gap> GraphvizAttrs(g);
[ "color=\"red\"", "color=\"blue\"" ]

# Test stringify attributes graph
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "color", "red");;
gap> GraphvizSetAttr(g, "color", "blue");;
gap> AsString(g);
"graph  {\n\tcolor=\"red\" color=\"blue\" \n}\n"

# # Test removing attributes from a graph
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

# Test gettting a node using bracket notation
gap> g := GraphvizGraph();;
gap> n1 := GraphvizAddNode(g, "test");;
gap> n2 := GraphvizAddNode(g, "abc");;
gap> g["test"];
<node test>
gap> g["abc"];
<node abc>

# Test gettting a node with a non-string name using bracket notation
gap> g := GraphvizGraph();;
gap> n1 := GraphvizAddNode(g, 1);;
gap> n2 := GraphvizAddNode(g, ["a"]);;
gap> g[1];
<node 1>
gap> g[["a"]];
<node [ "a" ]>

# Test making a graph with a non-string name
gap> g := GraphvizGraph(11);
<graph 11 with 0 nodes and 0 edges>

# Test setting a graph name to a non-string value
gap> g := GraphvizGraph(11);
<graph 11 with 0 nodes and 0 edges>
gap> GraphvizSetName(g, ["a"]);
<graph [ "a" ] with 0 nodes and 0 edges>

# Test making a digraph with a non-string name
gap> g := GraphvizDigraph(11);
<digraph 11 with 0 nodes and 0 edges>

# Test setting a digraph name to a non-string value
gap> g := GraphvizDigraph(11);
<digraph 11 with 0 nodes and 0 edges>
gap> GraphvizSetName(g, ["a"]);
<digraph [ "a" ] with 0 nodes and 0 edges>

#