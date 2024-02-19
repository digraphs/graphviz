LoadPackage("graphviz");
f := GV_Digraph("finite_state_machine");
GV_SetAttr(f, "rankdir='LR'");
GV_SetAttr(f, "size='8,5'");
GV_SetAttr(f, "node shape='doublecircle'");

e := GV_AddEdge(f, "LR_0", "LR_2");
GV_SetAttr(e, "label", "SS(B)");
e := GV_AddEdge(f, "LR_0", "LR_1");
GV_SetAttr(e, "label", "SS(S)");
e := GV_AddEdge(f, "LR_1", "LR_3");
GV_SetAttr(e, "label", "S($end)");
e := GV_AddEdge(f, "LR_2", "LR_6");
GV_SetAttr(e, "label", "SS(b)");
e := GV_AddEdge(f, "LR_2", "LR_5");
GV_SetAttr(e, "label", "SS(a)");
e := GV_AddEdge(f, "LR_2", "LR_4");
GV_SetAttr(e, "label", "S(A)");
e := GV_AddEdge(f, "LR_5", "LR_7");
GV_SetAttr(e, "label", "S(b)");
e := GV_AddEdge(f, "LR_5", "LR_5");
GV_SetAttr(e, "label", "S(a)");
e := GV_AddEdge(f, "LR_6", "LR_6");
GV_SetAttr(e, "label", "S(b)");
e := GV_AddEdge(f, "LR_6", "LR_5");
GV_SetAttr(e, "label", "S(a)");
e := GV_AddEdge(f, "LR_7", "LR_8");
GV_SetAttr(e, "label", "S(b)");
e := GV_AddEdge(f, "LR_7", "LR_5");
GV_SetAttr(e, "label", "S(a)");
e := GV_AddEdge(f, "LR_8", "LR_6");
GV_SetAttr(e, "label", "S(b)");
e := GV_AddEdge(f, "LR_8", "LR_5");
GV_SetAttr(e, "label", "S(a)");

GV_SetAttr(f["LR_0"], "shape", "doublecircle");
GV_SetAttr(f["LR_3"], "shape", "doublecircle");
GV_SetAttr(f["LR_4"], "shape", "doublecircle");
GV_SetAttr(f["LR_8"], "shape", "doublecircle");

GV_SetAttr(f["LR_1"], "shape", "circle");
GV_SetAttr(f["LR_2"], "shape", "circle");
GV_SetAttr(f["LR_5"], "shape", "circle");
GV_SetAttr(f["LR_6"], "shape", "circle");
GV_SetAttr(f["LR_7"], "shape", "circle");

Print(GV_String(f));
