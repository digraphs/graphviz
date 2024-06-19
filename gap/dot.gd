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

#! @BeginGroup
#! @GroupTitle Filters
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

#! @Subsection For only graphs and digraphs.
#! This section covers the operations for getting information about graphviz
#! objects.

#! @Arguments graph
#! @Returns the nodes of the provided graphviz graph.
#! @Description Gets the nodes of the provided graphviz graph.
#! From https://graphviz.org/doc/info/lang.html
#! An ID is one of the following:
#! Any string of alphabetic ([a-zA-Z\200-\377]) characters, underscores ('_') or
#! digits([0-9]), not beginning with a digit;
#! a numeral [-]?(.[0-9]⁺ | [0-9]⁺(.[0-9]*)? );
#! any double-quoted string ("...") possibly containing escaped quotes (\")¹;
#! an HTML string (&lt;...&gt;).
#! TODO specify
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

#! @BeginGroup
#! @GroupTitle Getting Graphviz Edges
#! @Arguments graph
#! @Returns the edges of the provided graphviz graph.
#! @Description Gets the edges of the provided graphviz graph.
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
DeclareOperation("GraphvizSetName",
                 [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, node
#! @Returns the modified node.
#! @Description Adds a node to the graph.
#! If a node with the same name is already present the operation fails.
DeclareOperation("GraphvizAddNode",
                 [IsGraphvizGraphDigraphOrContext, IsObject]);

#! @Arguments graph, head, tail
#! @Returns the new edge.
#! @Description adds an edge to the graph.
#! The <K>head</K> and <K>tail</K> can be objects, strings or graphviz nodes.
#! If the <K>head</K> and <K>tail</K> they will be converted to strings.
#! If strings are then interpreted as the names nodes.
#! If no nodes with the same name are in the graph, nodes automatically will be
#! added to the graph.
#! If there are nodes with the same name, they will be used.
#! However, if such nodes exist but are not the same objects as the provided
#! If different nodes with the same name are in the graph
#! <K>head</K> and <K>tail</K>, then the operation will fail.
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

DeclareOperation("GraphvizAddComment",
[IsGraphvizGraphDigraphOrContext, IsString]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Removes the node from the graph.
#! The <K>node</K> attribute may be an object, string or graphviz node.
#! Objects will be converted to strings.
#! Strings are then interpreted as the name of the node to remove.
#! All edges containing the node are also removed.
#! If no such node exists the operation fails.
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
