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
#! to a file (using <Ref Func="FileString" BookName="ref"/>) and render it
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
#! @BeginExampleSession
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
#! "label", "\"S($end)\"");
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
#! @EndExampleSession
#!
#! Provided that you have &Graphviz; installed on your computer, the last line
#! of the example <C>Splash(f)</C> will produce the following picture:
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
#! Blurg

#! @BeginGroup Filters
#! @Description Every object in graphviz belongs to the IsGraphvizObject
#! category. The categories following it are for further specificity on the
#! type of objects. These are graphs, digraphs, nodes and edges respectively.
#! All are direct subcategories of IsGraphvizObject excluding IsGraphvizDigraph
#! which is a subcategory of is IsGraphvizGraph.

#! TODO
DeclareCategory("IsGraphvizObject", IsObject);

#! TODO
DeclareCategory("IsGraphvizGraphDigraphOrContext", IsGraphvizObject);
#! TODO
DeclareCategory("IsGraphvizGraph", IsGraphvizGraphDigraphOrContext);
#! TODO
DeclareCategory("IsGraphvizDigraph", IsGraphvizGraphDigraphOrContext);
#! TODO
DeclareCategory("IsGraphvizContext", IsGraphvizGraphDigraphOrContext);
#! @EndGroup

#! TODO
DeclareCategory("IsGraphvizNodeOrEdge", IsGraphvizObject);
#! TODO
DeclareCategory("IsGraphvizNode", IsGraphvizNodeOrEdge);
#! TODO
DeclareCategory("IsGraphvizEdge", IsGraphvizNodeOrEdge);

#! @EndGroup

#! @Section Constructors

#! @BeginGroup
#! @GroupTitle Constructors for Graphs
#! @Arguments name
#! @Returns a new graphviz graph
#! @Description Creates a new graphviz graph optionally with the provided name.
DeclareOperation("GraphvizGraph", [IsObject]);
DeclareOperation("GraphvizGraph", []);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Constructors for Digraphs
#! @Arguments name
#! @Returns a new graphviz digraph
#! @Description Creates a new graphviz digraph optionally with the provided name.
DeclareOperation("GraphvizDigraph", [IsObject]);
DeclareOperation("GraphvizDigraph", []);
#! @EndGroup

#! @Section Get Operations
#! This section covers the operations for getting information about graphviz
#! objects.

#! @Subsection For all graphviz objects.
#! Operations below are applicable to all graphviz
#! objects.

#! @Arguments obj
#! @Returns the name of the provided graphviz object
#! @Description Gets the name of the provided graphviz object.
DeclareOperation("GraphvizName", [IsGraphvizObject]);

#! @Arguments obj
#! @Returns the attributes of the provided graphviz object
#! @Description Gets the attributes of the provided graphviz object.
DeclareOperation("GraphvizAttrs", [IsGraphvizObject]);

#! @Subsection For only graphs, digraphs and contexts.
#! This section covers the operations for getting information
#! specific to graphviz graphs, digraphs and contexts.

