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

# Test digraph printing constructor
gap> x := GV_Graph("test-name");;
gap> GV_Type(x, GV_DIGRAPH);
<digraph test-name with 0 nodes and 0 edges>
gap> x := GV_Graph();;
gap> GV_Type(x, GV_DIGRAPH);
<digraph with 0 nodes and 0 edges>

# Test node constructor
gap> GV_Node("test-node", rec(color := "red"));
<node test-node>
gap> GV_Attrs(n);
rec( color := "red" )

#
