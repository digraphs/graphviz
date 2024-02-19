LoadPackage("graphviz");
graph := GV_Graph("G");

GV_AddEdge(graph, "run", "intr");
GV_AddEdge(graph, "intr", "runbl");
GV_AddEdge(graph, "runbl", "run");
GV_AddEdge(graph, "run", "kernel");
GV_AddEdge(graph, "kernel", "zombie");
GV_AddEdge(graph, "kernel", "sleep");
GV_AddEdge(graph, "kernel", "runmem");
GV_AddEdge(graph, "sleep", "swap");
GV_AddEdge(graph, "swap", "runswap");
GV_AddEdge(graph, "runswap", "new");
GV_AddEdge(graph, "runswap", "runmem");
GV_AddEdge(graph, "new", "runmem");
Print(GV_String(graph));
