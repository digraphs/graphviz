#############################################################################
##
##  dot.tst
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#@local a, b, color, e, g, gv, label, n, shape, G, D
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
[ "shape=circle", "label=test", "color=blue" ]

# Test stringify
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "test");;
gap> GraphvizSetAttrs(n, rec(color := "red", label := "lab"));;
gap> AsString(g);
"//dot\ngraph  {\n\ttest [color=red, label=lab]\n}\n"
gap> GraphvizRemoveNode(g, "banana");
Error, the 2nd argument (node name string) "banana" is not a node of the 1st a\
rgument (a graphviz (di)graph/context)

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
<graphviz node "n">

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

# Test GraphvizSetNodeLabels
gap> gv := GraphvizGraph("xxx");
<graphviz graph "xxx" with 0 nodes and 0 edges>
gap> GraphvizAddNode(gv, 1);
<graphviz node "1">
gap> GraphvizAddNode(gv, 2);
<graphviz node "2">
gap> GraphvizAddNode(gv, 3);
<graphviz node "3">
gap> GraphvizSetNodeLabels(gv, ["i", "ii", "iii"]);
<graphviz graph "xxx" with 3 nodes and 0 edges>
gap> Print(AsString(gv));
//dot
graph xxx {
	1 [label="i"]
	2 [label="ii"]
	3 [label="iii"]
}
gap> GraphvizSetNodeLabels(gv, ["a", "b", "c"]);
<graphviz graph "xxx" with 3 nodes and 0 edges>
gap> Print(AsString(gv));
//dot
graph xxx {
	1 [label="a"]
	2 [label="b"]
	3 [label="c"]
}
gap> GraphvizSetNodeLabels(gv, ["i", "ii"]);
Error, the 2nd argument (list of node labels) has incorrect length, expected 3\
, but found 2
gap> GraphvizSetNodeLabels(gv, ["i", "ii", "iii", "iv"]);
Error, the 2nd argument (list of node labels) has incorrect length, expected 3\
, but found 4

# Test GraphvizSetNodeColors
gap> gv := GraphvizGraph("xxx");
<graphviz graph "xxx" with 0 nodes and 0 edges>
gap> GraphvizAddNode(gv, 1);
<graphviz node "1">
gap> GraphvizAddNode(gv, 2);
<graphviz node "2">
gap> GraphvizAddNode(gv, 3);
<graphviz node "3">
#@if CompareVersionNumbers(GAPInfo.Version, "4.12")
gap> GraphvizSetNodeColors(gv, ["i", "ii", "iii"]);
Error, invalid color "i" (list (string)), valid colors are RGB values or names\
 from the GraphViz 2.44.1 X11 Color Scheme http://graphviz.org/doc/info/colors\
.html
#@else
gap> GraphvizSetNodeColors(gv, ["i", "ii", "iii"]);
Error, invalid color "i" (list (string)), valid colors are RGB values or names\
 from the GraphViz 2.44.1 X11 Color Sch\
eme http://graphviz.org/doc/info/colors.html
#@fi
gap> GraphvizSetNodeColors(gv, ["red", "green", "blue"]);
<graphviz graph "xxx" with 3 nodes and 0 edges>
gap> Print(AsString(gv));
//dot
graph xxx {
	1 [color=red, style=filled]
	2 [color=green, style=filled]
	3 [color=blue, style=filled]
}
gap> GraphvizSetNodeColors(gv, ["red", "#00FF00", "blue"]);
<graphviz graph "xxx" with 3 nodes and 0 edges>
gap> Print(AsString(gv));
//dot
graph xxx {
	1 [color=red, style=filled]
	2 [color="#00FF00", style=filled]
	3 [color=blue, style=filled]
}
gap> GraphvizSetNodeColors(gv, ["#FF0000", "#00FF00", "#0000FF"]);
<graphviz graph "xxx" with 3 nodes and 0 edges>
gap> Print(AsString(gv));
//dot
graph xxx {
	1 [color="#FF0000", style=filled]
	2 [color="#00FF00", style=filled]
	3 [color="#0000FF", style=filled]
}
#@if CompareVersionNumbers(GAPInfo.Version, "4.12")
gap> GraphvizSetNodeColors(gv, ["#FF0000", "#00FF00", "#0000FG"]);
Error, invalid color "#0000FG" (list (string)), valid colors are RGB values or\
 names from the GraphViz 2.44.1 X11 Color Scheme http://graphviz.org/doc/info/\
colors.html
#@else
gap> GraphvizSetNodeColors(gv, ["#FF0000", "#00FF00", "#0000FG"]);
Error, invalid color "#0000FG" (list (string)), valid colors are RGB values or\
 names from the GraphViz 2.44.1 X11 Color Sch\
eme http://graphviz.org/doc/info/colors.html
#@fi
gap> GraphvizSetNodeColors(gv, ["#FF0000", "#00FF00"]);
Error, the number of node colors must be the same as the number of nodes, expe\
cted 3 but found 2
gap> GraphvizAddEdge(gv, "a", "b");
<graphviz edge (a, b)>
gap> GraphvizNodes(gv);
rec( 1 := <graphviz node "1">, 2 := <graphviz node "2">, 
  3 := <graphviz node "3">, a := <graphviz node "a">, 
  b := <graphviz node "b"> )

# Test attribute names with spaces (TODO are there any valid such??)
gap> gv := GraphvizGraph("xxx");
<graphviz graph "xxx" with 0 nodes and 0 edges>
gap> n := GraphvizAddNode(gv, 1);
<graphviz node "1">
gap> n := GraphvizSetAttr(n, "probably not ok", 1);
#I  unknown attribute "probably not ok", the graphviz object may no longer be valid, it can be removed using GraphvizRemoveAttr
<graphviz node "1">
gap> Print(AsString(gv));
//dot
graph xxx {
	1 ["probably not ok"=1]
}
gap> GraphvizSetAttr(n, "label", "<<>>");
<graphviz node "1">
gap> Print(AsString(gv));
//dot
graph xxx {
	1 [label=<<>>, "probably not ok"=1]
}