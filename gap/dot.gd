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
#! key basic concepts relating to them, and how this package interacts with
#! them.

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

#! @BeginGroup Filters
#! @Description Every object in graphviz belongs to the IsGraphvizObject
#! category. The categories following it are for further specificity on the
#! type of objects. These are graphs, digraphs, nodes and edges respectively.
#! All are direct subcategories of IsGraphvizObject excluding IsGraphvizDigraph
#! which is a subcategory of is IsGraphvizGraph.

DeclareCategory("IsGraphvizObject", IsObject);

DeclareCategory("IsGraphvizGraphDigraphOrContext", IsGraphvizObject);
DeclareCategory("IsGraphvizGraph", IsGraphvizGraphDigraphOrContext);
DeclareCategory("IsGraphvizDigraph", IsGraphvizGraphDigraphOrContext);
DeclareCategory("IsGraphvizContext", IsGraphvizGraphDigraphOrContext);

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
#! @Description Creates a new graphviz digraph optionally with the provided
#! name.
DeclareOperation("GraphvizDigraph", [IsObject]);
DeclareOperation("GraphvizDigraph", []);
#! @EndGroup

#! @Section Get Operations
#! This section covers the operations for getting information about graphviz
#! objects.

#! @Subsection For all graphviz objects.

#! @Arguments obj
#! @Returns the name of the provided graphviz object
#! @Description Gets the name of the provided graphviz object.
DeclareOperation("GraphvizName", [IsGraphvizObject]);

#! @Arguments obj
#! @Returns the attributes of the provided graphviz object
#! @Description Gets the attributes of the provided graphviz object.
DeclareOperation("GraphvizAttrs", [IsGraphvizObject]);

#! @Subsection For only graphs and digraphs.

#! @Arguments graph
#! @Returns the nodes of the provided graphviz graph.
#! @Description Gets the nodes of the provided graphviz graph.
# From https://graphviz.org/doc/info/lang.html
# An ID is one of the following:
# Any string of alphabetic ([a-zA-Z\200-\377]) characters, underscores ('_') or
# digits([0-9]), not beginning with a digit;
# a numeral [-]?(.[0-9]⁺ | [0-9]⁺(.[0-9]*)? );
# any double-quoted string ("...") possibly containing escaped quotes (\")¹;
# an HTML string (<...>).
# TODO specify
DeclareOperation("GraphvizNodes", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph
#! @Returns the subgraphs of the provided graphviz graph.
#! @Description gets the subgraphs of a provided graphviz graph.
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

#! @Arguments graph
#! @Returns the edges of the provided graphviz graph.
#! @Description Gets the edges of the provided graphviz graph.
DeclareOperation("GraphvizEdges", [IsGraphvizGraphDigraphOrContext]);
DeclareOperation("GraphvizEdges",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @Subsection For only edges.

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
DeclareOperation("GraphvizSetName",
                 [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Adds a node to the graph.
#! If a node with the same name is already present the operation fails.
DeclareOperation("GraphvizAddNode",
                 [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, edge
#! @Returns the modified graph.
#! @Description Adds an edge to the graph.
#! If no nodes with the same name are in the graph then the edge's nodes will be
#! added to the graph. If different nodes with the same name are in the graph
#! then the operation fails.
#! TODO I dont believe this is accurate - think it will connect existing ones
#! underlying private function would fail though - TODO double check.
DeclareOperation("GraphvizAddEdge",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @Arguments graph, filter, name
#! @Returns the new subgraph.
#! @Description Adds a subgraph to a graph.
DeclareOperation("GraphvizAddSubgraph",
[IsGraphvizGraphDigraphOrContext, IsObject]);
DeclareOperation("GraphvizAddSubgraph", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments graph, filter, name
#! @Returns the new context.
#! @Description Adds a context to a graph.
DeclareOperation("GraphvizAddContext",
[IsGraphvizGraphDigraphOrContext, IsObject]);
DeclareOperation("GraphvizAddContext", [IsGraphvizGraphDigraphOrContext]);

DeclareOperation("GraphvizAddComment",
[IsGraphvizGraphDigraphOrContext, IsString]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Removes the node from the graph.
DeclareOperation("GraphvizRemoveNode",
[IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, predicate
#! @Returns the modified graph.
#! @Description Filters the graph's edges using the provided predicate.
DeclareOperation("GraphvizFilterEdges",
[IsGraphvizGraphDigraphOrContext, IsFunction]);

#! @Arguments graph, head_name, tail_name
#! @Returns the modified graph.
#! @Description Filters the graph's edges, removing edges between nodes with
#! the specified names.
DeclareOperation("GraphvizRemoveEdges",
[IsGraphvizGraphDigraphOrContext, IsObject, IsObject]);

#! @Subsection For modifying object attributes.

#! @Arguments obj, attrs
#! @Returns the modified object.
#! @Description
#!    Updates the attributes of the object.
#!    All current attributes remain.
#!    If an attribute already exists and a new value is provided, the old value
#!    will be overwritten.
DeclareOperation("GraphvizSetAttrs", [IsGraphvizObject, IsRecord]);
DeclareOperation("GraphvizSetAttr", [IsGraphvizObject, IsObject, IsObject]);
DeclareOperation("GraphvizSetAttr", [IsGraphvizObject, IsObject]);

#! @Arguments obj, attr
#! @Returns the modified object.
#! @Description Removes an attribute from the object provided.
DeclareOperation("GraphvizRemoveAttr", [IsGraphvizObject, IsObject]);

#! @Section Outputting
#! @Arguments graph
#! @Returns the dot representation of the graphviz object.
DeclareOperation("AsString", [IsGraphvizGraphDigraphOrContext]);

#! @Arguments obj
#! @Returns the graphviz representation of the object.
#! @Description
#!  Unimplemented operation which depending packages can implement.
#!  Should output the graphviz package representation of the object.
DeclareOperation("Graphviz", [IsObject]);

DeclareOperation("GraphvizSetNodeColors",
[IsGraphvizGraphDigraphOrContext, IsList]);
DeclareOperation("GraphvizSetNodeLabels",
[IsGraphvizGraphDigraphOrContext, IsList]);

DeclareGlobalFunction("ErrorIfNotValidColor");

# TODO doc
DeclareOperation("\[\]", [IsGraphvizNode, IsObject]);
# TODO doc
DeclareOperation("\[\]\:\=", [IsGraphvizNode, IsObject, IsObject]);

# TODO doc
DeclareOperation("\[\]", [IsGraphvizEdge, IsObject]);
# TODO doc
DeclareOperation("\[\]\:\=", [IsGraphvizEdge, IsObject, IsObject]);

# TODO doc
DeclareOperation("\[\]", [IsGraphvizGraphDigraphOrContext, IsObject]);
