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
gap> x := GV_Digraph("test-name");
<digraph test-name with 0 nodes and 0 edges>
gap> x := GV_Digraph();
<digraph with 0 nodes and 0 edges>

# Test adding nodes
gap> g := GV_Graph();;
gap> n := GV_Node("n");;
gap> GV_AddNode(g, n);
<graph with 1 node and 0 edges>
gap> GV_Nodes(g);
HashMap([[ "n", <object> ]])
gap> GV_AddNode(g, n);
<graph with 1 node and 0 edges>
gap> GV_AddNode(g, GV_Node("x"));
<graph with 2 nodes and 0 edges>
gap> GV_Nodes(g);
HashMap([[ "n", <object> ], [ "x", <object> ]])

# Test add node (name)
gap> g := GV_Graph();;
gap> GV_AddNode(g, "n");
<node n>
gap> GV_Nodes(g);
HashMap([[ "n", <object> ]])
gap> GV_AddNode(g, "n");
<node n>
gap> GV_AddNode(g, "x");
<node x>
gap> GV_Nodes(g);
HashMap([[ "n", <object> ], [ "x", <object> ]])

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
[ <edge (a, b)>, <edge (c, d)> ]

# Test adding edges (two nodes)
gap> g := GV_Graph();;
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> c := GV_Node("c");;
gap> d := GV_Node("d");;
gap> GV_AddEdge(g, a, b);
<edge (a, b)>
gap> g;
<graph with 2 nodes and 1 edge>
gap> GV_Edges(g);
[ <edge (a, b)> ]
gap> GV_AddNode(g, c);;
gap> GV_AddNode(g, d);;
gap> GV_AddEdge(g, c, d);
<edge (c, d)>
gap> g;
<graph with 4 nodes and 2 edges>
gap> GV_Edges(g);
[ <edge (a, b)>, <edge (c, d)> ]

# Test adding edges (two strings)
gap> g := GV_Graph();;
gap> GV_AddEdge(g, "a", "b");
<edge (a, b)>
gap> g;
<graph with 2 nodes and 1 edge>
gap> GV_Edges(g);
[ <edge (a, b)> ]
gap> GV_AddEdge(g, "c", "d");
<edge (c, d)>
gap> g;
<graph with 4 nodes and 2 edges>
gap> GV_Edges(g);
[ <edge (a, b)>, <edge (c, d)> ]

# Test adding edge with different nodes with the same name
gap> g := GV_Graph();;
gap> GV_AddEdge(g, "a", "b");;
gap> GV_AddEdge(g, "a", "c");
<edge (a, c)>
gap> GV_Nodes(g);
HashMap([[ "c", <object> ], [ "a", <object> ], [ "b", <object> ]])
gap> GV_AddEdge(g, "c", "a");
<edge (c, a)>
gap> GV_AddEdge(g, "b", "d");
<edge (b, d)>
gap> GV_AddEdge(g, "d", "b");
<edge (d, b)>
gap> GV_AddEdge(g, "a", "b");
<edge (a, b)>
gap> GV_AddEdge(g, "b", "a");
<edge (b, a)>
gap> GV_AddEdge(g, "c", "d");
<edge (c, d)>
gap> g;
<graph with 4 nodes and 8 edges>

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
HashMap([[ "c", <object> ], [ "d", <object> ], [ "b", <object> ]])
gap> GV_Edges(g);
[ <edge (c, d)> ]
gap> GV_RemoveNode(g, b);
<graph with 2 nodes and 1 edge>
gap> GV_Nodes(g);
HashMap([[ "c", <object> ], [ "d", <object> ]])

# Test removing node
gap> g := GV_Graph();;
gap> GV_AddEdge(g, "a", "b");;
gap> GV_AddEdge(g, "c", "d");;
gap> GV_RemoveNode(g, "a");
<graph with 3 nodes and 1 edge>
gap> GV_Nodes(g);
HashMap([[ "c", <object> ], [ "d", <object> ], [ "b", <object> ]])
gap> GV_Edges(g);
[ <edge (c, d)> ]
gap> GV_RemoveNode(g, "b");
<graph with 2 nodes and 1 edge>
gap> GV_Nodes(g);
HashMap([[ "c", <object> ], [ "d", <object> ]])

# Test renaming graph
gap> g := GV_Graph();;
gap> GV_SetName(g, "test");
<graph test with 0 nodes and 0 edges>

# Test global attributes graph
gap> g := GV_Graph();;
gap> GV_SetName(g, "test");
<graph test with 0 nodes and 0 edges>

# Test global attributes graph
gap> g := GV_Graph();;
gap> GV_SetAttr(g, "color", "red");;
gap> GV_Attrs(g);
[ "color=\"red\"" ]

# Test global attributes graph (duplicates)
gap> g := GV_Graph();;
gap> GV_SetAttr(g, "color", "red");;
gap> GV_SetAttr(g, "color", "blue");;
gap> GV_Attrs(g);
[ "color=\"red\"", "color=\"blue\"" ]

# Test stringify attributes graph
gap> g := GV_Graph();;
gap> GV_SetAttr(g, "color", "red");;
gap> GV_SetAttr(g, "color", "blue");;
gap> GV_String(g);
"graph  {\n\tcolor=\"red\" color=\"blue\" \n}\n"

# # Test removing attributes from a graph
# gap> g := GV_Graph();;
# gap> GV_SetAttr(g, "color", "red");;
# gap> GV_SetAttr(g, "shape", "circle");;
# gap> GV_RemoveAttr(g, "color");;
# gap> GV_Attrs(g);
# [ "color=\"blue\"" ]
# gap> GV_SetAttr(g, "shape", "square");;
# gap> GV_RemoveAttr(g, "shape");;
# gap> GV_Attrs(g);
# [  ]

# Test gettting a node using bracket notation
gap> n1 := GV_Node("test");;
gap> n2 := GV_Node("abc");;
gap> g := GV_Graph();;
gap> GV_AddNode(g, n1);;
gap> GV_AddNode(g, n2);;
gap> g["test"];
<node test>
gap> g["abc"];
<node abc>

#