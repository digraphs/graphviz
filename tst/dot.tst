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
gap> g := GV_Graph();;
gap> n := GV_AddNode(g, "test");;
gap> GV_SetAttrs(n, rec(color:="red", label:="lab"));;
gap> GV_Attrs(n);
HashMap([[ "color", "red" ], [ "label", "lab" ]])
gap> GV_SetAttrs(n, rec(color:="blue"));;
gap> GV_Attrs(n);
HashMap([[ "color", "blue" ], [ "label", "lab" ]])

# Test globals
gap> g := GV_Graph();;
gap> GV_SetAttrs(g, rec( color := "red", shape := "circle" ));;
gap> GV_Attrs(g);
[ "color=\"red\"", "shape=\"circle\"" ]
gap> GV_SetAttrs(g, rec( color := "blue", label := "test" ));;
gap> GV_Attrs(g);
[ "color=\"red\"", "shape=\"circle\"", "label=test", "color=\"blue\"" ]

# Test stringify
gap> g := GV_Graph();;
gap> n := GV_AddNode(g, "test");;
gap> GV_SetAttrs(n, rec(color:="red", label:="lab"));;
gap> AsString(g);
"graph  {\n\t\"test\" [color=\"red\", label=lab]\n}\n"

# Test stringify with edge (digraphs)
gap> g := GV_Digraph();;
gap> a := GV_AddNode(g, "a");;
gap> b := GV_AddNode(g, "b");;
gap> GV_SetAttrs(a, rec(color:="blue"));;
gap> GV_SetAttrs(b, rec(color:="red"));;
gap> e := GV_AddEdge(g, a, b);;
gap> GV_SetAttrs(e, rec(color:="green"));;
gap> AsString(g);
"digraph  {\n\t\"a\" [color=\"blue\"]\n\t\"b\" [color=\"red\"]\n\t\"a\" -> \"b\
\" [color=\"green\"]\n}\n"

# Test stringify with edge (graph)
gap> g := GV_Graph();;
gap> a := GV_AddNode(g, "a");;
gap> b := GV_AddNode(g, "b");;
gap> GV_SetAttrs(a, rec(color:="blue"));;
gap> GV_SetAttrs(b, rec(color:="red"));;
gap> e := GV_AddEdge(g, a, b);;
gap> GV_SetAttrs(e, rec(color:="green"));;
gap> AsString(g);
"graph  {\n\t\"a\" [color=\"blue\"]\n\t\"b\" [color=\"red\"]\n\t\"a\" -- \"b\"\
 [color=\"green\"]\n}\n"

# Test stringify empty
gap> g := GV_Graph();;
gap> AsString(g);
"graph  {\n}\n"

#
gap> STOP_TEST("Digraphs package: standard/oper.tst", 0);
