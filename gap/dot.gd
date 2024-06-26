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
#! &DOT; is a language for descrbing to a computer how to display a visualization
#! of a graph or digraph. &Graphviz; is a graph visualization software which can
#! consume &DOT; and produce visual outputs. This package is designed to allow
#! users to programmatically construct objects in &GAP; which can then be
#! converted into &DOT;. That &DOT; can then be input to the &Graphviz; software
#! to produce a visual output. As &DOT; is central to the design of this package
#! it will likely be helpful to have a basic understanding of the language.
#! For more information about &DOT; see
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
#! gap> LoadPackage("graphviz");;
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
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_0", "LR_2"),
#! > "label", "\"SS(B)\"");
#! <graphviz edge (LR_0, LR_2)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_0", "LR_1"),
#! > "label", "\"SS(S)\"");
#! <graphviz edge (LR_0, LR_1)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_1", "LR_3"),
#! > "label", "\"S($end)\"");
#! <graphviz edge (LR_1, LR_3)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_6"),
#! > "label", "\"SS(b)\"");
#! <graphviz edge (LR_2, LR_6)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_5"),
#! > "label", "\"SS(a)\"");
#! <graphviz edge (LR_2, LR_5)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_2", "LR_4"),
#! > "label", "\"S(A)\"");
#! <graphviz edge (LR_2, LR_4)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_5", "LR_7"),
#! > "label", "\"S(b)\"");
#! <graphviz edge (LR_5, LR_7)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_5", "LR_5"),
#! > "label", "\"S(a)\"");
#! <graphviz edge (LR_5, LR_5)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_6", "LR_6"),
#! > "label", "\"S(b)\"");
#! <graphviz edge (LR_6, LR_6)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_6", "LR_5"),
#! > "label", "\"S(a)\"");
#! <graphviz edge (LR_6, LR_5)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_7", "LR_8"),
#! > "label", "\"S(b)\"");
#! <graphviz edge (LR_7, LR_8)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_7", "LR_5"),
#! > "label", "\"S(a)\"");
#! <graphviz edge (LR_7, LR_5)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_8", "LR_6"),
#! > "label", "\"S(b)\"");
#! <graphviz edge (LR_8, LR_6)>
#! gap> GraphvizSetAttr(GraphvizAddEdge(nodes, "LR_8", "LR_5"),
#! > "label", "\"S(a)\"");
#! <graphviz edge (LR_8, LR_5)>
#! gap> Print(AsString(f), "\n");
#! //dot
#! digraph finite_state_machine {
#!     rankdir=LR size="8,5"
#! // terminals context
#!     node [shape=doublecircle]
#!     LR_0
#!     LR_3
#!     LR_4
#!     LR_8
#!     rankdir=LR size="8,5"
#!
#! // nodes context
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
#!         <img height="400" src="png/finite_state_machine.png"/>
#!     </figure>
#!     ]]>
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
DeclareCategory("IsGraphvizGraphDigraphOrContext", IsGraphvizObject);
DeclareCategory("IsGraphvizGraph", IsGraphvizGraphDigraphOrContext);
DeclareCategory("IsGraphvizDigraph", IsGraphvizGraphDigraphOrContext);
DeclareCategory("IsGraphvizContext", IsGraphvizGraphDigraphOrContext);
DeclareCategory("IsGraphvizNodeOrEdge", IsGraphvizObject);
DeclareCategory("IsGraphvizNode", IsGraphvizNodeOrEdge);
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
#! @Returns A new &GAPGraphviz; graph.
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
#! * <Ref Oper="GraphvizDigraph"/>
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
DeclareOperation("GraphvizGraph", []);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Creating a new &GAPGraphviz; digraphs
#! @Arguments name
#! @Returns A new &GAPGraphviz; digraph.
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
#! * <Ref Oper="GraphvizGraph"/>
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
DeclareOperation("GraphvizDigraph", []);
#! @EndGroup

#! @Section Getters for any object
#! This section covers the operations for getting information about
#! &GAPGraphviz; any object.

