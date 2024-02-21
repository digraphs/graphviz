# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/directed/fsm.html"""
LoadPackage("graphviz");

f := GV_Digraph("finite_state_machine");
GV_SetAttr(f, "rankdir=LR");
GV_SetAttr(f, "size=\"8,5\"");

terminals := GV_AddSubgraph(f, IsGVContext, "terminals");
GV_SetAttr(terminals, "node [shape=doublecircle]");
GV_AddNode(terminals, "LR_0");
GV_AddNode(terminals, "LR_3");
GV_AddNode(terminals, "LR_4");
GV_AddNode(terminals, "LR_8");

nodes := GV_AddSubgraph(f, IsGVContext, "nodes");
GV_SetAttr(nodes, "node [shape=circle]");
GV_SetAttr(GV_AddEdge(nodes, "LR_2", "LR_0"), "label", "\"SS(B)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_1", "LR_0"), "label", "\"SS(S)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_3", "LR_1"), "label", "\"S($end)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_6", "LR_2"), "label", "\"SS(b)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_5", "LR_2"), "label", "\"SS(a)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_4", "LR_2"), "label", "\"S(A)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_7", "LR_5"), "label", "\"S(b)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_5", "LR_5"), "label", "\"S(a)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_6", "LR_6"), "label", "\"S(b)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_5", "LR_6"), "label", "\"S(a)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_8", "LR_7"), "label", "\"S(b)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_5", "LR_7"), "label", "\"S(a)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_6", "LR_8"), "label", "\"S(b)\"");
GV_SetAttr(GV_AddEdge(nodes, "LR_5", "LR_8"), "label", "\"S(a)\"");

Print(GV_String(f));
