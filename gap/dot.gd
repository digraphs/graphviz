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
#! @ChapterTitle An introduction to the DOT language and Graphviz.
#! This chapter explains what the DOT and graphviz are,
#! key basic concepts relating to them, and how this package interacts with them.

#! @Section A Brief Introduction
#! DOT is a language for descrbing to a computer how to display a visualization
#! for a graph or digraph. Graphviz is a graph visualization software which can
#! consume DOT and produce visual outputs. This package is designed to allow
#! users to programmatically construct objects in GAP which can then be
#! converted into DOT. That DOT can then be inputted into the graphviz software
#! to produce a visual output. As DOT is central to the design of this package
#! it will likely be helpful to have a basic understanding of the language.
#! For more information about DOT see
#! <URL>https://graphviz.org/doc/info/lang.html</URL>.

#! @Chapter
#! @ChapterTitle The Graphviz Package

#! @Section Graphviz Categories
#! @Description Every object in graphviz belongs to this category.
DeclareCategory("IsGraphvizObject", IsObject);

#! @BeginGroup
#! @GroupTitle Graphs, digraphs and contexts
#! @Description These categories are for objects with graph like behaviour eg.
#! they can contain nodes, edges, subgraphs, etc.
DeclareCategory("IsGraphvizGraphDigraphOrContext", IsGraphvizObject);
DeclareCategory("IsGraphvizGraph", IsGraphvizGraphDigraphOrContext);
DeclareCategory("IsGraphvizDigraph", IsGraphvizGraphDigraphOrContext);
DeclareCategory("IsGraphvizContext", IsGraphvizGraphDigraphOrContext);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Nodes and edges
DeclareCategory("IsGraphvizNodeOrEdge", IsGraphvizObject);
DeclareCategory("IsGraphvizNode", IsGraphvizNodeOrEdge);
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
#! This section covers the operations for getting information about any graphviz
#! object.

#! @Arguments obj
#! @Returns the name of the provided graphviz object
#! @Description Gets the name of the provided graphviz object.
DeclareOperation("GraphvizName", [IsGraphvizObject]);

#! @Arguments obj
#! @Returns the attributes of the provided graphviz object
#! @Description Gets the attributes of the provided graphviz object.
DeclareOperation("GraphvizAttrs", [IsGraphvizObject]);

#! @Subsection For only graphs, digraphs and contexts.
#! This section covers the operations for getting information about graphviz
#! graphs, digraphs and contexts.

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
#! Subgraphs are returned as a mapping from subgraph name to object.
DeclareOperation("GraphvizSubgraphs", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph
#! @Returns the contexts of the provided graphviz graph, digraph or context.
#! @Description gets the contexts of a provided graphviz graph, digraph
#! or context.
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
#!  TODO: are we happy with this behaviour?
#! I think if fail if they have the same id but different objects.
DeclareOperation("GraphvizAddEdge",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @BeginGroup
#! @GroupTitle Adding Subgraphs
#! @Arguments graph, name
#! @Returns the new subgraph.
#! @Description Adds a subgraph to a graph.
#! The type of graph (graph or digraph) will be the same as the parent graph.
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
