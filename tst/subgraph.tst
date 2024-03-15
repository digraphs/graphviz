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

# Test creating subgraphs (named)
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g, "test-graph");
<graphviz graph test-graph with 0 nodes and 0 edges>
gap> g := GraphvizDigraph();;
gap> GraphvizAddSubgraph(g, "test-digraph");
<graphviz digraph test-digraph with 0 nodes and 0 edges>
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g, "test-context");
<graphviz context test-context with 0 nodes and 0 edges>

# Test no-name constructors
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g);
<graphviz graph no_name_1 with 0 nodes and 0 edges>
gap> g := GraphvizDigraph();;
gap> GraphvizAddSubgraph(g);
<graphviz digraph no_name_1 with 0 nodes and 0 edges>
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g);
<graphviz context no_name_1 with 0 nodes and 0 edges>

# Test no-name constructor graphs' names increment
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g);
<graphviz graph no_name_1 with 0 nodes and 0 edges>
gap> GraphvizAddSubgraph(g);
<graphviz graph no_name_2 with 0 nodes and 0 edges>
gap> GraphvizAddSubgraph(g);
<graphviz graph no_name_3 with 0 nodes and 0 edges>
gap> GraphvizAddContext(g);
<graphviz context no_name_4 with 0 nodes and 0 edges>

# Test no-name constructor graphs' names increment (contexts)
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g);
<graphviz context no_name_1 with 0 nodes and 0 edges>
gap> GraphvizAddContext(g);
<graphviz context no_name_2 with 0 nodes and 0 edges>
gap> GraphvizAddContext(g);
<graphviz context no_name_3 with 0 nodes and 0 edges>

# Test getting subgraphs
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddContext(g, "b");;
gap> GraphvizSubgraphs(g);
rec( a := <object>, b := <object> )

# Test adding a node to a subgraph (does or does not add to parent???)
# TODO need to nail down expected behaviour!
gap> g := GraphvizGraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddNode(s, "n");;
gap> GraphvizNodes(g);
rec(  )
gap> GraphvizNodes(s);
rec( n := <object> )

# Test adding a node to a subgraph which is already in parent fails (by name)
gap> g := GraphvizGraph("r");;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddNode(g, "n");;
gap> GraphvizAddNode(s, "n");
Error, Already node with name n in graph r.

# Test adding a node to a graph which is already in child fails (by name)
gap> g := GraphvizGraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddNode(s, "n");;
gap> GraphvizAddNode(g, "n");
Error, Already node with name n in graph a.

# Test adding a node to a graph which is already in sibling fails (by name)
gap> g := GraphvizGraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(g, "b");;
gap> GraphvizAddNode(s1, "n");;
gap> GraphvizAddNode(s2, "n");
Error, Already node with name n in graph a.

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
gap> GraphvizFilterEnds(main, "x", "y");;
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
"digraph  {\nsubgraph a {\n\tcolor=\"red\" node [color=red] edge [color=red] \
\n}\n\t\"x\"\n\t\"y\"\n\t\"x\" -> \"y\"\n}\n"

# Test stringifying subgraph graph
gap> g := GraphvizGraph();;
gap> s := GraphvizAddSubgraph(g, "a");;
gap> GraphvizAddEdge(g, "x", "y");;
gap> GraphvizSetAttr(s, "color", "red");;
gap> GraphvizSetAttr(s, "node [color=red]");;
gap> GraphvizSetAttr(s, "edge [color=red]");;
gap> AsString(g);
"graph  {\nsubgraph a {\n\tcolor=\"red\" node [color=red] edge [color=red] \n}\
\n\t\"x\"\n\t\"y\"\n\t\"x\" -- \"y\"\n}\n"

# Test stringifying subgraph context (graph)
gap> g := GraphvizGraph();;
gap> s := GraphvizAddContext(g, "a");;
gap> GraphvizAddEdge(g, "x", "y");;
gap> GraphvizSetAttr(s, "color", "red");;
gap> GraphvizSetAttr(s, "node [color=red]");;
gap> GraphvizSetAttr(s, "edge [color=red]");;
gap> AsString(g);
"graph  {\n// a context \n\tcolor=\"red\" node [color=red] edge [color=red] \n\
\n\t\"x\"\n\t\"y\"\n\t\"x\" -- \"y\"\n}\n"

# Test stringifying subgraph context (digraph)
gap> g := GraphvizDigraph();;
gap> s := GraphvizAddContext(g, "a");;
gap> GraphvizAddEdge(g, "x", "y");;
gap> GraphvizSetAttr(s, "color", "red");;
gap> GraphvizSetAttr(s, "node [color=red]");;
gap> GraphvizSetAttr(s, "edge [color=red]");;
gap> AsString(g);
"digraph  {\n// a context \n\tcolor=\"red\" node [color=red] edge [color=red] \
\n\n\t\"x\"\n\t\"y\"\n\t\"x\" -> \"y\"\n}\n"

# Test stringifying subgraph w/o name
gap> g := GraphvizDigraph();;
gap> s := GraphvizAddSubgraph(g);;
gap> AsString(g);
"digraph  {\nsubgraph no_name_1 {\n}\n}\n"

# finding a node in a sibling graph
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g);;
gap> GraphvizAddNode(s1, "a");;
gap> s2 := GraphvizAddSubgraph(g);;
gap> GraphvizFindNode(s2, "a");
<graphviz node a>
gap> GraphvizFindNode(s2, "b");
fail

# finding a node in a child graph
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g);;
gap> GraphvizAddNode(s1, "a");;
gap> GraphvizFindNode(g, "a");
<graphviz node a>
gap> GraphvizFindNode(g, "b");
fail

