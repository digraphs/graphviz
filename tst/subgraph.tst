#############################################################################
##
##  subgraph.tst
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#@local a, a1, a2, a3, b, b1, b2, b3, c, child, ctx, g, gv, legend, main, n, o
#@local parent, s, s1, s11, s2, sibling
gap> START_TEST("graphviz package: subgraph.tst");
gap> LoadPackage("graphviz", false);;

# Test creating subgraphs (named)
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g, "test-graph");
<graphviz graph "test-graph" with 0 nodes and 0 edges>
gap> g := GraphvizDigraph();;
gap> GraphvizAddSubgraph(g, "test-digraph");
<graphviz digraph "test-digraph" with 0 nodes and 0 edges>
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g, "test-context");
<graphviz context "test-context" with 0 nodes and 0 edges>

# Test no-name constructors
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g);
<graphviz graph "no_name_1" with 0 nodes and 0 edges>
gap> g := GraphvizDigraph();;
gap> GraphvizAddSubgraph(g);
<graphviz digraph "no_name_1" with 0 nodes and 0 edges>
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g);
<graphviz context "no_name_1" with 0 nodes and 0 edges>
#@if CompareVersionNumbers(GAPInfo.Version, "4.12")
gap> GraphvizAddContext(g, "no_name_1");
Error, the 1st argument (a graphviz (di)graph/context) already has a context o\
r subgraph with name "no_name_1"
#@else
gap> GraphvizAddContext(g, "no_name_1");
Error, the 1st argument (a graphviz (di)graph/context) already has a context o\
r subgr\
aph with name "no_name_1"
#@fi

# Test no-name constructor graphs' names increment
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g);
<graphviz graph "no_name_1" with 0 nodes and 0 edges>
gap> GraphvizAddSubgraph(g);
<graphviz graph "no_name_2" with 0 nodes and 0 edges>
gap> GraphvizAddSubgraph(g);
<graphviz graph "no_name_3" with 0 nodes and 0 edges>
gap> GraphvizAddContext(g);
<graphviz context "no_name_4" with 0 nodes and 0 edges>

# Test no-name constructor graphs' names increment (contexts)
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g);
<graphviz context "no_name_1" with 0 nodes and 0 edges>
gap> GraphvizAddContext(g);
<graphviz context "no_name_2" with 0 nodes and 0 edges>
gap> GraphvizAddContext(g);
<graphviz context "no_name_3" with 0 nodes and 0 edges>

# Test getting subgraphs
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddContext(g, "b");;
gap> GraphvizSubgraphs(g);
rec( a := <graphviz graph "a" with 0 nodes and 0 edges>,
  b := <graphviz context "b" with 0 nodes and 0 edges> )

# Test adding a node to a subgraph (does or does not add to parent???)
# TODO need to nail down expected behaviour!
gap> g := GraphvizGraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddNode(s, "n");;
gap> GraphvizNodes(g);
rec(  )
gap> GraphvizNodes(s);
rec( n := <graphviz node "n"> )

# Test adding a node to a subgraph which is already in parent fails (by name)
gap> g := GraphvizGraph("r");;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddNode(g, "n");;
#@if CompareVersionNumbers(GAPInfo.Version, "4.12")
gap> GraphvizAddNode(s, "n");
Error, the 2nd argument (node) has name "n" but there is already a node with t\
his name in the 1st argument (a graphviz (di)graph / context) named "a"
#@fi

# Test adding a node to a graph which is already in child fails (by name)
gap> g := GraphvizGraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddNode(s, "n");;
#@if CompareVersionNumbers(GAPInfo.Version, "4.12")
gap> GraphvizAddNode(g, "n");
Error, the 2nd argument (node) has name "n" but there is already a node with t\
his name in the 1st argument (a graphviz (di)graph / context) named ""
#@fi

# Test adding a node to a graph which is already in sibling fails (by name)
gap> g := GraphvizGraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(g, "b");;
gap> GraphvizAddNode(s1, "n");;
#@if CompareVersionNumbers(GAPInfo.Version, "4.12")
gap> GraphvizAddNode(s2, "n");
Error, the 2nd argument (node) has name "n" but there is already a node with t\
his name in the 1st argument (a graphviz (di)graph / context) named "b"
#@fi

# Test adding edges to subgraphs
gap> g := GraphvizGraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddEdge(s, "a", "b");
<graphviz edge (a, b)>
gap> g := GraphvizGraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddEdge(s, "a", "b");
<graphviz edge (a, b)>
gap> g := GraphvizGraph();;
gap> s := GraphvizAddContext(g, "a");;
gap> GraphvizAddEdge(s, "a", "b");
<graphviz edge (a, b)>

