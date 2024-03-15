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
gap> GraphvizAddNode(GraphvizGraph(), "test-node");
<node test-node>

# Test renaming nodes fails
gap> n := GraphvizNode(GraphvizGraph(), "a");;
gap> GraphvizName(n, "test");
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `GraphvizName' on 2 arguments

# Test making a node with an all whitespace name
gap> n := GraphvizAddNode(GraphvizGraph(), "  ");
<node   >

# Test making a node with empty name fails
gap> n := GraphvizAddNode(GraphvizGraph(), "");
Error, Node name cannot be empty.

# Test whitespace in node names
gap> n := GraphvizAddNode(GraphvizGraph(), "a  a   ");
<node a  a   >

# Test modifying attributes
gap> n := GraphvizAddNode(GraphvizGraph(), "t");;
gap> GraphvizSetAttrs(n, rec( color := "red" ));;
gap> GraphvizSetAttrs(n, rec( color := "blue", shape := "round" ));;
gap> GraphvizAttrs(n);
rec( color := "blue", shape := "round" )
gap> GraphvizSetAttrs(n, rec( color := "green", label := "test" ));;
gap> GraphvizAttrs(n);
rec( color := "green", label := "test", shape := "round" )

# Test removing attributes
gap> n := GraphvizNode(GraphvizGraph(), "t");;
gap> GraphvizSetAttrs(n, rec( color := "red", shape := "circle" ));;
gap> GraphvizRemoveAttr(n, "color");;
gap> GraphvizAttrs(n);
rec( shape := "circle" )

# Test name containing ':'
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, "test:colon");;
gap> AsString(g);
"graph  {\n\t\"test\":colon\n}\n"

# Test non-string name containing ':'
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, 111);
<node 111>
gap> AsString(g);
"graph  {\n\t\"111\"\n}\n"

# Test removing a node with a non-string name
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, 111);;
gap> GraphvizRemoveNode(g, 111);;
gap> GraphvizNodes(g);
rec(  )

# Test setting attributes using the []:= syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizNode(g, "a");;
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
gap> n := GraphvizNode(g, "a");;
gap> n["color"] := "red";;
gap> n["color"];
"red"

# Test set label (node)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetLabel(n, "test");;
gap> GraphvizAttrs(n);
rec( label := "test" )

# Test set color (node)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetColor(n, "red");;
gap> GraphvizAttrs(n);
rec( color := "red" )

#
