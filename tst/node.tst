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

# Test node constructor
gap> GV_AddNode(GV_Graph(), "test-node");
<node test-node>

# Test renaming nodes fails
gap> n := GV_Node(GV_Graph(), "a");;
gap> GV_Name(n, "test");
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `GV_Name' on 2 arguments

# Test making a node with an all whitespace name
gap> n := GV_AddNode(GV_Graph(), "  ");
<node   >

# Test making a node with empty name fails
gap> n := GV_AddNode(GV_Graph(), "");
Error, Node name cannot be empty.

# Test whitespace in node names
gap> n := GV_AddNode(GV_Graph(), "a  a   ");
<node a  a   >

# Test modifying attributes
gap> n := GV_AddNode(GV_Graph(), "t");;
gap> GV_SetAttrs(n, rec( color := "red" ));;
gap> GV_SetAttrs(n, rec( color := "blue", shape := "round" ));;
gap> GV_Attrs(n);
HashMap([[ "color", "blue" ], [ "shape", "round" ]])
gap> GV_SetAttrs(n, rec( color := "green", label := "test" ));;
gap> GV_Attrs(n);
HashMap([[ "color", "green" ], [ "shape", "round" ], [ "label", "test" ]])

# Test removing attributes
gap> n := GV_Node(GV_Graph(), "t");;
gap> GV_SetAttrs(n, rec( color := "red", shape := "circle" ));;
gap> GV_RemoveAttr(n, "color");;
gap> GV_Attrs(n);
HashMap([[ "shape", "circle" ]])

# Test name containing ':'
gap> g := GV_Graph();;
gap> GV_AddNode(g, "test:colon");;
gap> AsString(g);
"graph  {\n\t\"test\":colon\n}\n"

# Test non-string name containing ':'
gap> g := GV_Graph();;
gap> GV_AddNode(g, 111);
<node 111>
gap> AsString(g);
"graph  {\n\t\"111\"\n}\n"

# Test removing a node with a non-string name
gap> g := GV_Graph();;
gap> GV_AddNode(g, 111);;
gap> GV_RemoveNode(g, 111);;
gap> GV_Nodes(g);
HashMap([])

# Test setting attributes using the []:= syntax
gap> g := GV_Graph();;
gap> n := GV_Node(g, "a");;
gap> n["color"] := "red";;
gap> GV_Attrs(n);
HashMap([[ "color", "red" ]])
gap> n["label"] := 1;;
gap> GV_Attrs(n);
HashMap([[ "color", "red" ], [ "label", "1" ]])
gap> n["color"] := "blue";;
gap> GV_Attrs(n);
HashMap([[ "color", "blue" ], [ "label", "1" ]])

# Test getting attributes using the [] syntax
gap> g := GV_Graph();;
gap> n := GV_Node(g, "a");;
gap> n["color"] := "red";;
gap> n["color"];
"red"

#
