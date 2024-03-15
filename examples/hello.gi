# https://graphviz.readthedocs.io/en/stable/examples.html
LoadPackage("graphviz");
graph := GraphvizDigraph("G");
GraphvizAddEdge(graph, "hello", "world");
Print(AsString(graph));

