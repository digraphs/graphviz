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

#
