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

# Test setting attributes
gap> n := GV_Node("test");;
gap> GV_Attrs(n, rec(color:="red", label:="lab"));;
gap> GV_Attrs(n);
rec( color := "red", label := "lab" )
gap> GV_Attrs(n, rec(color:="blue"));;
gap> GV_Attrs(n);
rec( color := "blue", label := "lab" )

#
gap> STOP_TEST("Digraphs package: standard/oper.tst", 0);
