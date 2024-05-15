#############################################################################
##
##  er.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/Gallery/undirected/ER.html

#@local context1, context2, e, label, len, start
gap> START_TEST("graphviz package: examples/er.tst");
gap> LoadPackage("graphviz");
true

#
gap> e := GraphvizGraph("ER");
<graphviz graph ER with 0 nodes and 0 edges>
gap> GraphvizSetAttr(e, "engine=\"neato\"");
<graphviz graph ER with 0 nodes and 0 edges>

#
gap> start := GraphvizAddContext(e, "context_start");
<graphviz context context_start with 0 nodes and 0 edges>
gap> GraphvizSetAttr(start, "node[shape=\"box\"]");
<graphviz context context_start with 0 nodes and 0 edges>
gap> GraphvizAddNode(start, "course");
<graphviz node course>
gap> GraphvizAddNode(start, "institute");
<graphviz node institute>
gap> GraphvizAddNode(start, "student");
<graphviz node student>

#
gap> context1 := GraphvizAddContext(e, "context1");
<graphviz context context1 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(context1, "node [shape=\"ellipse\"]");
<graphviz context context1 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(GraphvizAddNode(context1, "name0"), "label", "name");
<graphviz node name0>
gap> GraphvizSetAttr(GraphvizAddNode(context1, "name1"), "label", "name");
<graphviz node name1>
gap> GraphvizSetAttr(GraphvizAddNode(context1, "name2"), "label", "name");
<graphviz node name2>
gap> GraphvizAddNode(context1, "code");
<graphviz node code>
gap> GraphvizAddNode(context1, "grade");
<graphviz node grade>
gap> GraphvizAddNode(context1, "number");
<graphviz node number>

#
gap> context2 := GraphvizAddContext(e, "context2");
<graphviz context context2 with 0 nodes and 0 edges>
gap> GraphvizSetAttr(context2,
> "node [shape=\"diamond\", style=\"filled\", color=\"lightgrey\"]");
<graphviz context context2 with 0 nodes and 0 edges>
gap> GraphvizAddNode(context2, "C-I");
<graphviz node C-I>
gap> GraphvizAddNode(context2, "S-C");
<graphviz node S-C>
gap> GraphvizAddNode(context2, "S-I");
<graphviz node S-I>

#
gap> GraphvizAddEdge(e, "name0", "course");
<graphviz edge (name0, course)>
gap> GraphvizAddEdge(e, "code", "course");
<graphviz edge (code, course)>
gap> GraphvizSetAttrs(GraphvizAddEdge(e, "C-I", "course"),
> rec(label := "n", len := "1.00"));
<graphviz edge (C-I, course)>
gap> GraphvizSetAttrs(GraphvizAddEdge(e, "institute", "C-I"),
> rec(label := "1", len := "1.00"));
<graphviz edge (institute, C-I)>
gap> GraphvizAddEdge(e, "name1", "institute");
<graphviz edge (name1, institute)>
gap> GraphvizSetAttrs(GraphvizAddEdge(e, "S-I", "institute"),
> rec(label := "1", len := "1.00"));
<graphviz edge (S-I, institute)>
gap> GraphvizSetAttrs(GraphvizAddEdge(e, "student", "S-I"),
> rec(label := "n", len := "1.00"));
<graphviz edge (student, S-I)>
gap> GraphvizAddEdge(e, "grade", "student");
<graphviz edge (grade, student)>
gap> GraphvizAddEdge(e, "name2", "student");
<graphviz edge (name2, student)>
gap> GraphvizAddEdge(e, "number", "student");
<graphviz edge (number, student)>
gap> GraphvizSetAttrs(GraphvizAddEdge(e, "S-C", "student"),
> rec(label := "m", len := "1.00"));
<graphviz edge (S-C, student)>
gap> GraphvizSetAttrs(GraphvizAddEdge(e, "course", "S-C"),
> rec(label := "n", len := "1.00"));
<graphviz edge (course, S-C)>

#
gap> GraphvizSetAttr(e, "label=\"Entity Relation Diagram\ndrawn by NEATO\"");
<graphviz graph ER with 0 nodes and 12 edges>
gap> GraphvizSetAttr(e, "fontsize=\"20\"");
<graphviz graph ER with 0 nodes and 12 edges>

#
gap> AsString(e);
#I  invalid node name C-I using "C-I" instead
#I  invalid node name S-C using "S-C" instead
#I  invalid node name S-I using "S-I" instead
#I  invalid node name C-I using "C-I" instead
#I  invalid node name C-I using "C-I" instead
#I  invalid node name S-I using "S-I" instead
#I  invalid node name S-I using "S-I" instead
#I  invalid node name S-C using "S-C" instead
#I  invalid node name S-C using "S-C" instead
"//dot\ngraph ER {\n\tengine=\"neato\" label=\"Entity Relation Diagram\ndrawn \
by NEATO\" fontsize=\"20\" \n// context_start context \n\tnode[shape=\"box\"] \
\n\tcourse\n\tinstitute\n\tstudent\n\tengine=\"neato\" label=\"Entity Relation\
 Diagram\ndrawn by NEATO\" fontsize=\"20\" \n\n// context1 context \n\tnode [s\
hape=\"ellipse\"] \n\tname0 [label=name]\n\tname1 [label=name]\n\tname2 [label\
=name]\n\tcode\n\tgrade\n\tnumber\n\tengine=\"neato\" label=\"Entity Relation \
Diagram\ndrawn by NEATO\" fontsize=\"20\" \n\n// context2 context \n\tnode [sh\
ape=\"diamond\", style=\"filled\", color=\"lightgrey\"] \n\t\"C-I\"\n\t\"S-C\"\
\n\t\"S-I\"\n\tengine=\"neato\" label=\"Entity Relation Diagram\ndrawn by NEAT\
O\" fontsize=\"20\" \n\n\tname0 -- course\n\tcode -- course\n\t\"C-I\" -- cour\
se [label=n, len=1.00]\n\tinstitute -- \"C-I\" [label=1, len=1.00]\n\tname1 --\
 institute\n\t\"S-I\" -- institute [label=1, len=1.00]\n\tstudent -- \"S-I\" [\
label=n, len=1.00]\n\tgrade -- student\n\tname2 -- student\n\tnumber -- studen\
t\n\t\"S-C\" -- student [label=m, len=1.00]\n\tcourse -- \"S-C\" [label=n, len\
=1.00]\n}\n"

#
gap> STOP_TEST("graphviz package: examples/er.tst");
