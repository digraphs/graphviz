# https://graphviz.readthedocs.io/en/stable/examples.html
LoadPackage("graphviz");
graph := GV_Digraph("G");
GV_AddEdge(graph, "hello", "world");
Print(GV_String(graph));