# Test removing edge from graph does not remove from children, sibling, parent, etc
gap> parent := GraphvizGraph();;
gap> main := GraphvizAddSubgraph(parent, "main");;
gap> sibling := GraphvizAddSubgraph(parent, "sibling");;
gap> child := GraphvizAddSubgraph(main, "child");;
gap> GraphvizAddEdge(parent, "x", "y");;
gap> GraphvizAddEdge(main, "x", "y");;
gap> GraphvizAddEdge(sibling, "x", "y");;
gap> GraphvizAddEdge(child, "x", "y");;
gap> GraphvizRemoveEdges(main, "x", "y");;
gap> GraphvizEdges(g);
[  ]
gap> GraphvizEdges(parent);
[ <graphviz edge (x, y)> ]
gap> GraphvizEdges(sibling);
[ <graphviz edge (x, y)> ]
gap> GraphvizEdges(child);
[ <graphviz edge (x, y)> ]

# Test stringifying subgraph digraph
gap> g := GraphvizDigraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddEdge(g, "x", "y");;
gap> GraphvizSetAttr(s, "color", "red");;
gap> GraphvizSetAttr(s, "node [color=red]");;
gap> GraphvizSetAttr(s, "edge [color=red]");;
gap> AsString(g);
"//dot\ndigraph  {\nsubgraph a {\n\tcolor=red node [color=red] edge [color=red\
] \n}\n\tx\n\ty\n\tx -> y\n}\n"

# Test stringifying subgraph graph
gap> g := GraphvizGraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddEdge(g, "x", "y");;
gap> GraphvizSetAttr(s, "color", "red");;
gap> GraphvizSetAttr(s, "node [color=red]");;
gap> GraphvizSetAttr(s, "edge [color=red]");;
gap> AsString(g);
"//dot\ngraph  {\nsubgraph a {\n\tcolor=red node [color=red] edge [color=red] \
\n}\n\tx\n\ty\n\tx -- y\n}\n"

# Test stringifying subgraph context (graph)
gap> g := GraphvizGraph();;
gap> s := GraphvizAddContext(g, "a");;
gap> GraphvizAddEdge(g, "x", "y");;
gap> GraphvizSetAttr(s, "color", "red");;
gap> GraphvizSetAttr(s, "node [color=red]");;
gap> GraphvizSetAttr(s, "edge [color=red]");;
gap> AsString(g);
"//dot\ngraph  {\n// a context \n\tcolor=red node [color=red] edge [color=red]\
 \n\n\tx\n\ty\n\tx -- y\n}\n"

# Test stringifying subgraph context (digraph)
gap> g := GraphvizDigraph();;
gap> s := GraphvizAddContext(g, "a");;
gap> GraphvizAddEdge(g, "x", "y");;
gap> GraphvizSetAttr(s, "color", "red");;
gap> GraphvizSetAttr(s, "node [color=red]");;
gap> GraphvizSetAttr(s, "edge [color=red]");;
gap> AsString(g);
"//dot\ndigraph  {\n// a context \n\tcolor=red node [color=red] edge [color=re\
d] \n\n\tx\n\ty\n\tx -> y\n}\n"

# Test stringifying subgraph w/o name
gap> g := GraphvizDigraph();;
gap> s := GraphvizAddSubgraph(g);;
gap> AsString(g);
"//dot\ndigraph  {\nsubgraph no_name_1 {\n}\n}\n"

# finding a node in a sibling graph
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g);;
gap> GraphvizAddNode(s1, "a");;
gap> s2 := GraphvizAddSubgraph(g);;
gap> GV_FindNode(s2, "a");
<graphviz node "a">
gap> GV_FindNode(s2, "b");
fail

# finding a node in a child graph
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g);;
gap> GraphvizAddNode(s1, "a");;
gap> GV_FindNode(g, "a");
<graphviz node "a">
gap> GV_FindNode(g, "b");
fail

# finding a node in a parent graph
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g);;
gap> GraphvizAddNode(g, "a");;
gap> GV_FindNode(s1, "a");
<graphviz node "a">
gap> GV_FindNode(s1, "b");
fail

# finding a node in a parent's sibling graph
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g);;
gap> s2 := GraphvizAddSubgraph(g);;
gap> s11 := GraphvizAddSubgraph(s1);;
gap> GraphvizAddNode(s2, "a");;
gap> GV_FindNode(s11, "a");
<graphviz node "a">
gap> GV_FindNode(s11, "b");
fail

