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
gap> n := GV_AddNode(g, "n");
<node n>
gap> g;
<graph with 1 node and 0 edges>
gap> GV_Nodes(g);
HashMap([[ "n", <object> ]])
gap> GV_AddNode(g, "x");
<node x>
gap> g;
<graph with 2 nodes and 0 edges>
gap> GV_Nodes(g);
HashMap([[ "n", <object> ], [ "x", <object> ]])

# Test add node (name)
gap> g := GV_Graph();;
gap> GV_AddNode(g, "n");
<node n>
gap> GV_Nodes(g);
HashMap([[ "n", <object> ]])
gap> GV_AddNode(g, "x");
<node x>
gap> GV_Nodes(g);
HashMap([[ "n", <object> ], [ "x", <object> ]])

# Test has nodes
gap> g := GV_Graph();;
gap> n := GV_AddNode(g, "n");
<node n>
gap> GV_HasNode(g, "n");
true
gap> GV_HasNode(g, "x");
false

# Test adding edges
gap> g := GV_Graph();;
gap> a := GV_AddNode(g, "a");;
gap> b := GV_AddNode(g, "b");;
gap> ab := GV_AddEdge(g, a, b);;
gap> g;
<graph with 2 nodes and 1 edge>
gap> GV_Edges(g);
[ <edge (a, b)> ]
gap> c := GV_AddNode(g, "c");;
gap> d := GV_AddNode(g, "d");;
gap> cd := GV_AddEdge(g, c, d);;
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
gap> a := GV_AddNode(g, "a");;
gap> b := GV_AddNode(g, "b");;
gap> c := GV_AddNode(g, "c");;
gap> d := GV_AddNode(g, "d");;
gap> GV_AddEdge(g, a, b);;
gap> GV_AddEdge(g, c, d);;
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
gap> g := GV_Graph();;
gap> n1 := GV_AddNode(g, "test");;
gap> n2 := GV_AddNode(g, "abc");;
gap> g["test"];
<node test>
gap> g["abc"];
<node abc>

# Test gettting a node with a non-string name using bracket notation
gap> g := GV_Graph();;
gap> n1 := GV_AddNode(g, 1);;
gap> n2 := GV_AddNode(g, ["a"]);;
gap> g[1];
<node 1>
gap> g[["a"]];
<node [ "a" ]>

# Test making a graph with a non-string name
gap> g := GV_Graph(11);
<graph 11 with 0 nodes and 0 edges>

# Test setting a graph name to a non-string value
gap> g := GV_Graph(11);
<graph 11 with 0 nodes and 0 edges>
gap> GV_SetName(g, ["a"]);
<graph [ "a" ] with 0 nodes and 0 edges>

# Test making a digraph with a non-string name
gap> g := GV_Digraph(11);
<digraph 11 with 0 nodes and 0 edges>

# Test setting a digraph name to a non-string value
gap> g := GV_Digraph(11);
<digraph 11 with 0 nodes and 0 edges>
gap> GV_SetName(g, ["a"]);
<digraph [ "a" ] with 0 nodes and 0 edges>

#