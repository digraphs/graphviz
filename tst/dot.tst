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
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "test");;
gap> GraphvizSetAttrs(n, rec(color:="red", label:="lab"));;
gap> GraphvizAttrs(n);
rec( color := "red", label := "lab" )
gap> GraphvizSetAttrs(n, rec(color:="blue"));;
gap> GraphvizAttrs(n);
rec( color := "blue", label := "lab" )

# Test globals
gap> g := GraphvizGraph();;
gap> GraphvizSetAttrs(g, rec( color := "red", shape := "circle" ));;
gap> GraphvizAttrs(g);
[ "color=red", "shape=circle" ]
gap> GraphvizSetAttrs(g, rec( color := "blue", label := "test" ));;
gap> GraphvizAttrs(g);
[ "color=red", "shape=circle", "label=test", "color=blue" ]

# Test stringify
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "test");;
gap> GraphvizSetAttrs(n, rec(color:="red", label:="lab"));;
gap> AsString(g);
"graph  {\n\ttest [color=red, label=lab]\n}\n"

# Test stringify with edge (digraphs)
gap> g := GraphvizDigraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> GraphvizSetAttrs(a, rec(color:="blue"));;
gap> GraphvizSetAttrs(b, rec(color:="red"));;
gap> e := GraphvizAddEdge(g, a, b);;
gap> GraphvizSetAttrs(e, rec(color:="green"));;
gap> AsString(g);
"digraph  {\n\ta [color=blue]\n\tb [color=red]\n\ta -> b [color=green]\n}\n"

# Test stringify with edge (graph)
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> GraphvizSetAttrs(a, rec(color:="blue"));;
gap> GraphvizSetAttrs(b, rec(color:="red"));;
gap> e := GraphvizAddEdge(g, a, b);;
gap> GraphvizSetAttrs(e, rec(color:="green"));;
gap> AsString(g);
"graph  {\n\ta [color=blue]\n\tb [color=red]\n\ta -- b [color=green]\n}\n"

# Test stringify empty
gap> g := GraphvizGraph();;
gap> AsString(g);
"graph  {\n}\n"

# Test unknown attributes (node)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetAttr(n, "test", "false");
[WARNING] Unknown attribute test
<graphviz node n>

# Test unknown attributes (graph)
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "test", "false");
[WARNING] Unknown attribute test
<graphviz graph with 0 nodes and 0 edges>

#
gap> STOP_TEST("Digraphs package: standard/oper.tst", 0);