# Test removing a node from a graph
gap> parent := GraphvizDigraph();;
gap> g := GraphvizAddSubgraph(parent);;
gap> sibling := GraphvizAddSubgraph(parent);;
gap> child := GraphvizAddSubgraph(g);;
gap> a := GraphvizAddNode(parent, "a");;
gap> GraphvizAddNode(sibling, "b");;
gap> GraphvizAddNode(child, "c");;
gap> GraphvizAddNode(g, "d");;
gap> GraphvizRemoveNode(g, "d");;
gap> GraphvizNodes(g);
rec(  )
gap> GraphvizNodes(parent);
rec( a := <graphviz node "a"> )
gap> GraphvizNodes(sibling);
rec( b := <graphviz node "b"> )
gap> GraphvizNodes(child);
rec( c := <graphviz node "c"> )

# Test context attribute resetting
gap> g := GraphvizDigraph();;
gap> ctx := GraphvizAddContext(g);;
gap> GraphvizSetAttr(g, "color", "green");;
gap> GraphvizSetAttr(g, "edge [label=testing123]");;
gap> GraphvizSetAttr(g, "node[color=blue]");;
gap> GraphvizSetAttr(g, "edge[color=blue]");;
gap> GraphvizSetAttr(ctx, "node[color=red]");;
gap> GraphvizAddNode(ctx, "a");;
gap> AsString(g);
"//dot\ndigraph  {\n\tcolor=green edge [label=testing123] node[color=blue] edg\
e[color=blue] \n// no_name_1 context \n\tnode[color=red] \n\ta\n\tcolor=green \
edge [label=testing123] node[color=blue] edge[color=blue] \n\n}\n"

# Test adding subgraphs with the same name
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
#@if CompareVersionNumbers(GAPInfo.Version, "4.12")
gap> s2 := GraphvizAddSubgraph(g, "a");
Error, the 1st argument (a graphviz (di)graph/context) already has a subgraph \
with name "a"
#@else
gap> s2 := GraphvizAddSubgraph(g, "a");
Error, the 1st argument (a graphviz (di)graph/context) already has a subgraph \
with na\
me "a"
#@fi

# Test getting subgraphs by name
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(g, "b");;
gap> GraphvizSubgraphs(g)["a"];
<graphviz digraph "a" with 0 nodes and 0 edges>
gap> GraphvizSubgraphs(g)["b"];
<graphviz digraph "b" with 0 nodes and 0 edges>
gap> GraphvizSubgraphs(g)["d"];
fail

# Test getting context (subgraph) by name
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddContext(g, "c");;
gap> GraphvizSubgraphs(g)["a"];
<graphviz digraph "a" with 0 nodes and 0 edges>
gap> GraphvizSubgraphs(g)["c"];
<graphviz context "c" with 0 nodes and 0 edges>

# Test adding a nested subgraph
gap> g := GraphvizGraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(s1, "c");;
gap> GraphvizSubgraphs(g)["a"];
<graphviz graph "a" with 0 nodes and 0 edges>
gap> GraphvizSubgraphs(g)["c"];
fail
gap> GraphvizSubgraphs(s1)["c"];
<graphviz graph "c" with 0 nodes and 0 edges>

# Test displaying a nested subgraph
gap> g := GraphvizGraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(s1, "c");;
gap> AsString(g);
"//dot\ngraph  {\nsubgraph a {\nsubgraph c {\n}\n}\n}\n"

# Test subgraphs with non-string names
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g, 11);
<graphviz graph "11" with 0 nodes and 0 edges>

# Test contexts with non-string names
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g, 11);
<graphviz context "11" with 0 nodes and 0 edges>

# Test getting subgraphs with non-string names
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g, ["a"]);;
gap> GraphvizSubgraphs(g)[["a"]];
<graphviz context "[ "a" ]" with 0 nodes and 0 edges>

# Test finding subgraph (parent)
gap> g := GraphvizGraph("a");;
gap> s := GraphvizAddSubgraph(g, "b");;
gap> o := GraphvizFindSubgraphRecursive(s, "a");
<graphviz graph "a" with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, g);
true

# Test finding subgraph (child)
gap> g := GraphvizGraph("a");;
gap> s := GraphvizAddSubgraph(g, "b");;
gap> o := GraphvizFindSubgraphRecursive(g, "b");
<graphviz graph "b" with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s);
true