#! @Arguments obj
#! @Returns A string.
#! @Description If the argument <A>obj</A> is a &GAPGraphviz; object
#! (<Ref Filt="IsGraphvizObject" Label="for IsObject"/>), then this
#! function returns the name of the &Graphviz; object <A>obj</A>.
#!
#! @BeginExampleSession
#! gap> dot := GraphvizDigraph("The Round Table");;
#! gap> GraphvizName(dot);
#! "The Round Table"
#! gap> n := GraphvizSetAttr(GraphvizAddNode(dot, "A"), "label", "King Arthur");
#! gap> GraphvizName(n);
#! "A"
#! gap> e := GraphvizAddEdge(dot, "A", "B");;
#! gap> GraphvizName(e);
#! "(A, B)"
#! @EndExampleSession
DeclareOperation("GraphvizName", [IsGraphvizObject]);

#! @Arguments obj
#! @Returns the attributes of the provided graphviz object
#! @Description Gets the attributes of the provided graphviz object.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
# HERE
DeclareOperation("GraphvizAttrs", [IsGraphvizObject]);

#! @Section Getters for graphs and digraphs

#! @Arguments graph
#! @Returns the nodes of the provided graphviz graph
#! as a mapping from node ids to names.
#! @Description Gets the nodes of the provided graphviz graph.
# From https://graphviz.org/doc/info/lang.html
# An ID is one of the following:
# Any string of alphabetic ([a-zA-Z\200-\377]) characters, underscores ('_') or
# digits([0-9]), not beginning with a digit;
# a numeral [-]?(.[0-9]⁺ | [0-9]⁺(.[0-9]*)? );
# any double-quoted string ("...") possibly containing escaped quotes (\")¹;
# an HTML string (<...>).
# TODO specify
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizNodes", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph
#! @Returns the subgraphs of the provided graphviz graph.
#! @Description gets the subgraphs of a provided graphviz graph.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizSubgraphs", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph
#! @Returns the contexts of the provided graphviz graph, digraph or context.
#! @Description gets the contexts of a provided graphviz graph, digraph
#! or context.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizContexts", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph, name
#! @Returns a graph with the provided name.
#! @Description
#! Searches through the tree of subgraphs connected to this subgraph for a graph
#! with the provided name.
#! It returns the graph if it exists.
#! If no such graph exists then it will return <K>fail</K>.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizFindSubgraphRecursive",
[IsGraphvizGraphDigraphOrContext, IsObject]);

#! @BeginGroup
#! @GroupTitle Getting Graphviz Edges
#! @Arguments graph
#! @Returns the edges of the provided graphviz graph.
#! @Description Gets the edges of the provided graphviz graph.
#! If a head and tail are provided will only return edges
#! between those two nodes.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizEdges", [IsGraphvizGraphDigraphOrContext]);
#! @Arguments graph, head, tail
DeclareOperation("GraphvizEdges",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);
#! @EndGroup

#! @Subsection For only edges.
#! This section contains getters only applicable to graphviz edges.

#! @Arguments edge
#! @Returns the head of the provided graphviz edge.
#! @Description Gets the head of the provided graphviz graph.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizHead", [IsGraphvizEdge]);

#! @Arguments edge
#! @Returns the head of the provided graphviz tail.
#! @Description Gets the tail of the provided graphviz graph.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizTail", [IsGraphvizEdge]);

#! @Section Set Operations
#! This section covers operations for modifying graphviz objects.

#! @Subsection For modifying graphs.
#! Operations below only pertain to graphs, digraphs and contexts.

#! @Arguments graph, name
#! @Returns the modified graph.
#! @Description Sets the name of a graphviz graph or digraph.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizSetName", [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Adds a node to the graph.
#! If a node with the same name is already present the operation fails.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizAddNode", [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, edge
#! @Returns the modified graph.
#! @Description Adds an edge to the graph.
#! If no nodes with the same name are in the graph then the edge's nodes will be
#! added to the graph. If different nodes with the same name are in the graph
#! then the operation fails.
#! TODO I dont believe this is accurate - think it will connect existing ones
#! underlying private function would fail though - TODO double check.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizAddEdge",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @BeginGroup
#! @GroupTitle Adding Subgraphs
#! @Arguments graph, name
#! @Returns the new subgraph.
#! @Description Adds a subgraph to a graph.
#! The type of structure (graph or digraph) will be the same as the parent graph.
#! At the moment it is not possible to add an existing graph as a
#! subgraph of another graph.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizAddSubgraph",
[IsGraphvizGraphDigraphOrContext, IsObject]);
#! @Arguments graph
DeclareOperation("GraphvizAddSubgraph", [IsGraphvizGraphDigraphOrContext]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Adding Contexts
#! @Arguments graph, name
#! @Returns the new context.
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
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizAddContext",
[IsGraphvizGraphDigraphOrContext, IsObject]);
#! @Arguments graph
DeclareOperation("GraphvizAddContext", [IsGraphvizGraphDigraphOrContext]);
#! @EndGroup

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Removes the node from the graph.
#! The <K>node</K> attribute may be an object, string or graphviz node.
#! Objects will be converted to strings.
#! Strings are then interpreted as the id of the node to remove.
#! All edges containing the node are also removed.
#! If no such node exists the operation fails.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizRemoveNode",
[IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, predicate
#! @Returns the modified graph.
#! @Description Filters the graph's edges using the provided predicate.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizFilterEdges",
[IsGraphvizGraphDigraphOrContext, IsFunction]);

