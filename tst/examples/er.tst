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
gap> START_TEST("graphviz package: examples/er.tst");
gap> LoadPackage("GraphvizForGAP");
true

#
gap> e := GraphvizGraph("ER");
<graphviz graph "ER" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(e, rec(engine := "neato"));
<graphviz graph "ER" with 0 nodes and 0 edges>

#
gap> start := GraphvizAddContext(e, "context_start");
<graphviz context "context_start" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(start, rec(node := rec(shape := "box")));
<graphviz context "context_start" with 0 nodes and 0 edges>
gap> GraphvizAddNode(start, "course");
<graphviz node "course">
gap> GraphvizAddNode(start, "institute");
<graphviz node "institute">
gap> GraphvizAddNode(start, "student");
<graphviz node "student">

#
gap> context1 := GraphvizAddContext(e, "context1");
<graphviz context "context1" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(context1, rec(node := rec(shape := "ellipse")));
<graphviz context "context1" with 0 nodes and 0 edges>
gap> GraphvizSetAttr(GraphvizAddNode(context1, "name0"), "label", "name");
<graphviz node "name0">
gap> GraphvizSetAttr(GraphvizAddNode(context1, "name1"), "label", "name");
<graphviz node "name1">
gap> GraphvizSetAttr(GraphvizAddNode(context1, "name2"), "label", "name");
<graphviz node "name2">
gap> GraphvizAddNode(context1, "code");
<graphviz node "code">
gap> GraphvizAddNode(context1, "grade");
<graphviz node "grade">
gap> GraphvizAddNode(context1, "number");
<graphviz node "number">

#
gap> context2 := GraphvizAddContext(e, "context2");
<graphviz context "context2" with 0 nodes and 0 edges>
gap> GraphvizSetAttrs(context2,
> rec(node := rec(shape := "diamond", style := "filled", color := "lightgrey")));
<graphviz context "context2" with 0 nodes and 0 edges>
gap> GraphvizAddNode(context2, "C-I");
<graphviz node "C-I">
gap> GraphvizAddNode(context2, "S-C");
<graphviz node "S-C">
gap> GraphvizAddNode(context2, "S-I");
<graphviz node "S-I">

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
gap> GraphvizSetAttrs(e, rec(label := "Entity Relation Diagram\ndrawn by NEATO"));
<graphviz graph "ER" with 12 nodes and 12 edges>
gap> GraphvizSetAttrs(e, rec(fontsize := "20"));
<graphviz graph "ER" with 12 nodes and 12 edges>

#
gap> Print(AsString(e), "\n");
#I  invalid node name C-I using "C-I" instead
#I  invalid node name S-C using "S-C" instead
#I  invalid node name S-I using "S-I" instead
#I  invalid node name C-I using "C-I" instead
#I  invalid node name C-I using "C-I" instead
#I  invalid node name S-I using "S-I" instead
#I  invalid node name S-I using "S-I" instead
#I  invalid node name S-C using "S-C" instead
#I  invalid node name S-C using "S-C" instead
//dot
graph ER {
  graph [engine="neato", fontsize="20", label="Entity Relation Diagram
drawn by NEATO"]
  {
    // context "context_start" 
    node [shape="box"]
    course
    institute
    student
  }
  {
    // context "context1" 
    node [shape="ellipse"]
    name0 [label="name"]
    name1 [label="name"]
    name2 [label="name"]
    code
    grade
    number
  }
  {
    // context "context2" 
    node [color="lightgrey", shape="diamond", style="filled"]
    "C-I"
    "S-C"
    "S-I"
  }
  name0 -- course
  code -- course
  "C-I" -- course [label="n", len="1.00"]
  institute -- "C-I" [label="1", len="1.00"]
  name1 -- institute
  "S-I" -- institute [label="1", len="1.00"]
  student -- "S-I" [label="n", len="1.00"]
  grade -- student
  name2 -- student
  number -- student
  "S-C" -- student [label="m", len="1.00"]
  course -- "S-C" [label="n", len="1.00"]
}

#
gap> STOP_TEST("graphviz package: examples/er.tst");
