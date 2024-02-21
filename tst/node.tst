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
gap> GV_Node("test-node");
<node test-node>

# Test renaming nodes fails
gap> n := GV_Node("a");;
gap> GV_Name(n, "test");
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `GV_Name' on 2 arguments

# Test making a node with an all whitespace name
gap> n := GV_Node("  ");
<node   >

# Test making a node with empty name fails
gap> n := GV_Node("");
Error, Node name cannot be empty.

# Test whitespace in node names
gap> n := GV_Node("a  a   ");
<node a  a   >

# Test modifying attributes
gap> n := GV_Node("t");;
gap> GV_SetAttrs(n, rec( color := "red" ));;
gap> GV_SetAttrs(n, rec( color := "blue", shape := "round" ));;
gap> GV_Attrs(n);
HashMap([[ "color", "blue" ], [ "shape", "round" ]])
gap> GV_SetAttrs(n, rec( color := "green", label := "test" ));;
gap> GV_Attrs(n);
HashMap([[ "color", "green" ], [ "shape", "round" ], [ "label", "test" ]])

# Test removing attributes
gap> n := GV_Node("t");;
gap> GV_SetAttrs(n, rec( color := "red", shape := "circle" ));;
gap> GV_RemoveAttr(n, "color");;
gap> GV_Attrs(n);
HashMap([[ "shape", "circle" ]])

#
