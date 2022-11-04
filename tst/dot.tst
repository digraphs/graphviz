#############################################################################
##
##  standard/dot.tst
##  Copyright (C) 2022                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("graphviz package: dot.tst");
gap> LoadPackage("graphviz", false);;

#
gap> x := GV_Graph(rec(comment := "The round table"));
gap> GV_Node(x, "A", "King Arthur", rec(shape := "box"));
gap> GV_Node(x, "B", "Sir Bedevere the Wise");
gap> GV_Node(x, "L", "Sir Lancelot the Brave");
gap> GV_Edge(x, "A", "B");
gap> GV_Edge(x, "A", "L");
gap> GV_Edge(x, "B", "L", rec(constraint := false));
gap> GV_String(x);
"//The round table\ngraph  {\n\tA [label=\"King Arthur\", shape=box]\n\tB [lab\
el=\"Sir Bedevere the Wise\"]\n\tL [label=\"Sir Lancelot the Brave\"]\n\tA -- \
B\n\tA -- L\n\tB -- L [constraint=false]\n}\n"
gap> GV_Comment(x, "dot", 1);
<graphviz graph object with 3 nodes and 3 edges>
gap> GV_GraphAttr(x, rec(bgcolor := "blue", rankdir := "RL"), 4);
<graphviz graph object with 3 nodes and 3 edges>
gap> GV_NodeAttr(x, rec(style :="filled"));
<graphviz graph object with 3 nodes and 3 edges>

#
gap> x := GV_Graph(rec(name := "G", comment := "dot"));
<graphviz graph object with 0 nodes and 0 edges>
gap> GV_NodeAttr(x, rec(shape := "box"));
<graphviz graph object with 0 nodes and 0 edges>
gap> GV_Edge(x, "run", "intr");
<graphviz graph object with 0 nodes and 1 edges>
gap> GV_Edge(x, "intr", "runbl");
<graphviz graph object with 0 nodes and 2 edges>
gap> GV_Edge(x, "runbl", "run");
<graphviz graph object with 0 nodes and 3 edges>
gap> GV_Edge(x, "run", "kernel");
<graphviz graph object with 0 nodes and 4 edges>
gap> GV_Edge(x, "kernel", "zombie");
<graphviz graph object with 0 nodes and 5 edges>
gap> GV_Edge(x, "kernel", "sleep");
<graphviz graph object with 0 nodes and 6 edges>
gap> GV_Edge(x, "kernel", "runmem");
<graphviz graph object with 0 nodes and 7 edges>
gap> GV_NodeAttr(x, rec(shape := "circle"));
<graphviz graph object with 0 nodes and 7 edges>
gap> GV_Edge(x, "sleep", "swap");
<graphviz graph object with 0 nodes and 8 edges>
gap> GV_Edge(x, "swap", "runswap");
<graphviz graph object with 0 nodes and 9 edges>
gap> GV_Edge(x, "runswap", "new");
<graphviz graph object with 0 nodes and 10 edges>
gap> GV_Edge(x, "runswap", "runmem");
<graphviz graph object with 0 nodes and 11 edges>
gap> GV_Edge(x, "new", "runmem");
<graphviz graph object with 0 nodes and 12 edges>
gap> GV_Edge(x, "sleep", "runmem");
<graphviz graph object with 0 nodes and 13 edges>

#
gap> x := GV_Digraph(rec(comment := "dot"));
<graphviz digraph object with 0 nodes and 0 edges>
gap> GV_GraphAttr(x, rec(rankdir:="LR", size:="8,5"));
<graphviz digraph object with 0 nodes and 0 edges>
gap> GV_NodeAttr(x,  rec(shape:="doublecircle"));
<graphviz digraph object with 0 nodes and 0 edges>
gap> GV_Node(x, "LR_0");
<graphviz digraph object with 1 nodes and 0 edges>
gap> GV_Node(x, "LR_0");
<graphviz digraph object with 1 nodes and 0 edges>
gap> GV_Node(x, "LR_3");
<graphviz digraph object with 2 nodes and 0 edges>
gap> GV_Node(x, "LR_4");
<graphviz digraph object with 3 nodes and 0 edges>
gap> GV_Node(x, "LR_8");
<graphviz digraph object with 4 nodes and 0 edges>
gap> GV_NodeAttr(x,  rec(shape:="circle"));
<graphviz digraph object with 4 nodes and 0 edges>
gap> GV_Edge(x, "LR_0", "LR_2", rec(label:="SS(B)"));
<graphviz digraph object with 4 nodes and 1 edges>
gap> GV_Edge(x, "LR_0", "LR_1", rec(label:="SS(S)"));
<graphviz digraph object with 4 nodes and 2 edges>
gap> GV_Edge(x, "LR_1", "LR_3", rec(label:="S($end)"));
<graphviz digraph object with 4 nodes and 3 edges>
gap> GV_Edge(x, "LR_2", "LR_6", rec(label:="SS(b)"));
<graphviz digraph object with 4 nodes and 4 edges>
gap> GV_Edge(x, "LR_2", "LR_5", rec(label:="SS(a)"));
<graphviz digraph object with 4 nodes and 5 edges>
gap> GV_Edge(x, "LR_2", "LR_4", rec(label:="S(A)"));
<graphviz digraph object with 4 nodes and 6 edges>
gap> GV_Edge(x, "LR_5", "LR_7", rec(label:="S(b)"));
<graphviz digraph object with 4 nodes and 7 edges>
gap> GV_Edge(x, "LR_5", "LR_5", rec(label:="S(a)"));
<graphviz digraph object with 4 nodes and 8 edges>
gap> GV_Edge(x, "LR_6", "LR_6", rec(label:="S(b)"));
<graphviz digraph object with 4 nodes and 9 edges>
gap> GV_Edge(x, "LR_6", "LR_5", rec(label:="S(a)"));
<graphviz digraph object with 4 nodes and 10 edges>
gap> GV_Edge(x, "LR_7", "LR_8", rec(label:="S(b)"));
<graphviz digraph object with 4 nodes and 11 edges>
gap> GV_Edge(x, "LR_7", "LR_5", rec(label:="S(a)"));
<graphviz digraph object with 4 nodes and 12 edges>
gap> GV_Edge(x, "LR_8", "LR_6", rec(label:="S(b)"));
<graphviz digraph object with 4 nodes and 13 edges>
gap> GV_Edge(x, "LR_8", "LR_5", rec(label:="S(a)"));
<graphviz digraph object with 4 nodes and 14 edges>

#
gap> STOP_TEST("Digraphs package: standard/oper.tst", 0);