#! @Arguments graph
#! @Returns the nodes of the provided graphviz graph
#! as a mapping from node ids to names.
#! @Description Gets the nodes of the provided graphviz graph.
#! What constitutes a valid node ID
#! is defined here "https://graphviz.org/doc/info/lang.html".
DeclareOperation("GraphvizNodes", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph
#! @Returns the subgraphs of the provided graphviz graph.
#! @Description gets the subgraphs of a provided graphviz graph.
#! Subgraphs are returned as a mapping from subgraph names to
#! corresponding objects.
DeclareOperation("GraphvizSubgraphs", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph
#! @Returns the contexts of the provided graphviz graph, digraph or context.
#! @Description gets the contexts of a provided graphviz graph, digraph
#! or context.
#! Subgraphs are returned as a mapping from context names to
#! corresponding objects.
DeclareOperation("GraphvizContexts", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph, name
#! @Returns a graph with the provided name.
#! @Description
#! Searches through the tree of subgraphs connected to this subgraph for a graph
#! with the provided name.
#! It returns the graph if it exists.
#! If no such graph exists then it will return <K>fail</K>.
DeclareOperation("GraphvizFindSubgraphRecursive",
[IsGraphvizGraphDigraphOrContext, IsObject]);

#! @BeginGroup
#! @GroupTitle Getting Graphviz Edges
#! @Arguments graph
#! @Returns the edges of the provided graphviz graph.
#! @Description
#! Gets the edges of the provided graphviz graph.
#! Returns a list of edge objects.
#! If a head and tail are provided will only return edges
#! between those two nodes.
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
DeclareOperation("GraphvizHead", [IsGraphvizEdge]);

#! @Arguments edge
#! @Returns the head of the provided graphviz tail.
#! @Description Gets the tail of the provided graphviz graph.
DeclareOperation("GraphvizTail", [IsGraphvizEdge]);

#! @Section Set Operations
#! This section covers operations for modifying graphviz objects.

#! @Subsection For modifying graphs.
#! Operations below only pertain to graphs, digraphs and contexts.

#! @Arguments graph, name
#! @Returns the modified graph.
#! @Description Sets the name of a graphviz graph or digraph.
DeclareOperation("GraphvizSetName", [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, id
#! @Returns the new node.
#! @Description Adds a node to the graph with ID <K>id</K>.
#! If the <K>id</K> parameter is not string it will be converted to one.
#! If a node with the same id is already present the operation fails.
#! What constitutes a valid node ID
#! is defined here "https://graphviz.org/doc/info/lang.html".
#! Currently nodes cannot be added directly to graphs, so
#! if id is of type <K>GraphvizNode</K> it will fail.
DeclareOperation("GraphvizAddNode", [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, head, tail
#! @Returns the new edge.
#! @Description adds an edge to the graph.
#! The <K>head</K> and <K>tail</K> can be
#! general objects, strings or graphviz nodes.
#! If the <K>head</K> and <K>tail</K> are general objects, they will
#! be converted to strings.
#! Strings are then interpreted as node IDs.
#! If no nodes with the same id are in the (di)graph, nodes automatically will be
#! added to the graph.
#! If there are nodes with the same id, they will be used.
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
DeclareOperation("GraphvizRemoveNode",
[IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, predicate
#! @Returns the modified graph.
#! @Description Filters the graph's edges using the provided predicate.
DeclareOperation("GraphvizFilterEdges",
[IsGraphvizGraphDigraphOrContext, IsFunction]);

#! @Arguments graph, head_id, tail_id
#! @Returns the modified graph.
#! @Description
#!   Filters the graph's edges, removing edges between nodes with
#!   the specified ids.
#!   If no edges exist between the two nodes, the operation fails.
DeclareOperation("GraphvizRemoveEdges",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @Subsection Modifying object attributes
#! Operations for modifying attributes.

#! @BeginGroup
#! @GroupTitle Setting Attributes
#! @Arguments obj, attrs
#! @Returns the modified object.
#! @Description
#!   Updates the attributes of the object.
#!   All current attributes remain.
#!   If an attribute already exists and a new value is provided, the old value
#!   will be overwritten.
DeclareOperation("GraphvizSetAttrs", [IsGraphvizObject, IsRecord]);
#! @Arguments obj, name, value
DeclareOperation("GraphvizSetAttr", [IsGraphvizObject, IsObject, IsObject]);
#! @Arguments obj, name
DeclareOperation("GraphvizSetAttr", [IsGraphvizObject, IsObject]);
#! @EndGroup

#! @Arguments obj, attr
#! @Returns the modified object.
#! @Description
#!   Removes an attribute from the object provided.
#!   If no attributes are removed then the operation fails.
#!   Attributes may be removed by key or by
#!   key-value pair eg. "label" or "label=\"test\"".
DeclareOperation("GraphvizRemoveAttr", [IsGraphvizObject, IsObject]);

#! @Section Outputting
#! @Arguments graph
#! @Returns the dot representation of the graphviz object.
DeclareOperation("AsString", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments obj
#! @Returns the graphviz representation of the object.
#! @Description
#!   Unimplemented operation which depending packages can implement.
#!   Should output the graphviz package representation of the object.
DeclareOperation("Graphviz", [IsObject]);

#! @Arguments graph, colours
#! @Returns the modified object
#! @Description
#!   Sets the colors of the nodes in the (di)graph.
#!   If there are a different number of colours than nodes the operation fails.
#!   Also sets the node <K>style</K> to <K>filled</K>.
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
DeclareOperation("GraphvizSetNodeLabels",
[IsGraphvizGraphDigraphOrContext, IsList]);

#! @Arguments color
#! @Returns true or false
#! @Description
#!   Determines if the color provided is a valid graphviz color.
#!   Valid graphviz colors are described here,
#!   "http://graphviz.org/doc/info/colors.html".
DeclareGlobalFunction("ErrorIfNotValidColor");

#! @Section Shorthand
#! Shorthand for common operations.

#! @BeginGroup
#! @GroupTitle Getting attributes
#! @Arguments edge, attr
#! @Returns the value associated with the provided attribute.
#! @Description
#!   Gets the value associated with the attribute <K>attr</K>.
DeclareOperation("\[\]", [IsGraphvizEdge, IsObject]);
#! @Arguments node, attr
DeclareOperation("\[\]", [IsGraphvizNode, IsObject]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Setting attributes
#! @Arguments node, attr
#! @Description
#!   Sets the value associated with the attribute <K>attr</K>.
DeclareOperation("\[\]\:\=", [IsGraphvizNode, IsObject, IsObject]);
#! @Arguments edge, attr
DeclareOperation("\[\]\:\=", [IsGraphvizEdge, IsObject, IsObject]);

#! @Arguments graph, node_name
#! @Returns The associated node or <K>fail</K> if no such node exists.
#! @Description
#!   Gets a node from a (di)graph by id.
DeclareOperation("\[\]", [IsGraphvizGraphDigraphOrContext, IsObject]);
