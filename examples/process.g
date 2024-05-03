#############################################################################
##
##  process.g
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html

LoadPackage("graphviz");
graph := GraphvizGraph("G");
GraphvizSetAttr(graph, "engine=\"sfdp\"");

GraphvizAddEdge(graph, "run", "intr");
GraphvizAddEdge(graph, "intr", "runbl");
GraphvizAddEdge(graph, "runbl", "run");
GraphvizAddEdge(graph, "run", "kernel");
GraphvizAddEdge(graph, "kernel", "zombie");
GraphvizAddEdge(graph, "kernel", "sleep");
GraphvizAddEdge(graph, "kernel", "runmem");
GraphvizAddEdge(graph, "sleep", "swap");
GraphvizAddEdge(graph, "swap", "runswap");
GraphvizAddEdge(graph, "runswap", "new");
GraphvizAddEdge(graph, "runswap", "runmem");
GraphvizAddEdge(graph, "new", "runmem");
Print(AsString(graph));
Splash(graph);
QUIT;
