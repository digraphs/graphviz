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

#! @BeginGroup Filters
#! @Description Every object in graphviz belongs to the IsGVObject category.
#! The categories following it are for further specificity on the type of
#! objects. These are graphs, digraphs, nodes and edges respectively.
#! All are direct subcategories of IsGVObject excluding IsGVDigraph which is a
#! subcategory of is GVGraph.

# TODO replace GV -> graphviz
DeclareCategory("IsGVObject", IsObject);
DeclareCategory("IsGVGraphOrDigraph", IsGVObject);
# TODO change to IsGVObject below, since digraphs aren't a special kind of
# graph, unless I'm (JDM) mistaken?
DeclareCategory("IsGVGraph", IsGVGraphOrDigraph);
DeclareCategory("IsGVDigraph", IsGVGraphOrDigraph);
DeclareCategory("IsGVContext", IsGVGraphOrDigraph);
DeclareCategory("IsGVNode", IsGVObject);
DeclareCategory("IsGVEdge", IsGVObject);
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

#! @Arguments obj
#! @Returns the name of the provided graphviz object
#! @Description Gets the name of the provided graphviz object.
DeclareOperation("GraphvizName", [IsGVObject]);

#! @Arguments obj
#! @Returns the attributes of the provided graphviz object
#! @Description Gets the attributes of the provided graphviz object.
DeclareOperation("GraphvizAttrs", [IsGVObject]);

#! @Subsection For only graphs and digraphs.

#! @Arguments graph
#! @Returns the nodes of the provided graphviz graph.
#! @Description Gets the nodes of the provided graphviz graph.
#! Node names can only be [a-zA-Z0-9_£] TODO check exact docs.
DeclareOperation("GraphvizNodes", [IsGVGraphOrDigraph]);
DeclareOperation("GraphvizNode", [IsGVGraphOrDigraph, IsObject]);

#! @Arguments graph
#! @Returns the subgraphs of the provided graphviz graph.
#! @Description gets the subgraphs of a provided graphviz graph.
DeclareOperation("GraphvizSubgraphs", [IsGVGraphOrDigraph]);
DeclareOperation("GraphvizGetSubgraph", [IsGVGraphOrDigraph, IsObject]);

#! @Arguments graph, name
#! @Returns a graph with the provided name.
#! @Description
#! Searches through the tree of subgraphs connected to this subgraph for a graph
#! with the provided name.
#! It returns the graph if it exists.
#! If no such graph exists then it will return fail.
DeclareOperation("GraphvizFindGraph", [IsGVGraphOrDigraph, IsObject]);

#! @Arguments graph
#! @Returns the edges of the provided graphviz graph.
#! @Description Gets the edges of the provided graphviz graph.
DeclareOperation("GraphvizEdges", [IsGVGraphOrDigraph]);
DeclareOperation("GraphvizEdges", [IsGVGraphOrDigraph, IsObject, IsObject]);

#! @Subsection For only edges.

#! @Arguments edge
#! @Returns the head of the provided graphviz edge.
#! @Description Gets the head of the provided graphviz graph.
DeclareOperation("GraphvizHead", [IsGVEdge]);

#! @Arguments edge
#! @Returns the head of the provided graphviz tail.
#! @Description Gets the tail of the provided graphviz graph.
DeclareOperation("GraphvizTail", [IsGVEdge]);

#! @Section Set Operations
#! This section covers operations for modifying graphviz objects.

#! @Subsection For modifying graphs.

#! @Arguments graph, name
#! @Returns the modified graph.
#! @Description Sets the name of a graphviz graph or digraph.
DeclareOperation("GraphvizSetName", [IsGVGraphOrDigraph, IsObject]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Adds a node to the graph.
#! If a node with the same name is already present the operation fails.
DeclareOperation("GraphvizAddNode", [IsGVGraphOrDigraph, IsObject]);

#! @Arguments graph, edge
#! @Returns the modified graph.
#! @Description Adds an edge to the graph.
#! If no nodes with the same name are in the graph then the edge's nodes will be
#! added to the graph. If different nodes with the same name are in the graph
#! then the operation fails.
DeclareOperation("GraphvizAddEdge", [IsGVGraphOrDigraph, IsObject, IsObject]);

#! @Arguments graph, filter, name
#! @Returns the new subgraph.
#! @Description Adds a subgraph to a graph.
DeclareOperation("GraphvizAddSubgraph", [IsGVGraphOrDigraph, IsObject]);
DeclareOperation("GraphvizAddSubgraph", [IsGVGraphOrDigraph]);

#! @Arguments graph, filter, name
#! @Returns the new context.
#! @Description Adds a context to a graph.
DeclareOperation("GraphvizAddContext", [IsGVGraphOrDigraph, IsObject]);
DeclareOperation("GraphvizAddContext", [IsGVGraphOrDigraph]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Removes the node from the graph.
DeclareOperation("GraphvizRemoveNode", [IsGVGraphOrDigraph, IsObject]);

#! @Arguments graph, predicate
#! @Returns the modified graph.
#! @Description Filters the graph's edges using the provided predicate.
DeclareOperation("GraphvizFilterEdges", [IsGVGraphOrDigraph, IsFunction]);

#! @Arguments graph, head_name, tail_name
#! @Returns the modified graph.
#! @Description Filters the graph's edges, removing edges between nodes with
#! the specified names.
DeclareOperation("GraphvizFilterEnds", [IsGVGraphOrDigraph, IsObject, IsObject]);

#! @Subsection For modifying object attributes.

#! @Arguments obj, attrs
#! @Returns the modified object.
#! @Description
#!    Updates the attributes of the object.
#!    All current attributes remain.
#!    If an attribute already exists and a new value is provided, the old value
#!    will be overwritten.
DeclareOperation("GraphvizSetAttrs", [IsGVObject, IsRecord]);
DeclareOperation("GraphvizSetAttr", [IsGVObject, IsObject, IsObject]);
DeclareOperation("GraphvizSetAttr", [IsGVObject, IsObject]);

#! @Arguments obj, attr
#! @Returns the modified object.
#! @Description Removes an attribute from the object provided.
DeclareOperation("GraphvizRemoveAttr", [IsGVObject, IsObject]);

#! @Section Outputting
#! @Arguments graph
#! @Returns the dot representation of the graphviz object.
DeclareOperation("AsString", [IsGVGraphOrDigraph]);

# TODO PrintObj

#! @Arguments obj
#! @Returns the graphviz representation of the object.
#! @Description
#!  Unimplemented operation which depending packages can implement.
#!  Should output the graphviz package representation of the object.
DeclareOperation("Graphviz", [IsObject]);

DeclareOperation("GraphvizSetNodeColors", [IsGVGraphOrDigraph, IsList]);
DeclareOperation("GraphvizSetNodeLabels", [IsGVGraphOrDigraph, IsList]);