# Test finding subgraph (sibling)
gap> g  := GraphvizGraph("a");;
gap> s  := GraphvizAddSubgraph(g, "b");;
gap> s2 := GraphvizAddSubgraph(g, "c");;
gap> o  := GraphvizFindSubgraphRecursive(s, "c");
<graphviz graph "c" with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s2);
true

# Test finding subgraph (self)
gap> g := GraphvizGraph("a");;
gap> o := GraphvizFindSubgraphRecursive(g, "a");
<graphviz graph "a" with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, g);
true

# Test finding subgraph (far)
gap> g  := GraphvizGraph("r");;
gap> a1 := GraphvizAddSubgraph(g, "a1");;
gap> a2 := GraphvizAddSubgraph(a1, "a2");;
gap> a3 := GraphvizAddSubgraph(a2, "a3");;
gap> b1 := GraphvizAddSubgraph(g, "b1");;
gap> b2 := GraphvizAddSubgraph(b1, "b2");;
gap> b3 := GraphvizAddSubgraph(b2, "b3");;
gap> o  := GraphvizFindSubgraphRecursive(a3, "b3");
<graphviz graph "b3" with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, b3);
true

# Test nested contexts have correct edge types (graph)
gap> g      := GraphvizGraph("g");;
gap> parent := GraphvizAddContext(g, "parent");;
gap> ctx    := GraphvizAddContext(parent, "ctx");;
gap> GraphvizAddEdge(ctx, "a", "b");;
gap> AsString(g);
"//dot\ngraph g {\n// parent context \n// ctx context \n\ta\n\tb\n\ta -- b\n\n\
\n}\n"

# Test nested contexts have correct edge types (digraph)
gap> g      := GraphvizDigraph("g");;
gap> parent := GraphvizAddContext(g, "parent");;
gap> ctx    := GraphvizAddContext(parent, "ctx");;
gap> GraphvizAddEdge(ctx, "a", "b");;
gap> AsString(g);
"//dot\ndigraph g {\n// parent context \n// ctx context \n\ta\n\tb\n\ta -> b\n\
\n\n}\n"

# Test finding subgraph (non-string name)
gap> g := GraphvizGraph("r");;
gap> s := GraphvizAddSubgraph(g, 1);;
gap> o := GraphvizFindSubgraphRecursive(g, 1);
<graphviz graph "1" with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s);
true

# Test a context containing a subgraph
gap> gv := GraphvizGraph("context+subgraph");;
gap> GraphvizSetAttr(gv, "node [shape=\"box\"]");
<graphviz graph "context+subgraph" with 0 nodes and 0 edges>
gap> legend := GraphvizAddContext(gv, "legend");
<graphviz context "legend" with 0 nodes and 0 edges>
gap> GraphvizSetAttr(legend, "node [shape=plaintext]");
<graphviz context "legend" with 0 nodes and 0 edges>
gap> GraphvizAddSubgraph(legend, "legend");
<graphviz graph "legend" with 0 nodes and 0 edges>
gap> Print(AsString(gv));
//dot
graph context+subgraph {
	node [shape="box"]
// legend context
	node [shape=plaintext]
subgraph legend {
}
	node [shape="box"]

}

# Test a context containing a subdigraph
gap> gv := GraphvizDigraph("context+subgraph");;
gap> GraphvizSetAttr(gv, "node [shape=\"box\"]");
<graphviz digraph "context+subgraph" with 0 nodes and 0 edges>
gap> legend := GraphvizAddContext(gv, "legend");
<graphviz context "legend" with 0 nodes and 0 edges>
gap> GraphvizSetAttr(legend, "node [shape=plaintext]");
<graphviz context "legend" with 0 nodes and 0 edges>
gap> GraphvizAddSubgraph(legend, "legend");
<graphviz digraph "legend" with 0 nodes and 0 edges>

# Test node numbers when subgraphs are present
gap> g := GraphvizGraph("main");;
gap> a := GraphvizAddSubgraph(g, 1);;
gap> b := GraphvizAddSubgraph(g, 2);;
gap> c := GraphvizAddSubgraph(a, 3);;  # nested subgraph
gap> GraphvizAddNode(g, 1);;
gap> Perform([0 .. 1], x -> GraphvizAddNode(a, 2 + x));;
gap> Perform([0 .. 2], x -> GraphvizAddNode(a, 4 + x));;
gap> Perform([0 .. 3], x -> GraphvizAddNode(a, 7 + x));;
gap> g;
<graphviz graph main with 10 nodes and 0 edges>

#
gap> STOP_TEST("graphviz package: subgraph.tst", 0);
