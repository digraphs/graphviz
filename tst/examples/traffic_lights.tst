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
gap> LoadPackage("GraphvizForGAP");
true
gap> t := GraphvizDigraph("TrafficLights");
<graphviz digraph "TrafficLights" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(t, rec(engine := "neato"));
<graphviz digraph "TrafficLights" with 0 nodes and 0 edges>

#
gap> ctx1 := GraphvizAddSubgraph(t, "ctx1");
<graphviz digraph "ctx1" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(ctx1, rec(node := rec(shape := "box")));
<graphviz digraph "ctx1" with 0 nodes and 0 edges>
gap> for i in [2, 1] do
>     GraphvizAddNode(ctx1, StringFormatted("gy{}", i));
>     GraphvizAddNode(ctx1, StringFormatted("yr{}", i));
>     GraphvizAddNode(ctx1, StringFormatted("rg{}", i));
> od;

#
gap> ctx2 := GraphvizAddSubgraph(t, "ctx2");
<graphviz digraph "ctx2" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(ctx2,
> rec(node := rec(shape := "circle", fixedsize := "true", width := "0.9")));
<graphviz digraph "ctx2" with 0 nodes and 0 edges>
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
gap> GraphvizSetAttrs(t, rec(overlap := "false"));
<graphviz digraph "TrafficLights" with 14 nodes and 16 edges>
gap> GraphvizSetAttrs(t,
> rec(label := "PetriNet Model TrafficLights\nExtracted from ConceptBase and laid out by Graphviz"));
<graphviz digraph "TrafficLights" with 14 nodes and 16 edges>
gap> GraphvizSetAttrs(t, rec(fontsize := "12"));
<graphviz digraph "TrafficLights" with 14 nodes and 16 edges>

#
gap> Print(AsString(t), "\n");
//dot
digraph TrafficLights {
  graph [engine="neato", fontsize="12", label="PetriNet Model TrafficLights
Extracted from ConceptBase and laid out by Graphviz", overlap="false"]
  subgraph ctx1 {
    node [shape="box"]
    gy2
    yr2
    rg2
    gy1
    yr1
    rg1
  }
  subgraph ctx2 {
    node [fixedsize="true", shape="circle", width="0.9"]
    green2
    yellow2
    red2
    safe2
    green1
    yellow1
    red1
    safe1
  }
  gy2 -> yellow2
  rg2 -> green2
  yr2 -> safe1
  yr2 -> red2
  safe2 -> rg2
  green2 -> gy2
  yellow2 -> yr2
  red2 -> rg2
  gy1 -> yellow1
  rg1 -> green1
  yr1 -> safe2
  yr1 -> red1
  safe1 -> rg1
  green1 -> gy1
  yellow1 -> yr1
  red1 -> rg1
}

#
gap> STOP_TEST("graphviz package: examples/traffic_lights.tst");
