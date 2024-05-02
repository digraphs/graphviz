# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/undirected/ER.html"""
LoadPackage("graphviz");
e := GraphvizGraph("ER");
GraphvizSetAttr(e, "engine=\"neato\"");

start := GraphvizAddContext(e, "context_start");
GraphvizSetAttr(start, "node[shape=\"box\"]");
GraphvizAddNode(start, "course");
GraphvizAddNode(start, "institute");
GraphvizAddNode(start, "student");

context1 := GraphvizAddContext(e, "context1");
GraphvizSetAttr(context1, "node [shape=\"ellipse\"]");
GraphvizSetAttr(GraphvizAddNode(context1, "name0"), "label", "name");
GraphvizSetAttr(GraphvizAddNode(context1, "name1"), "label", "name");
GraphvizSetAttr(GraphvizAddNode(context1, "name2"), "label", "name");
GraphvizAddNode(context1, "code");
GraphvizAddNode(context1, "grade");
GraphvizAddNode(context1, "number");

context2 := GraphvizAddContext(e, "context2");
GraphvizSetAttr(context2,
"node [shape=\"diamond\", style=\"filled\", color=\"lightgrey\"]");
GraphvizAddNode(context2, "C-I");
GraphvizAddNode(context2, "S-C");
GraphvizAddNode(context2, "S-I");

GraphvizAddEdge(e, "name0", "course");
GraphvizAddEdge(e, "code", "course");
GraphvizSetAttrs(GraphvizAddEdge(e, "C-I", "course"),
rec(label := "n", len := "1.00"));
GraphvizSetAttrs(GraphvizAddEdge(e, "institute", "C-I"),
rec(label := "1", len := "1.00"));
GraphvizAddEdge(e, "name1", "institute");
GraphvizSetAttrs(GraphvizAddEdge(e, "S-I", "institute"),
rec(label := "1", len := "1.00"));
GraphvizSetAttrs(GraphvizAddEdge(e, "student", "S-I"),
rec(label := "n", len := "1.00"));
GraphvizAddEdge(e, "grade", "student");
GraphvizAddEdge(e, "name2", "student");
GraphvizAddEdge(e, "number", "student");
GraphvizSetAttrs(GraphvizAddEdge(e, "S-C", "student"),
rec(label := "m", len := "1.00"));
GraphvizSetAttrs(GraphvizAddEdge(e, "course", "S-C"),
rec(label := "n", len := "1.00"));

GraphvizSetAttr(e, "label=\"Entity Relation Diagram\ndrawn by NEATO\"");
GraphvizSetAttr(e, "fontsize=\"20\"");

Print(AsString(e));
