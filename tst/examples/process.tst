#############################################################################
##
##  process.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html


#@local graph
gap> START_TEST("graphviz package: examples/process.tst");
gap> LoadPackage("graphviz");
true

#
gap> graph := GraphvizGraph("G");
<graphviz graph G with 0 nodes and 0 edges>
gap> GraphvizSetAttr(graph, "engine=\"sfdp\"");
<graphviz graph G with 0 nodes and 0 edges>

#
gap> GraphvizAddEdge(graph, "run", "intr");
<graphviz edge (run, intr)>
gap> GraphvizAddEdge(graph, "intr", "runbl");
<graphviz edge (intr, runbl)>
gap> GraphvizAddEdge(graph, "runbl", "run");
<graphviz edge (runbl, run)>
gap> GraphvizAddEdge(graph, "run", "kernel");
<graphviz edge (run, kernel)>
gap> GraphvizAddEdge(graph, "kernel", "zombie");
<graphviz edge (kernel, zombie)>
gap> GraphvizAddEdge(graph, "kernel", "sleep");
<graphviz edge (kernel, sleep)>
gap> GraphvizAddEdge(graph, "kernel", "runmem");
<graphviz edge (kernel, runmem)>
gap> GraphvizAddEdge(graph, "sleep", "swap");
<graphviz edge (sleep, swap)>
gap> GraphvizAddEdge(graph, "swap", "runswap");
<graphviz edge (swap, runswap)>
gap> GraphvizAddEdge(graph, "runswap", "new");
<graphviz edge (runswap, new)>
gap> GraphvizAddEdge(graph, "runswap", "runmem");
<graphviz edge (runswap, runmem)>
gap> GraphvizAddEdge(graph, "new", "runmem");
<graphviz edge (new, runmem)>
gap> AsString(graph);
"//dot\ngraph G {\n\tengine=\"sfdp\" \n\trun\n\tintr\n\trun -- intr\n\trunbl\n\
\tintr -- runbl\n\trunbl -- run\n\tkernel\n\trun -- kernel\n\tzombie\n\tkernel\
 -- zombie\n\tsleep\n\tkernel -- sleep\n\trunmem\n\tkernel -- runmem\n\tswap\n\
\tsleep -- swap\n\trunswap\n\tswap -- runswap\n\tnew\n\trunswap -- new\n\truns\
wap -- runmem\n\tnew -- runmem\n}\n"

#
gap> STOP_TEST("graphviz package: process.tst");
