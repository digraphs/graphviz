# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/directed/unix.html"""
LoadPackage("graphviz");

t := GraphvizDigraph("TrafficLights");
GraphvizSetAttr(t, "engine=neato");

ctx1 := GraphvizAddSubgraph(t, "ctx1");
GraphvizSetAttr(ctx1, "node [shape=\"box\"]");
for i in [2, 1] do
    GraphvizAddNode(ctx1, StringFormatted("gy{}", i));
    GraphvizAddNode(ctx1, StringFormatted("yr{}", i));
    GraphvizAddNode(ctx1, StringFormatted("rg{}", i));
od;

ctx2 := GraphvizAddSubgraph(t, "ctx2");
GraphvizSetAttr(ctx2, "node [shape=\"circle\", fixedsize=true, width=0.9]");
for i in [2, 1] do
    GraphvizAddNode(ctx2, StringFormatted("green{}", i));
    GraphvizAddNode(ctx2, StringFormatted("yellow{}", i));
    GraphvizAddNode(ctx2, StringFormatted("red{}", i));
    GraphvizAddNode(ctx2, StringFormatted("safe{}", i));
od;

pair := fail;
for pair in [[2, 1], [1, 2]] do
  i := pair[1];
  j := pair[2];
  GraphvizAddEdge(
    t, StringFormatted("gy{}", i), StringFormatted("yellow{}", i));
  GraphvizAddEdge(
    t, StringFormatted("rg{}", i), StringFormatted("green{}", i));
  GraphvizAddEdge(
    t, StringFormatted("yr{}", i), StringFormatted("safe{}", j));
  GraphvizAddEdge(
    t, StringFormatted("yr{}", i), StringFormatted("red{}", i));
  GraphvizAddEdge(
    t, StringFormatted("safe{}", i), StringFormatted("rg{}", i));
  GraphvizAddEdge(
    t, StringFormatted("green{}", i), StringFormatted("gy{}", i));
  GraphvizAddEdge(
    t, StringFormatted("yellow{}", i), StringFormatted("yr{}", i));
  GraphvizAddEdge(
    t, StringFormatted("red{}", i), StringFormatted("rg{}", i));
od;

GraphvizSetAttr(t, "overlap=\"false\"");
GraphvizSetAttr(t,
"""label=\"PetriNet Model TrafficLights
Extracted from ConceptBase and laid out by Graphviz\"
""");
GraphvizSetAttr(t, "fontsize=12");

Print(AsString(t));