#! @Arguments graph, head_id, tail_id
#! @Returns the modified graph.
#! @Description Filters the graph's edges, removing edges between nodes with
#! the specified names.
#! If no edges exist between the two nodes, the operation fails.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizRemoveEdges",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @Subsection Modifying object attributes
#! Operations for modifying attributes.

#! @BeginGroup
#! @GroupTitle Setting Attributes
#! @Arguments obj, attrs
#! @Returns the modified object.
#! @Description
#!    Updates the attributes of the object.
#!    All current attributes remain.
#!    If an attribute already exists and a new value is provided, the old value
#!    will be overwritten.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizSetAttrs", [IsGraphvizObject, IsRecord]);
#! @Arguments obj, name, value
DeclareOperation("GraphvizSetAttr", [IsGraphvizObject, IsObject, IsObject]);
#! @Arguments obj, name
DeclareOperation("GraphvizSetAttr", [IsGraphvizObject, IsObject]);
#! @EndGroup

#! @Arguments obj, attr
#! @Returns the modified object.
#! @Description Removes an attribute from the object provided.
#!   If no attributes are removed then the operation fails.
#!   Attributes may be removed by key or by
#!   key-value pair eg. "label" or "label=\"test\"".
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizRemoveAttr", [IsGraphvizObject, IsObject]);

#! @Section Outputting
#! @Arguments graph
#! @Returns the dot representation of the graphviz object.
#! @Description TODO
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("AsString", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments obj
#! @Returns the graphviz representation of the object.
#! @Description
#!  Unimplemented operation which depending packages can implement.
#!  Should output the graphviz package representation of the object.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("Graphviz", [IsObject]);

#! @Section Shortcuts
#! @Arguments graph, colours
#! @Returns the modified object
#! @Description
#!   Sets the colors of the nodes in the (di)graph.
#!   If there are a different number of colours than nodes the operation fails.
#!   Also sets the node <K>style</K> to <K>filled</K>.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("GraphvizSetNodeColors",
[IsGraphvizGraphDigraphOrContext, IsList]);

#! @Arguments graph, labels
#! @Returns the modified object
#! @Description
#!   Sets the labels of the nodes in the (di)graph.
#!   If there are fewer labels than nodes the operation fails.
#!   If there is an invalid label the operation halts there and fails.
#!   What constitutes a valid label can be found here,
#!   "https://graphviz.org/doc/info/lang.html".
#! @BeginExampleSession
#! gap>
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
#! gap>
#! @EndExampleSession
DeclareGlobalFunction("ErrorIfNotValidColor");

#! @BeginGroup
#! @GroupTitle Getting attributes
#! @Arguments edge, attr
#! @Returns the value associated with the provided attribute.
#! @Description
#!   Gets the value associated with the attribute <K>attr</K>.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("\[\]", [IsGraphvizEdge, IsObject]);
#! @Arguments node, attr
DeclareOperation("\[\]", [IsGraphvizNode, IsObject]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Setting attributes
#! @Arguments node, attr
#! @Description
#!   Sets the value associated with the attribute <K>attr</K>.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("\[\]\:\=", [IsGraphvizNode, IsObject, IsObject]);
#! @Arguments edge, attr
DeclareOperation("\[\]\:\=", [IsGraphvizEdge, IsObject, IsObject]);
#! @EndGroup

#! @Arguments graph, node_name
#! @Returns The associated node or <K>fail</K> if no such node exists.
#! @Description
#!   Gets a node from a (di)graph by id.
#! @BeginExampleSession
#! gap>
#! @EndExampleSession
DeclareOperation("\[\]", [IsGraphvizGraphDigraphOrContext, IsObject]);
