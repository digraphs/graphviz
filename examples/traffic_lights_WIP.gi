# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/directed/unix.html"""
LoadPackage("graphviz");

t := GV_Digraph("TrafficLights");
GV_SetAttr(t, "engine=neato");

ctx1 := GV_AddSubgraph(t, "ctx1");
GV_SetAttr(ctx1, "node [shape=\"box\"]");
for i in [2, 1] do
    GV_AddNode(ctx1, StringFormatted("gy{}", i));
    GV_AddNode(ctx1, StringFormatted("yr{}", i));
    GV_AddNode(ctx1, StringFormatted("rg{}", i));
od;


ctx2 := GV_AddSubgraph(t, "ctx2");
GV_SetAttr(ctx2, "node [shape=\"circle\", fixedsize=true, width=0.9]");
for i in [2, 1] do
    GV_AddNode(ctx2, StringFormatted("green{}", i));
    GV_AddNode(ctx2, StringFormatted("yellow{}", i));
    GV_AddNode(ctx2, StringFormatted("red{}", i));
    GV_AddNode(ctx2, StringFormatted("safe{}", i));
od;

pair := fail;
for pair in [[2, 1], [1, 2]] do
    i := pair[1];
    j := pair[2];
    GV_AddEdge(t, StringFormatted("gy{}", i), StringFormatted("yellow{}", i));
    GV_AddEdge(t, StringFormatted("rg{}", i), StringFormatted("green{}", i));
    GV_AddEdge(t, StringFormatted("yr{}", i), StringFormatted("safe{}", j));
    GV_AddEdge(t, StringFormatted("yr{}", i), StringFormatted("red{}", i));
    GV_AddEdge(t, StringFormatted("safe{}", i), StringFormatted("rg{}", i));
    GV_AddEdge(t, StringFormatted("green{}", i), StringFormatted("gy{}", i));
    GV_AddEdge(t, StringFormatted("yellow{}", i), StringFormatted("yr{}", i));
    GV_AddEdge(t, StringFormatted("red{}", i), StringFormatted("rg{}", i));
od;

GV_SetAttr(t, "overlap=\"false\"");
GV_SetAttr(t, "label=\"PetriNet Model TrafficLights\nExtracted from ConceptBase and layed out by Graphviz\"");
GV_SetAttr(t, "fontsize=12");

Print(GV_String(t));