# finding a node in a parent graph
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g);;
gap> GraphvizAddNode(g, "a");;
gap> GraphvizFindNode(s1, "a");
<graphviz node a>
gap> GraphvizFindNode(s1, "b");
fail

# finding a node in a parent's sibling graph
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g);;
gap> s2 := GraphvizAddSubgraph(g);;
gap> s11 := GraphvizAddSubgraph(s1);;
gap> GraphvizAddNode(s2, "a");;
gap> GraphvizFindNode(s11, "a");
<graphviz node a>
gap> GraphvizFindNode(s11, "b");
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
rec( a := <object> )
gap> GraphvizNodes(sibling);
rec( b := <object> )
gap> GraphvizNodes(child);
rec( c := <object> )

# Test context attribute resetting
gap> g := GraphvizDigraph();;
gap> ctx := GraphvizAddContext(g);;
gap> GraphvizSetAttr(g, "color", "green");;
gap> GraphvizSetAttr(g, "edge [label=\"testing123\"]");;
gap> GraphvizSetAttr(g, "node[color=\"blue\"]");;
gap> GraphvizSetAttr(g, "edge[color=\"blue\"]");;
gap> GraphvizSetAttr(ctx, "node[color=\"red\"]");;
gap> GraphvizAddNode(ctx, "a");;
gap> AsString(g);
"digraph  {\n\tcolor=\"green\" edge [label=\"testing123\"] node[color=\"blue\"\
] edge[color=\"blue\"] \n// no_name_1 context \n\tnode[color=\"red\"] \n\t\"a\
\"\n\tcolor=\"green\" edge [label=\"testing123\"] node[color=\"blue\"] edge[co\
lor=\"blue\"] \n\n}\n"

# Test adding subgraphs with the same name
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(g, "a");
Error, The graph already contains a subgraph with name a.

# Test getting subgraphs by name
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(g, "b");;
gap> GraphvizGetSubgraph(g, "a");
<graphviz digraph a with 0 nodes and 0 edges>
gap> GraphvizGetSubgraph(g, "b");
<graphviz digraph b with 0 nodes and 0 edges>
gap> GraphvizGetSubgraph(g, "d");
fail

# Test getting context (subgraph) by name
gap> g := GraphvizDigraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddContext(g, "c");;
gap> GraphvizGetSubgraph(g, "a");
<graphviz digraph a with 0 nodes and 0 edges>
gap> GraphvizGetSubgraph(g, "c");
<graphviz context c with 0 nodes and 0 edges>

# Test adding a nested subgraph
gap> g := GraphvizGraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(s1, "c");;
gap> GraphvizGetSubgraph(g, "a");
<graphviz graph a with 0 nodes and 0 edges>
gap> GraphvizGetSubgraph(g, "c");
fail
gap> GraphvizGetSubgraph(s1, "c");
<graphviz graph c with 0 nodes and 0 edges>

# Test displaying a nested subgraph
gap> g := GraphvizGraph();;
gap> s1 := GraphvizAddSubgraph(g, "a");;
gap> s2 := GraphvizAddSubgraph(s1, "c");;
gap> AsString(g);
"graph  {\nsubgraph a {\nsubgraph c {\n}\n}\n}\n"

# Test subgraphs with non-string names
gap> g := GraphvizGraph();;
gap> GraphvizAddSubgraph(g, 11);
<graphviz graph 11 with 0 nodes and 0 edges>

# Test contexts with non-string names
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g, 11);
<graphviz context 11 with 0 nodes and 0 edges>

# Test getting subgraphs with non-string names
gap> g := GraphvizGraph();;
gap> GraphvizAddContext(g, [ "a" ]);;
gap> GraphvizGetSubgraph(g, [ "a" ]);
<graphviz context [ "a" ] with 0 nodes and 0 edges>

# Test finding subgraph (parent)
gap> g := GraphvizGraph("a");;
gap> s := GraphvizAddSubgraph(g, "b");;
gap> o := GraphvizFindGraph(s, "a");
<graphviz graph a with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, g);
true

# Test finding subgraph (child)
gap> g := GraphvizGraph("a");;
gap> s := GraphvizAddSubgraph(g, "b");;
gap> o := GraphvizFindGraph(g, "b");
<graphviz graph b with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s);
true

# Test finding subgraph (sibling)
gap> g := GraphvizGraph("a");;
gap> s := GraphvizAddSubgraph(g, "b");;
gap> s2 := GraphvizAddSubgraph(g, "c");;
gap> o := GraphvizFindGraph(s, "c");
<graphviz graph c with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s2);
true

# Test finding subgraph (self)
gap> g := GraphvizGraph("a");;
gap> o := GraphvizFindGraph(g, "a");
<graphviz graph a with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, g);
true

# Test finding subgraph (far)
gap> g := GraphvizGraph("r");;
gap> a1 := GraphvizAddSubgraph(g, "a1");;
gap> a2 := GraphvizAddSubgraph(a1, "a2");;
gap> a3 := GraphvizAddSubgraph(a2, "a3");;
gap> b1 := GraphvizAddSubgraph(g, "b1");;
gap> b2 := GraphvizAddSubgraph(b1, "b2");;
gap> b3 := GraphvizAddSubgraph(b2, "b3");;
gap> o := GraphvizFindGraph(a3, "b3");
<graphviz graph b3 with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, b3);
true

# Test finding subgraph (non-string name)
gap> g := GraphvizGraph("r");;
gap> s := GraphvizAddSubgraph(g, 1);;
gap> o := GraphvizFindGraph(g, 1);
<graphviz graph 1 with 0 nodes and 0 edges>
gap> IsIdenticalObj(o, s);
true

#