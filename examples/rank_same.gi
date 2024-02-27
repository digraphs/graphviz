# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://stackoverflow.com/questions/25734244/how-do-i-place-nodes-on-the-same-level-in-dot"""

LoadPackage("graphviz");
g := GV_Digraph();

s1 := GV_AddSubgraph(g);
GV_SetAttr(s1, "rank=same");
GV_AddNode(s1, "A");
GV_AddNode(s1, "X");

GV_AddNode(g, "C");

s2 := GV_AddSubgraph(g);
GV_SetAttr(s2, "rank=same");
GV_AddNode(s2, "B");
GV_AddNode(s2, "D");
GV_AddNode(s2, "Y");

GV_AddEdge(g, "A", "B");
GV_AddEdge(g, "A", "C");
GV_AddEdge(g, "C", "D");
GV_AddEdge(g, "X", "Y");

Print(GV_String(g));