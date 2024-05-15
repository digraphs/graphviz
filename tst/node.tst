#############################################################################
##
##  node.tst
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#@local color, g, label, n, s, shape
gap> START_TEST("graphviz package: node.tst");
gap> LoadPackage("graphviz", false);;

# Test node constructor
gap> GraphvizAddNode(GraphvizGraph(), "test-node");
<graphviz node test-node>

# Test renaming nodes fails
gap> n := GraphvizAddNode(GraphvizGraph(), "a");;
gap> GraphvizName(n, "test");
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `GraphvizName' on 2 arguments

# Test making a node with an all whitespace name
gap> n := GraphvizAddNode(GraphvizGraph(), "  ");
<graphviz node   >

# Test making a node with empty name fails
gap> n := GraphvizAddNode(GraphvizGraph(), "");
Error, the 2nd argument (string/node name) cannot be empty

# Test whitespace in node names
gap> n := GraphvizAddNode(GraphvizGraph(), "a  a   ");
<graphviz node a  a   >

# Test modifying attributes
gap> n := GraphvizAddNode(GraphvizGraph(), "t");;
gap> GraphvizSetAttrs(n, rec(color := "red"));;
gap> GraphvizSetAttrs(n, rec(color := "blue", shape := "round"));;
gap> GraphvizAttrs(n);
rec( color := "blue", shape := "round" )
gap> GraphvizSetAttrs(n, rec(color := "green", label := "test"));;
gap> GraphvizAttrs(n);
rec( color := "green", label := "test", shape := "round" )

# Test removing attributes
gap> n := GraphvizAddNode(GraphvizGraph(), "t");;
gap> GraphvizSetAttrs(n, rec(color := "red", shape := "circle"));;
gap> GraphvizRemoveAttr(n, "color");;
gap> GraphvizAttrs(n);
rec( shape := "circle" )

# Test name containing ':'
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, "test:colon");;
gap> AsString(g);
"//dot\ngraph  {\n\ttest:colon\n}\n"

# Test non-string name containing ':'
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, 111);
<graphviz node 111>
gap> AsString(g);
"//dot\ngraph  {\n\t111\n}\n"

# Test removing a node with a non-string name
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, 111);;
gap> GraphvizRemoveNode(g, 111);;
gap> GraphvizNodes(g);
rec(  )

# Test setting attributes using the []:= syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "a");;
gap> n["color"] := "red";;
gap> GraphvizAttrs(n);
rec( color := "red" )
gap> n["label"] := 1;;
gap> GraphvizAttrs(n);
rec( color := "red", label := "1" )
gap> n["color"] := "blue";;
gap> GraphvizAttrs(n);
rec( color := "blue", label := "1" )

# Test getting attributes using the [] syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "a");;
gap> n["color"] := "red";;
gap> n["color"];
"red"

# Test set label (node)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetLabel(n, "test");;
gap> GraphvizAttrs(n);
rec( label := "test" )

# Test set color (node)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetColor(n, "red");;
gap> GraphvizAttrs(n);
rec( color := "red" )

# Test adding a node object directly fails
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> s := GraphvizGraph();;
gap> GraphvizAddNode(s, n);
Error, Cannot add node objects directly to graphs. Please use the node's name.

# Test updating an attribute
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetAttr(n, "label", "a");;
gap> AsString(g);
"//dot\ngraph  {\n\tn [label=a]\n}\n"
gap> GraphvizSetAttr(n, "label", "b");;
gap> AsString(g);
"//dot\ngraph  {\n\tn [label=b]\n}\n"
gap> GraphvizSetAttr(n, "color", "red");;
gap> AsString(g);
"//dot\ngraph  {\n\tn [color=red, label=b]\n}\n"
gap> GraphvizSetAttr(n, "color", "blue");;
gap> AsString(g);
"//dot\ngraph  {\n\tn [color=blue, label=b]\n}\n"

# test changing labels functions properly
gap> g := GraphvizGraph("xxx");;
gap> GraphvizAddNode(g, 1);;
gap> GraphvizAddNode(g, 2);;
gap> GraphvizAddNode(g, 3);;
gap> GraphvizSetNodeLabels(g, ["i", "ii", "iii"]);
<graphviz graph xxx with 3 nodes and 0 edges>
gap> AsString(g);
"//dot\ngraph xxx {\n\t1 [label=i]\n\t2 [label=ii]\n\t3 [label=iii]\n}\n"
gap> GraphvizSetNodeLabels(g, ["a", "b", "c"]);
<graphviz graph xxx with 3 nodes and 0 edges>
gap> AsString(g);
"//dot\ngraph xxx {\n\t1 [label=a]\n\t2 [label=b]\n\t3 [label=c]\n}\n"

# test changing labels and colors functions properly
gap> g := GraphvizGraph("xxx");
<graphviz graph xxx with 0 nodes and 0 edges>
gap> GraphvizAddNode(g, 1);
<graphviz node 1>
gap> GraphvizAddNode(g, 2);
<graphviz node 2>
gap> GraphvizAddNode(g, 3);
<graphviz node 3>
gap> GraphvizSetNodeColors(g, ["i", "ii", "iii"]);
Error, invalid color "i" (list (string)), valid colors are RGB values or names\
 from the GraphViz 2.44.1 X11 Color Scheme http://graphviz.org/doc/info/colors\
.html
gap> GraphvizSetNodeColors(g, ["red", "green", "blue"]);
<graphviz graph xxx with 3 nodes and 0 edges>
gap> AsString(g);
"//dot\ngraph xxx {\n\t1 [color=red, style=filled]\n\t2 [color=green, style=fi\
lled]\n\t3 [color=blue, style=filled]\n}\n"
gap> GraphvizSetNodeColors(g, ["red", "#00FF00", "blue"]);
<graphviz graph xxx with 3 nodes and 0 edges>
gap> AsString(g);
"//dot\ngraph xxx {\n\t1 [color=red, style=filled]\n\t2 [color=\"#00FF00\", st\
yle=filled]\n\t3 [color=blue, style=filled]\n}\n"
gap> GraphvizSetNodeColors(g, ["#FF0000", "#00FF00", "#0000FF"]);
<graphviz graph xxx with 3 nodes and 0 edges>
gap> AsString(g);
"//dot\ngraph xxx {\n\t1 [color=\"#FF0000\", style=filled]\n\t2 [color=\"#00FF\
00\", style=filled]\n\t3 [color=\"#0000FF\", style=filled]\n}\n"

#
gap> STOP_TEST("graphviz package: node.tst", 0);
