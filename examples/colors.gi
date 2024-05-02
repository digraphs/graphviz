# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/docs/attr-types/color"""

LoadPackage("graphviz");
g := GraphvizGraph();

node := GraphvizAddNode(g, "RGB #40e0d0");
GraphvizSetAttr(node, "style", "filled");
GraphvizSetAttr(node, "fillcolor", "#40e0d0");

node := GraphvizAddNode(g, "RGBA #ff000042");
GraphvizSetAttr(node, "style", "filled");
GraphvizSetAttr(node, "fillcolor", "#ff000042");

node := GraphvizAddNode(g, "HSV 0.051 0.718 0.627");
GraphvizSetAttr(node, "style", "filled");
GraphvizSetAttr(node, "fillcolor", "0.051 0.718 0.627");

node := GraphvizAddNode(g, "name deeppink");
GraphvizSetAttr(node, "style", "filled");
GraphvizSetAttr(node, "fillcolor", "deeppink");

Print(AsString(g));
