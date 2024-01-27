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
gap> GV_Graph();
<graph with 0 nodes and 0 edges>

# Test graph constructor
gap> GV_Graph("test-name");
<graph test-name with 0 nodes and 0 edges>

# Test digraph printing
gap> x := GV_Graph("test-name");;
gap> GV_Type(x, GV_DIGRAPH);
<digraph test-name with 0 nodes and 0 edges>
gap> x := GV_Graph();;
gap> GV_Type(x, GV_DIGRAPH);
<digraph with 0 nodes and 0 edges>

# Test node attrs
gap> g := GV_Graph("test");;
gap> GV_NodeAttrs(g, rec( color := "red", shape := "square" ));;
gap> GV_NodeAttrs(g);
rec( color := "red", shape := "square" )
gap> GV_NodeAttrs(g, rec( color := "blue", shape := "square" ));;
gap> GV_NodeAttrs(g);
rec( color := "blue", shape := "square" )

# Test edge attrs
gap> g := GV_Graph("test");;
gap> GV_EdgeAttrs(g, rec( color := "red", shape := "square" ));;
gap> GV_EdgeAttrs(g);
rec( color := "red", shape := "square" )
gap> GV_EdgeAttrs(g, rec( color := "blue", shape := "square" ));;
gap> GV_EdgeAttrs(g);
rec( color := "blue", shape := "square" )

# Test adding nodes
gap> g := GV_Graph();;
gap> n := GV_Node("n");;
gap> GV_AddNode(g, n);
<graph with 1 node and 0 edges>
gap> GV_Nodes(g);
rec( n := <node n> )
gap> GV_AddNode(g, n);
FAIL: Already node with name n.
fail
gap> GV_AddNode(g, GV_Node("x"));
<graph with 2 nodes and 0 edges>
gap> GV_Nodes(g);
rec( n := <node n>, x := <node x> )

# Test has nodes
gap> g := GV_Graph();;
gap> n := GV_Node("n");;
gap> GV_AddNode(g, n);;
gap> GV_HasNode(g, "n");
true
gap> GV_HasNode(g, "x");
false

# Test adding edges
gap> g := GV_Graph();;
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> c := GV_Node("c");;
gap> d := GV_Node("d");;
gap> ab := GV_Edge(a, b);;
gap> cd := GV_Edge(c, d);;
gap> GV_AddEdge(g, ab);
<graph with 2 nodes and 1 edge>
gap> GV_Edges(g);
[ <edge (a, b)> ]
gap> GV_AddNode(g, c);;
gap> GV_AddNode(g, d);;
gap> GV_AddEdge(g, cd);
<graph with 4 nodes and 2 edges>
gap> GV_Edges(g);
[ <edge (c, d)>, <edge (a, b)> ]

# Test removing node
gap> g := GV_Graph();;
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> c := GV_Node("c");;
gap> d := GV_Node("d");;
gap> ab := GV_Edge(a, b);;
gap> cd := GV_Edge(c, d);;
gap> GV_AddEdge(g, ab);;
gap> GV_AddEdge(g, cd);;
gap> GV_RemoveNode(g, a);
<graph with 3 nodes and 1 edge>
gap> GV_Nodes(g);
rec( b := <node b>, c := <node c>, d := <node d> )
gap> GV_Edges(g);
[ <edge (c, d)> ]
gap> GV_RemoveNode(g, b);
<graph with 2 nodes and 1 edge>
gap> GV_Nodes(g);
rec( c := <node c>, d := <node d> )

# Test renaming graph
gap> g := GV_Graph();;
gap> GV_Name(g, "test");
<graph test with 0 nodes and 0 edges>

#