#############################################################################
##
##  traffic_lights.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/Gallery/directed/unix.html

#@local ctx1, ctx2, i, j, pair, t
gap> START_TEST("graphviz package: examples/traffic_lights.tst");
gap> LoadPackage("graphviz");
true
gap> t := GraphvizDigraph("TrafficLights");
<graphviz digraph TrafficLights with 0 nodes and 0 edges>
gap> GraphvizSetAttr(t, "engine=neato");
<graphviz digraph TrafficLights with 0 nodes and 0 edges>

#
gap> ctx1 := GraphvizAddSubgraph(t, "ctx1");
<graphviz digraph ctx1 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(ctx1, "node [shape=\"box\"]");
<graphviz digraph ctx1 with 0 nodes and 0 edges>
gap> for i in [2, 1] do
>     GraphvizAddNode(ctx1, StringFormatted("gy{}", i));
>     GraphvizAddNode(ctx1, StringFormatted("yr{}", i));
>     GraphvizAddNode(ctx1, StringFormatted("rg{}", i));
> od;

#
gap> ctx2 := GraphvizAddSubgraph(t, "ctx2");
<graphviz digraph ctx2 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(ctx2, "node [shape=\"circle\", fixedsize=true, width=0.9]");
<graphviz digraph ctx2 with 0 nodes and 0 edges>
gap> for i in [2, 1] do
>     GraphvizAddNode(ctx2, StringFormatted("green{}", i));
>     GraphvizAddNode(ctx2, StringFormatted("yellow{}", i));
>     GraphvizAddNode(ctx2, StringFormatted("red{}", i));
>     GraphvizAddNode(ctx2, StringFormatted("safe{}", i));
> od;

#
gap> pair := fail;
fail
gap> for pair in [[2, 1], [1, 2]] do
>   i := pair[1];
>   j := pair[2];
>   GraphvizAddEdge(
>     t, StringFormatted("gy{}", i), StringFormatted("yellow{}", i));
>   GraphvizAddEdge(
>     t, StringFormatted("rg{}", i), StringFormatted("green{}", i));
>   GraphvizAddEdge(
>     t, StringFormatted("yr{}", i), StringFormatted("safe{}", j));
>   GraphvizAddEdge(
>     t, StringFormatted("yr{}", i), StringFormatted("red{}", i));
>   GraphvizAddEdge(
>     t, StringFormatted("safe{}", i), StringFormatted("rg{}", i));
>   GraphvizAddEdge(
>     t, StringFormatted("green{}", i), StringFormatted("gy{}", i));
>   GraphvizAddEdge(
>     t, StringFormatted("yellow{}", i), StringFormatted("yr{}", i));
>   GraphvizAddEdge(
>     t, StringFormatted("red{}", i), StringFormatted("rg{}", i));
> od;

#
gap> GraphvizSetAttr(t, "overlap=\"false\"");
<graphviz digraph TrafficLights with 0 nodes and 16 edges>
gap> GraphvizSetAttr(t,
> """label="PetriNet Model TrafficLights
> Extracted from ConceptBase and laid out by Graphviz"
> """);
<graphviz digraph TrafficLights with 0 nodes and 16 edges>
gap> GraphvizSetAttr(t, "fontsize=12");
<graphviz digraph TrafficLights with 0 nodes and 16 edges>

#
gap> String(t);
"//dot\ndigraph TrafficLights {\n\tengine=neato overlap=\"false\" label=\"Petr\
iNet Model TrafficLights\nExtracted from ConceptBase and laid out by Graphviz\
\"\n fontsize=12 \nsubgraph ctx1 {\n\tnode [shape=\"box\"] \n\tgy2\n\tyr2\n\tr\
g2\n\tgy1\n\tyr1\n\trg1\n}\nsubgraph ctx2 {\n\tnode [shape=\"circle\", fixedsi\
ze=true, width=0.9] \n\tgreen2\n\tyellow2\n\tred2\n\tsafe2\n\tgreen1\n\tyellow\
1\n\tred1\n\tsafe1\n}\n\tgy2 -> yellow2\n\trg2 -> green2\n\tyr2 -> safe1\n\tyr\
2 -> red2\n\tsafe2 -> rg2\n\tgreen2 -> gy2\n\tyellow2 -> yr2\n\tred2 -> rg2\n\
\tgy1 -> yellow1\n\trg1 -> green1\n\tyr1 -> safe2\n\tyr1 -> red1\n\tsafe1 -> r\
g1\n\tgreen1 -> gy1\n\tyellow1 -> yr1\n\tred1 -> rg1\n}\n"

#
gap> STOP_TEST("graphviz package: traffic_lights.tst");
