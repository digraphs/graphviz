#############################################################################
##
##  dot.gd
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#! @Chapter
#! @ChapterTitle Getting started
#! This chapter very briefly explains what &DOT; and &Graphviz; are, provides
#! some key basic concepts relating to them, and how this package interacts
#! with them.

#! @Section A brief introduction
#! &DOT; is a language for describing to a computer how to display a
#! visualization of a graph or digraph. &Graphviz; is a graph visualization
#! software which can consume &DOT; and produce visual outputs. This package is
#! designed to allow users to programmatically construct objects in &GAP; which
#! can then be converted into &DOT;. That &DOT; can then be input to the
#! &Graphviz; software to produce a visual output. As &DOT; is central to the
#! design of this package it will likely be helpful to have a basic
#! understanding of the language. For more information about &DOT; see
#! <URL>https://graphviz.org/doc/info/lang.html</URL>.
#! <P/>
#!
#! The &GAPGraphviz; package for &GAP; is intended to facilitate the creation
#! and rendering of graph descriptions in the &DOT; language of the &Graphviz;
#! graph drawing software.
#! <P/>
#!
#! You can create a &GAPGraphviz; object, assemble the graph by adding nodes
#! and edges, setting attributes, labels and so on, and retrieve its &DOT;
#! source code string. You can save the source code
#! to a file (using <Ref Func="FileString" BookName="gapdoc"/>) and render it
#! with the &Graphviz; installation of your system; or you can
#! use the <Ref Func="Splash"/> function to directly inspect the resulting
#! graph (depending on your system and the software installed).

#! @Section What this package is not
#!
#! This package does not implement a parser of the &DOT; language and does only
#! minimal checks when assembling a graph. In particular, if you set attributes
#! which don't exist in &DOT;, then the resulting string might not be valid,
#! and might not render correctly using &Graphviz;.

