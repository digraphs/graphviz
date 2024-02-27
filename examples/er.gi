# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/undirected/ER.html"""
LoadPackage("graphviz");
e := GV_Graph("ER");
GV_SetAttr(e, "engine=\"neato\"");

start := GV_AddContext(e, "context_start");
GV_SetAttr(start, "node[shape=\"box\"]");
GV_AddNode(start, "course");
GV_AddNode(start, "institute");
GV_AddNode(start, "student");

context1 := GV_AddContext(e, "context1");
GV_SetAttr(context1, "node [shape=\"ellipse\"]");
GV_SetAttr(GV_AddNode(context1, "name0"), "label", "name");
GV_SetAttr(GV_AddNode(context1, "name1"), "label", "name");
GV_SetAttr(GV_AddNode(context1, "name2"), "label", "name");
GV_AddNode(context1, "code");
GV_AddNode(context1, "grade");
GV_AddNode(context1, "number");

context2 := GV_AddContext(e, "context2");
GV_SetAttr(context2, "node [shape=\"diamond\", style=\"filled\", color=\"lightgrey\"]");
GV_AddNode(context2, "C-I");
GV_AddNode(context2, "S-C");
GV_AddNode(context2, "S-I");

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
