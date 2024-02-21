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
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g, IsGVGraph, "test-graph");
<graph test-graph with 0 nodes and 0 edges>
gap> g := GV_Digraph();;
gap> GV_AddSubgraph(g, IsGVDigraph, "test-digraph");
<digraph test-digraph with 0 nodes and 0 edges>
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g, IsGVContext, "test-context");
<context test-context with 0 nodes and 0 edges>

# Test no-name constructors
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g, IsGVGraph);
<graph with 0 nodes and 0 edges>
gap> g := GV_Digraph();;
gap> GV_AddSubgraph(g, IsGVDigraph);
<digraph with 0 nodes and 0 edges>
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g, IsGVContext);
<context with 0 nodes and 0 edges>

# Test getting subgraphs
gap> g := GV_Graph();;
gap> GV_AddSubgraph(g, IsGVGraph, "a");;
gap> GV_AddSubgraph(g, IsGVContext, "b");;
gap> GV_Subgraphs(g);
[ <graph a with 0 nodes and 0 edges>, <context b with 0 nodes and 0 edges> ]

# Test adding a node to a subgraph (does or does not add to parent???)
# TODO need to nail down expected behaviour!
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> GV_AddNode(s, "n");;
gap> GV_Nodes(g);
HashMap([])
gap> GV_Nodes(s);
HashMap([[ "n", <object> ]])

# Test adding a node to a subgraph which is already in parent uses the parent's node
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> nodeg := GV_AddNode(g, "n");;
gap> nodes := GV_AddNode(s, "n");;
gap> IsIdenticalObj(nodeg, nodes);
true

# Test adding a node to a graph which is already in child uses the child's node
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> nodes := GV_AddNode(s, "n");;
gap> nodeg := GV_AddNode(g, "n");;
gap> IsIdenticalObj(nodeg, nodes);
true

# Test adding a node to a graph which is already in sibling uses the siblings's node
gap> g := GV_Graph();;
gap> s1 := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> s2 := GV_AddSubgraph(g, IsGVGraph, "b");;
gap> nodes := GV_AddNode(s1, "n");;
gap> nodeg := GV_AddNode(s2, "n");;
gap> IsIdenticalObj(nodeg, nodes);
true

# Test fails adding a new node to a graph which when sibling has different node with same name
gap> g := GV_Graph();;
gap> s1 := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> s2 := GV_AddSubgraph(g, IsGVGraph, "b");;
gap> new_node := GV_Node("n");;
gap> nodes := GV_AddNode(s1, "n");;
gap> nodeg := GV_AddNode(s2, new_node);
Error, Already node with name n.

# Test fails adding a new node to a graph which when parent has different node with same name
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> new_node := GV_Node("n");;
gap> nodes := GV_AddNode(g, "n");;
gap> nodeg := GV_AddNode(s, new_node);
Error, Already node with name n.

# Test fails adding a new node to a graph which when child has different node with same name
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> new_node := GV_Node("n");;
gap> nodes := GV_AddNode(s, "n");;
gap> nodeg := GV_AddNode(g, new_node);
Error, Already node with name n.

# Test adding edges to subgraphs
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> GV_AddEdge(s, "a", "b");
<edge (a, b)>
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVDigraph, "a");;
gap> GV_AddEdge(s, "a", "b");
<edge (a, b)>
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVContext, "a");;
gap> GV_AddEdge(s, "a", "b");
<edge (a, b)>

# Test removing node from parent removes from children
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> GV_AddNode(g, "n");;
gap> GV_AddNode(s, "n");;
gap> GV_RemoveNode(g, "n");;
gap> GV_Nodes(g);
HashMap([])
gap> GV_Nodes(s);
HashMap([])

# Test removing node from children does not remove from parent
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> GV_AddNode(g, "n");;
gap> GV_AddNode(s, "n");;
gap> GV_RemoveNode(s, "n");;
gap> GV_Nodes(g);
HashMap([[ "n", <object> ]])
gap> GV_Nodes(s);
HashMap([])

# Test removing edge from parent removes from children
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_AddEdge(s, "x", "y");;
gap> GV_FilterEnds(g, "x", "y");;
gap> GV_Edges(g);
[  ]
gap> GV_Edges(s);
[  ]

# Test removing edge from parent removes from children
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_AddEdge(s, "x", "y");;
gap> GV_FilterEnds(s, "x", "y");;
gap> GV_Edges(g);
[ <edge (x, y)> ]
gap> GV_Edges(s);
[  ]

# Test stringifying subgraph digraph
gap> g := GV_Digraph();;
gap> s := GV_AddSubgraph(g, IsGVDigraph, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_SetAttr(s, "color", "red");;
gap> GV_SetAttr(s, "node [color=red]");;
gap> GV_SetAttr(s, "edge [color=red]");;
gap> GV_String(g);
"digraph  {\nsubgraph a {\n\tcolor=\"red\" node [color=red] edge [color=red] \
\n}\n\t\"x\"\n\t\"y\"\n\t\"x\" -> \"y\"\n}\n"

# Test stringifying subgraph graph
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVGraph, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_SetAttr(s, "color", "red");;
gap> GV_SetAttr(s, "node [color=red]");;
gap> GV_SetAttr(s, "edge [color=red]");;
gap> GV_String(g);
"graph  {\nsubgraph a {\n\tcolor=\"red\" node [color=red] edge [color=red] \n}\
\n\t\"x\"\n\t\"y\"\n\t\"x\" -- \"y\"\n}\n"

# Test stringifying subgraph context (graph)
gap> g := GV_Graph();;
gap> s := GV_AddSubgraph(g, IsGVContext, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_SetAttr(s, "color", "red");;
gap> GV_SetAttr(s, "node [color=red]");;
gap> GV_SetAttr(s, "edge [color=red]");;
gap> GV_String(g);
"graph  {\n// a context \n\tcolor=\"red\" node [color=red] edge [color=red] \n\
\n\t\"x\"\n\t\"y\"\n\t\"x\" -- \"y\"\n}\n"

# Test stringifying subgraph context (digraph)
gap> g := GV_Digraph();;
gap> s := GV_AddSubgraph(g, IsGVContext, "a");;
gap> GV_AddEdge(g, "x", "y");;
gap> GV_SetAttr(s, "color", "red");;
gap> GV_SetAttr(s, "node [color=red]");;
gap> GV_SetAttr(s, "edge [color=red]");;
gap> GV_String(g);
"digraph  {\n// a context \n\tcolor=\"red\" node [color=red] edge [color=red] \
\n\n\t\"x\"\n\t\"y\"\n\t\"x\" -> \"y\"\n}\n"

# Test stringifying subgraph w/o name
gap> g := GV_Digraph();;
gap> s := GV_AddSubgraph(g, IsGVDigraph);;
gap> GV_String(g);
"digraph  {\nsubgraph  {\n}\n}\n"

#