#! @Section A first example
#! Here's an example of how to use the &GAPGraphviz; package, to construct a
#! &DOT; representation of a finite state automata. This example is taken from
#! <URL>https://graphviz.readthedocs.io/en/stable/examples.html</URL> or
#! <URL>https://graphviz.org/Gallery/directed/fsm.html</URL>.
#!
#! @BeginLogSession
#! gap> LoadPackage("GraphvizForGAP");;
#! gap> f := GraphvizDigraph("finite_state_machine");
#! <graphviz digraph "finite_state_machine" with 0 nodes and 0 edges>
#! gap> GraphvizSetAttr(f, "rankdir=LR");
#! <graphviz digraph "finite_state_machine" with 0 nodes and 0 edges>
#! gap> GraphvizSetAttr(f, "size=\"8,5\"");
#! <graphviz digraph "finite_state_machine" with 0 nodes and 0 edges>
#! gap> terminals := GraphvizAddContext(f, "terminals");
#! <graphviz context "terminals" with 0 nodes and 0 edges>
#! gap> GraphvizSetAttr(terminals, "node [shape=doublecircle]");
#! <graphviz context "terminals" with 0 nodes and 0 edges>
#! gap> GraphvizAddNode(terminals, "LR_0");
#! <graphviz node "LR_0">
#! gap> GraphvizAddNode(terminals, "LR_3");
#! <graphviz node "LR_3">
#! gap> GraphvizAddNode(terminals, "LR_4");
#! <graphviz node "LR_4">
#! gap> GraphvizAddNode(terminals, "LR_8");
#! <graphviz node "LR_8">
#! gap> nodes := GraphvizAddContext(f, "nodes");
#! <graphviz context "nodes" with 0 nodes and 0 edges>
#! gap> GraphvizSetAttr(nodes, "node [shape=circle]");
#! <graphviz context "nodes" with 0 nodes and 0 edges>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_0", "LR_2"), "label", "\"SS(B)\"");
#! <graphviz edge (LR_0, LR_2)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_0", "LR_1"), "label", "\"SS(S)\"");
#! <graphviz edge (LR_0, LR_1)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_1", "LR_3"), "label", "\"S($end)\"");
#! <graphviz edge (LR_1, LR_3)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_6"), "label", "\"SS(b)\"");
#! <graphviz edge (LR_2, LR_6)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_5"), "label", "\"SS(a)\"");
#! <graphviz edge (LR_2, LR_5)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_4"), "label", "\"S(A)\"");
#! <graphviz edge (LR_2, LR_4)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_5", "LR_7"), "label", "\"S(b)\"");
#! <graphviz edge (LR_5, LR_7)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_5", "LR_5"), "label", "\"S(a)\"");
#! <graphviz edge (LR_5, LR_5)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_6", "LR_6"), "label", "\"S(b)\"");
#! <graphviz edge (LR_6, LR_6)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_6", "LR_5"), "label", "\"S(a)\"");
#! <graphviz edge (LR_6, LR_5)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_7", "LR_8"), "label", "\"S(b)\"");
#! <graphviz edge (LR_7, LR_8)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_7", "LR_5"), "label", "\"S(a)\"");
#! <graphviz edge (LR_7, LR_5)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_8", "LR_6"), "label", "\"S(b)\"");
#! <graphviz edge (LR_8, LR_6)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_8", "LR_5"), "label", "\"S(a)\"");
#! <graphviz edge (LR_8, LR_5)>
#! gap> Print(AsString(f), "\n");
#! //dot
#! digraph finite_state_machine {
#!     rankdir=LR size="8,5"
#! // terminals context
#!  {
#!     node [shape=doublecircle]
#!     LR_0
#!     LR_3
#!     LR_4
#!     LR_8
#!     rankdir=LR size="8,5"
#!  }
#! // nodes context
#!  {
#!     node [shape=circle]
#!     LR_2
#!     LR_0 -> LR_2 [label="SS(B)"]
#!     LR_1
#!     LR_0 -> LR_1 [label="SS(S)"]
#!     LR_1 -> LR_3 [label="S($end)"]
#!     LR_6
#!     LR_2 -> LR_6 [label="SS(b)"]
#!     LR_5
#!     LR_2 -> LR_5 [label="SS(a)"]
#!     LR_2 -> LR_4 [label="S(A)"]
#!     LR_7
#!     LR_5 -> LR_7 [label="S(b)"]
#!     LR_5 -> LR_5 [label="S(a)"]
#!     LR_6 -> LR_6 [label="S(b)"]
#!     LR_6 -> LR_5 [label="S(a)"]
#!     LR_7 -> LR_8 [label="S(b)"]
#!     LR_7 -> LR_5 [label="S(a)"]
#!     LR_8 -> LR_6 [label="S(b)"]
#!     LR_8 -> LR_5 [label="S(a)"]
#!     rankdir=LR size="8,5"
#!  }
#!
#! }
#! gap> Splash(f);
#! @EndLogSession
#!
#! Provided that you have &Graphviz; installed on your computer, the last line
#! of the example <C>Splash(f)</C> would produce the following picture:
#!
#! <Alt Only="HTML">
#!     <![CDATA[
#!     <figure>
#!         <img src="img/fsm.svg" alt="finite state machine"
#!              style="max-width: 100%"/>
#!     </figure>
#!     ]]>
#! </Alt>
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\textwidth]{img/fsm.pdf}
#!     \end{center}
#! </Alt>
#! <Alt Only="Text">
#!     (The picture is only shown in the HTML and PDF versions of this manual.)
#! </Alt>
#!
#! There are lots more examples in the <F>examples</F> directory within the
#! &Graphviz; package for &GAP; directory.

#! @Chapter Full Reference
#! This chapter contains all of the gory details about the functionality of the
#! &GAPGraphviz; package for &GAP;.

#! @Section Graphviz Categories
#! @BeginGroup
#! Every object in graphviz belongs to the <C>IsGraphvizObject</C>
#! category. The categories following it are for further specificity on the
#! type of objects. These are graphs, digraphs, contexts, nodes, and
#! edges, and combinations of these that have some common features.
DeclareCategory("IsGraphvizObject", IsObject);
#!
DeclareCategory("IsGraphvizGraphDigraphOrContext", IsGraphvizObject);
#!
DeclareCategory("IsGraphvizGraph", IsGraphvizGraphDigraphOrContext);
#!
DeclareCategory("IsGraphvizDigraph", IsGraphvizGraphDigraphOrContext);
#!
DeclareCategory("IsGraphvizContext", IsGraphvizGraphDigraphOrContext);
#!
DeclareCategory("IsGraphvizNodeOrEdge", IsGraphvizObject);
#!
DeclareCategory("IsGraphvizNode", IsGraphvizNodeOrEdge);
#!
DeclareCategory("IsGraphvizEdge", IsGraphvizNodeOrEdge);
#! The names of these categories are fairly descriptive, where a graph
#! has undirected edges, a digraph has directed edges, and a context is
#! a part of a &Graphviz; file/string consisting of objects (nodes,
#! edges, further contexts, subgraphs etc) that share some common
#! attributes.
#! @EndGroup

