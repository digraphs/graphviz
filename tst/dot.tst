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

# Test gloabals
gap> g := GV_Graph();;
gap> GV_Attrs(g, rec( color := "red", shape := "circle" ));;
gap> GV_NodeAttrs(g, rec( color := "red", shape := "circle" ));;
gap> GV_EdgeAttrs(g, rec( color := "red", shape := "circle" ));;
gap> GV_Attrs(g);
rec( color := "red", shape := "circle" )
gap> GV_NodeAttrs(g);
rec( color := "red", shape := "circle" )
gap> GV_EdgeAttrs(g);
rec( color := "red", shape := "circle" )
gap> GV_Attrs(g, rec( color := "blue", label := "test" ));;
gap> GV_NodeAttrs(g, rec( color := "blue", label := "test" ));;
gap> GV_EdgeAttrs(g, rec( color := "blue", label := "test" ));;
gap> GV_Attrs(g);
rec( color := "blue", label := "test", shape := "circle" )
gap> GV_NodeAttrs(g);
rec( color := "blue", label := "test", shape := "circle" )
gap> GV_EdgeAttrs(g);
rec( color := "blue", label := "test", shape := "circle" )

# Test stringify
gap> n := GV_Node("test");;
gap> GV_Attrs(n, rec(color:="red", label:="lab"));;
gap> g := GV_Graph();;
gap> GV_AddNode(g, n);;
gap> GV_String(g);
"graph  {\n\ttest [label=\"lab\", color=red]\n}\n"

# Test stringify with edge (and digraphs)
gap> g := GV_Graph();;
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> GV_Attrs(a, rec(color:="blue"));;
gap> GV_Attrs(b, rec(color:="red"));;
gap> e := GV_Edge(a, b);;
gap> GV_Attrs(e, rec(color:="green"));;
gap> GV_AddEdge(g, e);;
gap> GV_String(g);
"graph  {\n\tb [color=red]\n\ta [color=blue]\n\tb -- a [color=green]\n}\n"
gap> GV_Type(g, GV_DIGRAPH);;
gap> GV_String(g);
"digraph  {\n\tb [color=red]\n\ta [color=blue]\n\tb -> a [color=green]\n}\n"

# Test stringify global attrs
gap> g := GV_Graph("name");;
gap> GV_Attrs(g, rec(color := "red"));;
gap> GV_NodeAttrs(g, rec(color := "green"));;
gap> GV_EdgeAttrs(g, rec(color := "blue"));;
gap> GV_String(g);
"graph name {\n\tcolor=\"red\" \n\tnode [color=green]\n\tedge [color=blue]\n}\
\n"

# Test stringify complex
gap> g := GV_Graph("name");;
gap> GV_Attrs(g, rec(color := "red"));;
gap> GV_NodeAttrs(g, rec(color := "green"));;
gap> GV_EdgeAttrs(g, rec(color := "blue"));;
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> GV_Attrs(a, rec(color:="blue"));;
gap> GV_Attrs(b, rec(color:="red"));;
gap> e := GV_Edge(a, b);;
gap> GV_Attrs(e, rec(color:="green"));;
gap> GV_AddEdge(g, e);;
gap> GV_String(g);
"graph name {\n\tcolor=\"red\" \n\tnode [color=green]\n\tedge [color=blue]\n\t\
b [color=red]\n\ta [color=blue]\n\tb -- a [color=green]\n}\n"

#
gap> STOP_TEST("Digraphs package: standard/oper.tst", 0);
