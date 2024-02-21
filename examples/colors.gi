# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/docs/attr-types/color"""

LoadPackage("graphviz");
g := GV_Graph();

node := GV_AddNode(g, "RGB #40e0d0");
GV_SetAttr(node, "style", "filled");
GV_SetAttr(node, "fillcolor", "#40e0d0");


node := GV_AddNode(g, "RGBA #ff000042");
GV_SetAttr(node, "style", "filled");
GV_SetAttr(node, "fillcolor", "#ff000042");


node := GV_AddNode(g, "HSV 0.051 0.718 0.627");
GV_SetAttr(node, "style", "filled");
GV_SetAttr(node, "fillcolor", "0.051 0.718 0.627");

node := GV_AddNode(g, "name deeppink");
GV_SetAttr(node, "style", "filled");
GV_SetAttr(node, "fillcolor", "deeppink");

Print(GV_String(g));