#! @Section Constructors

#! @BeginGroup
#! @GroupTitle Creating a new &GAPGraphviz; graphs
#! @Arguments name
#! @Returns a &GAPGraphviz; graph.
#! @Description These operations create a new &GAPGraphviz; graph objects.
#!
#! In the first form, the created &GAPGraphviz; graph object has name
#! <A>name</A>. In the second form, the constructed &GAPGraphviz; graph
#! object has an empty string as a name.
#!
#! The argument <A>name</A> can be any &GAP; object for which there is a
#! <Ref Attr="String" BookName="ref"/> method, and the name of the
#! created object will be equal to <C>String(name)</C>.
#!
#! A "graph" in &Graphviz; has undirected edges that are represented
#! using the string <C>"--"</C> in the &DOT; language.
#!
#! See also:
#! * <Ref Oper="GraphvizDigraph" Label="for IsObject"/>
#! * <Ref Oper="GraphvizSetName"
#!    Label="for IsGraphvizGraphDigraphOrContext, IsObject"/>
#! * <Ref Oper="GraphvizName" Label="for IsGraphvizObject"/>
#!
#! @BeginExampleSession
#! gap> gv := GraphvizGraph("GraphyMcGraphFace");
#! <graphviz graph "GraphyMcGraphFace" with 0 nodes and 0 edges>
#! gap> GraphvizName(gv);
#! "GraphyMcGraphFace"
#! gap> GraphvizGraph(666);
#! <graphviz graph "666" with 0 nodes and 0 edges>
#! gap> gv := GraphvizGraph();
#! <graphviz graph with 0 nodes and 0 edges>
#! gap> GraphvizName(gv);
#! ""
#! @EndExampleSession
DeclareOperation("GraphvizGraph", [IsObject]);
#!
DeclareOperation("GraphvizGraph", []);
#! @EndGroup

# TODO: deprecate

#! @BeginGroup
#! @GroupTitle Creating a new &GAPGraphviz; digraphs
#! @Arguments name
#! @Returns a &GAPGraphviz; digraph
#! @Description These operations create a new &GAPGraphviz; digraph objects.
#!
#! In the first form, the created &GAPGraphviz; digraph object has name
#! <A>name</A>. In the second form, the constructed &GAPGraphviz; digraph
#! object has an empty string as a name.
#!
#! The argument <A>name</A> can be any &GAP; object for which there is a
#! <Ref Attr="String" BookName="ref"/> method, and the name of the
#! created object will be equal to <C>String(name)</C>.
#!
#! A "digraph" in &Graphviz; has directed edges that are represented
#! using the string <C>"->"</C> in the &DOT; language.
#!
#! See also:
#! * <Ref Oper="GraphvizGraph" Label="for IsObject"/>
#! * <Ref Oper="GraphvizSetName"
#!    Label="for IsGraphvizGraphDigraphOrContext, IsObject"/>
#! * <Ref Oper="GraphvizName" Label="for IsGraphvizObject"/>
#!
#! @BeginExampleSession
#! gap> gv := GraphvizDigraph("GraphyMcGraphFace");
#! <graphviz digraph "GraphyMcGraphFace" with 0 nodes and 0 edges>
#! gap> GraphvizName(gv);
#! "GraphyMcGraphFace"
#! gap> GraphvizDigraph(666);
#! <graphviz digraph "666" with 0 nodes and 0 edges>
#! gap> gv := GraphvizDigraph();
#! <graphviz digraph with 0 nodes and 0 edges>
#! gap> GraphvizName(gv);
#! ""
#! @EndExampleSession
DeclareOperation("GraphvizDigraph", [IsObject]);
#!
DeclareOperation("GraphvizDigraph", []);
#! @EndGroup

#! @Section Getters for any object
#! This section covers the operations for getting information about
#! &GAPGraphviz; any object.

