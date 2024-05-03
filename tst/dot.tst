#############################################################################
##
##  dot.tst
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#@local a, b, color, e, g, label, n, shape
gap> START_TEST("graphviz package: dot.tst");
gap> LoadPackage("graphviz", false);;

# Test setting attributes
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "test");;
gap> GraphvizSetAttrs(n, rec(color := "red", label := "lab"));;
gap> GraphvizAttrs(n);
rec( color := "red", label := "lab" )
gap> GraphvizSetAttrs(n, rec(color := "blue"));;
gap> GraphvizAttrs(n);
rec( color := "blue", label := "lab" )

# Test globals
gap> g := GraphvizGraph();;
gap> GraphvizSetAttrs(g, rec(color := "red", shape := "circle"));;
gap> GraphvizAttrs(g);
[ "color=red", "shape=circle" ]
gap> GraphvizSetAttrs(g, rec(color := "blue", label := "test"));;
gap> GraphvizAttrs(g);
[ "color=red", "shape=circle", "label=test", "color=blue" ]

# Test stringify
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "test");;
gap> GraphvizSetAttrs(n, rec(color := "red", label := "lab"));;
gap> AsString(g);
"//dot\ngraph  {\n\ttest [color=red, label=lab]\n}\n"

# Test stringify with edge (digraphs)
gap> g := GraphvizDigraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> GraphvizSetAttrs(a, rec(color := "blue"));;
gap> GraphvizSetAttrs(b, rec(color := "red"));;
gap> e := GraphvizAddEdge(g, a, b);;
gap> GraphvizSetAttrs(e, rec(color := "green"));;
gap> AsString(g);
"//dot\ndigraph  {\n\ta [color=blue]\n\tb [color=red]\n\ta -> b [color=green]\
\n}\n"

# Test stringify with edge (graph)
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> GraphvizSetAttrs(a, rec(color := "blue"));;
gap> GraphvizSetAttrs(b, rec(color := "red"));;
gap> e := GraphvizAddEdge(g, a, b);;
gap> GraphvizSetAttrs(e, rec(color := "green"));;
gap> AsString(g);
"//dot\ngraph  {\n\ta [color=blue]\n\tb [color=red]\n\ta -- b [color=green]\n}\
\n"

# Test stringify empty
gap> g := GraphvizGraph();;
gap> AsString(g);
"//dot\ngraph  {\n}\n"

# Test unknown attributes (node)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetAttr(n, "test", "false");
#I  unknown attribute "test", the graphviz object may no longer be valid, it can be removed using GraphvizRemoveAttr
<graphviz node n>

# Test unknown attributes (graph)
gap> g := GraphvizGraph();;
gap> GraphvizSetAttr(g, "test", "false");
#I  unknown attribute "test", the graphviz object may no longer be valid, it can be removed using GraphvizRemoveAttr
<graphviz graph with 0 nodes and 0 edges>

# Test strngifying labels with ">>" inside (node attrs)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "node");;
gap> GraphvizSetAttr(n, "label", ">>hello");;
gap> AsString(g);
"//dot\ngraph  {\n\tnode [label=\">>hello\"]\n}\n"
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "node");;
gap> GraphvizSetAttr(n, "label", "before>>hello");;
gap> AsString(g);
"//dot\ngraph  {\n\tnode [label=\"before>>hello\"]\n}\n"

# Test strngifying labels with ">>" inside (edge attrs)
gap> g := GraphvizGraph();;
gap> e := GraphvizAddEdge(g, "a", "b");;
gap> GraphvizSetAttr(e, "label", ">>hello");;
gap> AsString(g);
"//dot\ngraph  {\n\ta\n\tb\n\ta -- b [label=\">>hello\"]\n}\n"
gap> g := GraphvizGraph();;
gap> e := GraphvizAddEdge(g, "a", "b");;
gap> GraphvizSetAttr(e, "label", "before>>hello");;
gap> AsString(g);
"//dot\ngraph  {\n\ta\n\tb\n\ta -- b [label=\"before>>hello\"]\n}\n"

#
gap> STOP_TEST("graphviz package: dot.tst", 0);
