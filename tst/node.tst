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

# Test node constructor
gap> n := GV_Node("test-node", rec(color := "red"));
<node test-node>
gap> GV_Attrs(n);
rec( color := "red" )

# Test renaming nodes fails
gap> n := GV_Node("a");;
gap> GV_Name(n, "test");
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `GV_Name' on 2 arguments

# Test making a node with a whitespace name fails
gap> n := GV_Node("");
fail
gap> n := GV_Node("  ");
fail

# Test whitespace is removed from node names
gap> n := GV_Node("a  a   ");
<node aa>

# Test modifying attributes
gap> n := GV_Node("t", rec( color := "red" ));;
gap> GV_Attrs(n, rec( color := "blue", shape := "round" ));;
gap> GV_Attrs(n);
rec( color := "blue", shape := "round" )
gap> GV_Attrs(n, rec( color := "green", label := "test" ));;
gap> GV_Attrs(n);
rec( color := "green", label := "test", shape := "round" )

# Test removing attributes
gap> n := GV_Node("t", rec( color := "red", shape := "circle" ));;
gap> GV_RemoveAttr(n, "color");;
gap> GV_Attrs(n);
rec( shape := "circle" )

#
