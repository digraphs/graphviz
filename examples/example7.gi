# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/undirected/ER.html"""
LoadPackage("graphviz");
e := GV_Graph("ER");

GV_SetAttr(e, "node[shape=\"box\"]");

GV_AddNode(e, "course");
GV_AddNode(e, "institute");
GV_AddNode(e, "student");

GV_SetAttrs(GV_AddNode(e, "name0"), rec(label := "name", shape := "ellipse"));
GV_SetAttrs(GV_AddNode(e, "name1"), rec(label := "name", shape := "ellipse"));
GV_SetAttrs(GV_AddNode(e, "name2"), rec(label := "name", shape := "ellipse"));
GV_SetAttr(GV_AddNode(e, "code"), "shape", "ellipse");
GV_SetAttr(GV_AddNode(e, "grade"), "shape", "ellipse");
GV_SetAttr(GV_AddNode(e, "number"), "shape", "ellipse");

GV_SetAttrs(GV_AddNode(e, "C-I"), rec(shape := "diamond", style := "filled", color := "lightgrey"));
GV_SetAttrs(GV_AddNode(e, "S-C"), rec(shape := "diamond", style := "filled", color := "lightgrey"));
GV_SetAttrs(GV_AddNode(e, "S-I"), rec(shape := "diamond", style := "filled", color := "lightgrey"));

GV_AddEdge(e, "name0", "course");
GV_AddEdge(e, "code", "course");
GV_SetAttrs(GV_AddEdge(e, "C-I", "course"), rec(label:="n", len:="1.00"));
GV_SetAttrs(GV_AddEdge(e, "institute", "C-I"), rec(label:="1", len:="1.00"));
GV_AddEdge(e, "name1", "institute");
GV_SetAttrs(GV_AddEdge(e, "S-I", "institute"), rec( label:="1", len:="1.00"));
GV_SetAttrs(GV_AddEdge(e, "student", "S-I"), rec( label:="n", len:="1.00"));
GV_AddEdge(e, "grade", "student");
GV_AddEdge(e, "name2", "student");
GV_AddEdge(e, "number", "student");
GV_SetAttrs(GV_AddEdge(e, "S-C", "student"), rec(label:="m", len:="1.00"));
GV_SetAttrs(GV_AddEdge(e, "course", "S-C"), rec(label:="n", len:="1.00"));

GV_SetAttr(e, "label=\"Entity Relation Diagram\ndrawn by NEATO\"");
GV_SetAttr(e, "fontsize=\"20\"");

Print(GV_String(e));
