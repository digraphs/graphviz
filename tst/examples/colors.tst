#############################################################################
##
##  colors.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/docs/attr-types/color


#@local g, node
gap> START_TEST("graphviz package: examples/colors.tst");
gap> LoadPackage("graphviz");
true

#
gap> g := GraphvizGraph();
<graphviz graph with 0 nodes and 0 edges>

#
gap> node := GraphvizAddNode(g, "RGB: #40e0d0");
<graphviz node "RGB: #40e0d0">
gap> GraphvizSetAttr(node, "style", "filled");
<graphviz node "RGB: #40e0d0">
gap> GraphvizSetAttr(node, "fillcolor", "\"#40e0d0\"");
<graphviz node "RGB: #40e0d0">

#
gap> node := GraphvizAddNode(g, "RGBA: #ff000042");
<graphviz node "RGBA: #ff000042">
gap> GraphvizSetAttr(node, "style", "filled");
<graphviz node "RGBA: #ff000042">
gap> GraphvizSetAttr(node, "fillcolor", "\"#ff000042\"");
<graphviz node "RGBA: #ff000042">

#
gap> node := GraphvizAddNode(g, "HSV: 0.051 0.718 0.627");
<graphviz node "HSV: 0.051 0.718 0.627">
gap> GraphvizSetAttr(node, "style", "filled");
<graphviz node "HSV: 0.051 0.718 0.627">
gap> GraphvizSetAttr(node, "fillcolor", "0.051 0.718 0.627");
<graphviz node "HSV: 0.051 0.718 0.627">

#
gap> node := GraphvizAddNode(g, "name: deeppink");
<graphviz node "name: deeppink">
gap> GraphvizSetAttr(node, "style", "filled");
<graphviz node "name: deeppink">
gap> GraphvizSetAttr(node, "fillcolor", "deeppink");
<graphviz node "name: deeppink">

#
gap> AsString(g);
#I  invalid node name RGB: #40e0d0 using "RGB: #40e0d0" instead
#I  invalid node name RGBA: #ff000042 using "RGBA: #ff000042" instead
#I  invalid node name HSV: 0.051 0.718 0.627 using "HSV: 0.051 0.718 0.627" instead
#I  invalid node name name: deeppink using "name: deeppink" instead
"//dot\ngraph  {\n\t\"RGB: #40e0d0\" [fillcolor=\"\"#40e0d0\"\", style=filled]\
\n\t\"RGBA: #ff000042\" [fillcolor=\"\"#ff000042\"\", style=filled]\n\t\"HSV: \
0.051 0.718 0.627\" [fillcolor=\"0.051 0.718 0.627\", style=filled]\n\t\"name:\
 deeppink\" [fillcolor=deeppink, style=filled]\n}\n"

#
gap> STOP_TEST("graphviz package: examples/colors.tst");