#! @Arguments obj
#! @Returns a string
#! @Description If the argument <A>obj</A> is a &GAPGraphviz; object
#! (<Ref Filt="IsGraphvizObject" Label="for IsObject"/>), then this
#! function returns the name of the &Graphviz; object <A>obj</A>.
#!
#! @BeginExampleSession
#! gap> dot := GraphvizDigraph("The Round Table");;
#! gap> GraphvizName(dot);
#! "The Round Table"
#! gap> n := GraphvizSetAttr(GraphvizAddNode(dot, "A"), "label", "King Arthur");
#! <graphviz node "A">
#! gap> GraphvizName(n);
#! "A"
#! gap> e := GraphvizAddEdge(dot, "A", "B");;
#! gap> GraphvizName(e);
#! "(A, B)"
#! @EndExampleSession
DeclareOperation("GraphvizName", [IsGraphvizObject]);

#! @Arguments obj
#! @Returns list of attributes
#! @Description Gets the attributes of the provided graphviz object.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizAttrs", [IsGraphvizObject]);

#! @Section Getters for graphs and digraphs

#! @Arguments gv
#! @Returns a record with components the names of nodes, and values the
#! &GraphvizForGAP; node objects themselves.
#! @Description
#! This operation returns a record whose components are the names of the nodes
#! declared within <A>gv</A> but not in its subgraphs or contexts. If
#! <C>name</C> is variable containing the name of a node in <A>gv</A>, then
#! <C>gv.(name)</C> is the actual &GraphvizForGAP; node object with that name
#! belonging to <Ref Filt="IsGraphvizNode" Label="for IsGraphvizNodeOrEdge"/>.
#!
#! See also <Ref Oper="GraphvizNode"
#! Label="for IsGraphvizGraphDigraphOrContext, IsObject"/>
#! for an alternative way of accessing the
#! nodes in &GraphvizForGAP; object, including all subgraphs and contexts.
#! @BeginExampleSession
#! gap> gv := GraphvizDigraph();
#! <graphviz digraph with 0 nodes and 0 edges>
#! gap> context := GraphvizAddContext(gv);
#! <graphviz context "no_name_1" with 0 nodes and 0 edges>
#! gap> GraphvizAddNode(context, "a");
#! <graphviz node "a">
#! gap> GraphvizNodes(gv);  # There are no nodes in gv directly, only in context
#! rec(  )
#! gap> GraphvizNodes(context);
#! rec( a := <graphviz node "a"> )
#! @EndExampleSession
DeclareOperation("GraphvizNodes", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments gv, val
#! @Returns a &GraphvizForGAP; node object or <K>fail</K>.
#! @Description
#! This operation returns the &GraphvizForGAP; node object in the graph,
#! digraph, or context <A>gv</A> whose name is <C>String(<A>val</A>)</C> if any
#! exists, and <K>fail</K> if there is no such node.
#!
#! Unlike <Ref Oper="GraphvizNodes"
#! Label="for IsGraphvizGraphDigraphOrContext"/> this operation will recursively search
#! <A>gv</A> and all of its subgraphs and contexts to try and locate a node
#! named <C>String(<A>val</A>)</C>.
#!
#! @BeginExampleSession
#! gap> gv := GraphvizDigraph();
#! <graphviz digraph with 0 nodes and 0 edges>
#! gap> context := GraphvizAddContext(gv);
#! <graphviz context "no_name_1" with 0 nodes and 0 edges>
#! gap> GraphvizAddNode(context, "a");
#! <graphviz node "a">
#! gap> GraphvizNode(gv, "a");
#! <graphviz node "a">
#! @EndExampleSession
DeclareOperation("GraphvizNode", [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph
#! @Returns the number of nodes in a &GAPGraphviz; object.
#!
#! @Description This operations returns the number of nodes in the
#! &GAPGraphviz; graph, digraph, or context <A>graph</A>.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizNumberOfNodes", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph
#! @Returns a print record of &GAPGraphviz; graphs
#! @Description gets the subgraphs of a provided graphviz graph.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizSubgraphs", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph
#! @Returns a print record of &GAPGraphviz; contexts
#! @Description gets the contexts of a provided graphviz graph, digraph
#! or context.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizContexts", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph, name
#! @Returns a &GAPGraphviz; graph
#! @Description
#! Searches through the tree of subgraphs connected to this subgraph for a graph
#! with the provided name.
#! It returns the graph if it exists.
#! If no such graph exists then it will return <K>fail</K>.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizFindSubgraphRecursive",
[IsGraphvizGraphDigraphOrContext, IsObject]);

#! @BeginGroup
#! @GroupTitle Getting Graphviz Edges
#! @Arguments graph
#! @Returns a list of &GAPGraphviz; edge objects
#! @Description Returns the edges of the provided graphviz graph.
#! If a head and tail are provided it will only return edges
#! between those two nodes.
#! @BeginExampleSession
#! gap> gv := GraphvizGraph();;
#! gap> GraphvizAddEdge(gv, "a", "b");;
#! gap> GraphvizEdges(gv);
#! [ <graphviz edge (a, b)> ]
#! gap> GraphvizEdges(gv, "a", "b");
#! [ <graphviz edge (a, b)> ]
#! @EndExampleSession
DeclareOperation("GraphvizEdges", [IsGraphvizGraphDigraphOrContext]);
#! @Arguments graph, head, tail
DeclareOperation("GraphvizEdges",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);
#! @EndGroup

#! @Arguments edge
#! @Returns a &GAPGraphviz; node object
#! @Description Returns the head of the provided &GAPGraphviz; edge.
#! @BeginExampleSession
#! gap> gv := GraphvizGraph();;
#! gap> e := GraphvizAddEdge(gv, "a", "b");
#! <graphviz edge (a, b)>
#! gap> GraphvizHead(e);
#! <graphviz node "a">
#! @EndExampleSession
DeclareOperation("GraphvizHead", [IsGraphvizEdge]);

#! @Arguments edge
#! @Returns a &GAPGraphviz; node object
#! @Description Returns the tail of the provided &GAPGraphviz; edge.
#! @BeginExampleSession
#! gap> gv := GraphvizGraph();;
#! gap> e := GraphvizAddEdge(gv, "a", "b");
#! <graphviz edge (a, b)>
#! gap> GraphvizTail(e);
#! <graphviz node "b">
#! @EndExampleSession
DeclareOperation("GraphvizTail", [IsGraphvizEdge]);

#! @Section Set Operations
#! This section covers operations for modifying graphviz objects.

#! @Arguments graph, name
#! @Returns a &GAPGraphviz; graph.
#! @Description Sets the name of a graphviz graph or digraph to
#! <A>name</A> and return the <A>graph</A> with the new name.
#!
#! @BeginExampleSession
#! gap> gv := GraphvizGraph();
#! <graphviz graph with 0 nodes and 0 edges>
#! gap> GraphvizSetName(gv, "newname");
#! <graphviz graph "newname" with 0 nodes and 0 edges>
#! @EndExampleSession
DeclareOperation("GraphvizSetName",
                 [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, node
#! @Returns a &GAPGraphviz; node object
#! @Description The operation adds a node to the graph.
#! If a node with the same name is already present the operation fails.
#! What constitute a valid <A>node</A> name is found at
#! https://graphviz.org/doc/info/lang.html
#! @BeginExampleSession
#! gap> gv := GraphvizGraph();
#! <graphviz graph with 0 nodes and 0 edges>
#! gap> GraphvizAddNode(gv, "a");
#! <graphviz node "a">
#! gap> gv;
#! <graphviz graph with 1 node and 0 edges>
#! @EndExampleSession
DeclareOperation("GraphvizAddNode",
                 [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, head, tail
#! @Returns a &GAPGraphviz; edge object
#! @Description The operation adds an edge to the graph.
#! The <K>head</K> and <K>tail</K> can be general objects, strings or graphviz
#! nodes. If the <K>head</K> and <K>tail</K> are general objects, they will be
#! converted to strings. Strings are then interpreted as node IDs. If no nodes
#! with the same id are in the (di)graph, nodes automatically will be added to
#! the graph. If there are nodes with the same id, they will be used.
#!
#! If no nodes with the same name are in the graph then the edge's nodes will be
#! added to the graph. If different nodes with the same name are in the graph
#! then the operation fails.
#! @BeginExampleSession
#! gap> gv := GraphvizGraph();
#! <graphviz graph with 0 nodes and 0 edges>
#! gap> GraphvizAddEdge(gv, "a", "b");
#! <graphviz edge (a, b)>
#! gap> gv;
#! <graphviz graph with 2 nodes and 1 edge>
#! @EndExampleSession
DeclareOperation("GraphvizAddEdge",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @BeginGroup
#! @GroupTitle Adding Subgraphs
#! @Arguments graph, name
#! @Returns a &GAPGraphviz; subgraph object
#! @Description Adds a subgraph to a graph.
#! The type of structure (graph or digraph) will be the same as the parent
#! graph. At the moment it is not possible to add an existing graph as a
#! subgraph of another graph.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizAddSubgraph",
[IsGraphvizGraphDigraphOrContext, IsObject]);
#! @Arguments graph
DeclareOperation("GraphvizAddSubgraph", [IsGraphvizGraphDigraphOrContext]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Adding Contexts
#! @Arguments graph, name
#! @Returns a &GAPGraphviz; context object
#! @Description Adds a context to a graph.
#! A context can be thought as being similar to a subgraph
#! when manipulating it in this package.
#! However, when rendered contexts do not
#! create a <K>subgraph</K> in outputted <K>DOT</K> code.
#! Instead their nodes are rendered inline within the parent graph.
#! This allows for scoping node and edge attributes
#! without modifying the rendering behaviour.
#! The type of graph edge (directed or undirected)
#! will be the same as the parent graph.
#! At the moment it is not possible to add an existing context to
#! a new graph.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizAddContext",
[IsGraphvizGraphDigraphOrContext, IsObject]);
#! @Arguments graph
DeclareOperation("GraphvizAddContext", [IsGraphvizGraphDigraphOrContext]);
#! @EndGroup

DeclareOperation("GraphvizAddComment",
[IsGraphvizGraphDigraphOrContext, IsString]);

#! @Arguments graph, node
#! @Returns a &GAPGraphviz; graph
#! @Description Removes the node from the graph.
#! The <K>node</K> attribute may be an object, string or graphviz node.
#! Objects will be converted to strings.
#! Strings are then interpreted as the id of the node to remove.
#! All edges containing the node are also removed.
#! If no such node exists the operation fails.
#! @BeginExampleSession
#! gap> gv := GraphvizGraph();;
#! gap> GraphvizAddNode(gv, "a");;
#! gap> gv;
#! <graphviz graph with 1 node and 0 edges>
#! gap> GraphvizRemoveNode(gv, "a");
#! <graphviz graph with 0 nodes and 0 edges>
#! @EndExampleSession
DeclareOperation("GraphvizRemoveNode",
[IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, predicate
#! @Returns a &GAPGraphviz; graph
#! @Description Filters the graph's edges using the provided predicate.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizFilterEdges",
[IsGraphvizGraphDigraphOrContext, IsFunction]);

#! @Arguments graph, head_id, tail_id
#! @Returns a &GAPGraphviz; graph
#! @Description Filters the graph's edges, removing edges between nodes with
#! the specified names.
#! If no edges exist between the two nodes, the operation fails.
#! @BeginExampleSession
#! gap> gv := GraphvizGraph();;
#! gap> GraphvizAddEdge(gv, "a", "b");;
#! gap> gv;
#! <graphviz graph with 2 nodes and 1 edge>
#! gap> GraphvizRemoveEdges(gv, "a", "b");
#! <graphviz graph with 2 nodes and 0 edges>
#! @EndExampleSession
DeclareOperation("GraphvizRemoveEdges",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @Subsection Modifying object attributes
#! Operations for modifying attributes.

#! @Arguments gv, attrs
#! @Returns the &GAPGraphviz; object <A>gv</A>.
#! @Description
#! This operation sets the attributes of the &GAPGraphviz; object <A>gv</A> to
#! be the record <A>attrs</A>.  No checks are performed that the components of
#! the record <A>attrs</A> correspond to valid &DOT; attribute names.
#! The existing attributes of <A>gv</A> (if any) are not retained.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizSetAttrs", [IsGraphvizObject, IsRecord]);

#! @Arguments gv, key, val
#! @Returns the &GAPGraphviz; object <A>gv</A>.
#! @Description
#! This operation sets the attribute <A>key</A> of the &GAPGraphviz; object
#! <A>gv</A> to have the value <A>val</A>. If either <A>key</A> or <A>val</A>
#! is not a string, then they are converted to strings using
#! <Ref Attr="String" BookName="ref"/>.
#! No checks are performed that <A>key</A> is a valid attribute nor that
#! <A>val</A> is a valid value for the attribute <A>key</A>.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizSetAttr", [IsGraphvizObject, IsObject, IsObject]);

#! @Arguments gv, obj
#! @Returns the value of an attribute or <K>fail</K>.
#! @Description
#!    This operation returns the current value of the attribute obtained from
#!    <C>String(obj)</C>, or <K>fail</K> if the value of the attribute has not
#!    been set.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizGetAttr", [IsGraphvizObject, IsObject]);

#! @Arguments obj, attr
#! @Returns a &GAPGraphviz; object
#! @Description Removes an attribute from the object provided.
#!   If no attributes are removed then the operation fails.
#!   Attributes may be removed by key or by
#!   key-value pair eg. "label" or "label=\"test\"".
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizRemoveAttr", [IsGraphvizObject, IsObject]);

# TODO add GraphvizRemoveNodeAttrs, GraphvizRemoveEdgeAttrs,
# GraphvizeRemoveAttrs, GraphvizeRemoveGraphAttrs

#! @Section Outputting
#! @Arguments graph
#! @Returns a string
#! @Description The &DOT; source for the <A>graph</A> argument.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("AsString", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments obj
#! @Returns a &GAPGraphviz; object
#! @Description
#!  Unimplemented operation which depending packages can implement.
#!  Should output the graphviz package representation of the object.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("Graphviz", [IsObject]);

#! @Section Shortcuts
#! @Arguments graph, colours
#! @Returns a &GAPGraphviz; object
#! @Description
#!   Sets the colors of the nodes in the (di)graph.
#!   If there are a different number of colours than nodes the operation fails.
#!   Also sets the node <K>style</K> to <K>filled</K>.
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizSetNodeColors",
[IsGraphvizGraphDigraphOrContext, IsList]);

#! @Arguments graph, labels
#! @Returns a &GAPGraphviz; object
#! @Description
#!   Sets the labels of the nodes in the (di)graph.
#!   If there are fewer labels than nodes the operation fails.
#!   If there is an invalid label the operation halts there and fails.
#!   What constitutes a valid label can be found here,
#!   "https://graphviz.org/doc/info/lang.html".
#! @BeginExampleSession
#! @EndExampleSession
DeclareOperation("GraphvizSetNodeLabels",
[IsGraphvizGraphDigraphOrContext, IsList]);

#! @Arguments color
#! @Returns true or false
#! @Description
#!   Determines if the color provided is a valid graphviz color.
#!   Valid graphviz colors are described here,
#!   "http://graphviz.org/doc/info/colors.html".
#! @BeginExampleSession
#! @EndExampleSession
DeclareGlobalFunction("ErrorIfNotValidColor");

########################################################################
# Convenience functions TODO implement
########################################################################

# DeclareOperation("GraphvizSetNodeAttr",
#                  [IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);
# DeclareOperation("GraphvizSetNodeAttrs",
#                  [IsGraphvizGraphDigraphOrContext, IsRecord]);
#
# DeclareOperation("GraphvizNodeAttrs", [IsGraphvizGraphDigraphOrContext]);
#
# DeclareOperation("GraphvizSetEdgeAttr",
#                  [IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);
# DeclareOperation("GraphvizSetEdgeAttrs",
#                  [IsGraphvizGraphDigraphOrContext, IsRecord]);
#
# DeclareOperation("GraphvizEdgeAttrs", [IsGraphvizGraphDigraphOrContext]);
#
# # NOTE: there is no GraphvizGraphAttrs for a context because graph
# # attributes are global
# DeclareOperation("GraphvizGraphAttrs", [IsGraphvizGraph, IsRecord]);
# DeclareOperation("GraphvizGraphAttrs", [IsGraphvizDigraph, IsRecord]);
#
# DeclareOperation("GraphvizSetGraphAttr",
# [IsGraphvizGraph, IsObject, IsObject]);
# DeclareOperation("GraphvizSetGraphAttr",
# [IsGraphvizDigraph, IsObject, IsObject]);
# DeclareOperation("GraphvizSetGraphAttrs", [IsGraphvizGraph, IsRecord]);
# DeclareOperation("GraphvizSetGraphAttrs", [IsGraphvizDigraph, IsRecord]);
#
# DeclareOperation("GraphvizGraphAttrs", [IsGraphvizGraph]);
# DeclareOperation("GraphvizGraphAttrs", [IsGraphvizDigraph]);

#! @Section Debugging
#! @Description
#!   The info class of this package; its info level is 0 by default.
#!   At level 1, <Ref Func="Splash"/> reports the files it writes and the
#!   viewer it uses. At level 2, it reports each program it runs with its
#!   arguments. At level 3, it reports where it found each program, and
#!   <Ref Oper="GraphvizAddEdge"
#!        Label="for IsGraphvizGraphDigraphOrContext, IsObject, IsObject"/>
#!   reports the nodes it adds.
DeclareInfoClass("InfoGraphviz");
