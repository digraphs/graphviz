#############################################################################
##
##  hello.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html

#@local graph
gap> START_TEST("graphviz package: examples/hello.tst");
gap> LoadPackage("GraphvizForGAP");
true

#
gap> graph := GraphvizDigraph("G");
<graphviz digraph "G" with 0 nodes and 0 edges>
gap> GraphvizAddEdge(graph, "hello", "world");
<graphviz edge (hello, world)>
gap> Print(AsString(graph), "\n");
//dot
digraph G {
  hello
  world
  hello -> world
}

#
gap> STOP_TEST("graphviz package: examples/hello.tst");
