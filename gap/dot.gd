#! @Chapter
#! @ChapterTitle An introduction to the DOT language and Graphviz.
#! This chapter explains what the DOT and graphviz are, key basic concepts relating to them, and how this package interacts with them.

#! @Section A Brief Introduction
#! DOT is a language for descrbing to a computer how to display a visualization for a graph or digraph.
#! Graphviz is a graph vizualization software which can consume DOT and produce vizual outputs.
#! This package is designed to allow users to programmatically construct objects in GAP which can then be converted into DOT.
#! That DOT can then be inputted into the graphviz software to produce a visual output.
#! As DOT is central to the design of this package it will likely be helpful to have a basic understanding of the language.

#! @Section Basic concepts of DOT
#! This is a breif overview, for further concepts see Graphviz's website here (https://graphviz.org/about/).
#! DOT language programmes are primarily composed of nodes, edges, graphs, subgraphs and attribtues.


#! @Chapter
#! @ChapterTitle Creating graphviz objects
#! In this chapter we will cover the constructors and categories for graphviz objects.

#! @Section Graphviz Categories

#! @BeginGroup Filters
#! @Description Every object in graphviz belongs to the IsGVObject category. 
#! The categories following it are for further specificity on the type of objects.
#! These are graphs, digraphs, nodes and edges respectively.
#! All are direct subcategories of IsGVObject excluding IsGVDigraph which is a subcategory of is GVGraph. 
DeclareCategory("IsGVObject", IsObject); 
DeclareCategory("IsGVGraph", IsGVObject);
DeclareCategory("IsGVDigraph", IsGVGraph);
DeclareCategory("IsGVNode", IsGVObject);
DeclareCategory("IsGVEdge", IsGVObject);
#! @EndGroup

#! @Section Constructors

#! @BeginGroup
#! @GroupTitle Constructors for Nodes
#! @Arguments name
#! @Returns a new graphviz node 
#! @Description 
#! Creates a new graphviz node with the provided name. 
DeclareOperation("GV_Node", [IsString]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Constructors for Edges
#! @Arguments head, tail
#! @Returns a new graphviz edge
#! @Description 
#! Creates a new graphviz edge between the provided nodes. 
DeclareOperation("GV_Edge", [IsGVNode, IsGVNode]);
#! @EndGroup


#! @BeginGroup
#! @GroupTitle Constructors for Graphs
#! @Arguments name
#! @Returns a new graphviz graph
#! @Description Creates a new graphviz graph optionally with the provided name.
DeclareOperation("GV_Graph", [IsString]);
DeclareOperation("GV_Graph", []);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Constructors for Digraphs
#! @Arguments name
#! @Returns a new graphviz digraph
#! @Description Creates a new graphviz digraph optionally with the provided name.
DeclareOperation("GV_Digraph", [IsString]);
DeclareOperation("GV_Digraph", []);
#! @EndGroup

#! @Section Get Operations
#! This section covers the operations for getting information about graphviz objects.

#! @Arguments obj
#! @Returns the name of the provided graphviz object
#! @Description Gets the name of the provided graphviz object.
DeclareOperation("GV_Name", [IsGVObject]);


#! @Subsection For all graphviz objects.

#! @Arguments obj
#! @Returns the attributes of the provided graphviz object
#! @Description Gets the attributes of the provided graphviz object.
DeclareOperation("GV_Attrs", [IsGVObject]);

#! @Subsection For only graphs and digraphs.

#! @Arguments graph
#! @Returns the nodes of the provided graphviz graph.
#! @Description Gets the nodes of the provided graphviz graph.
DeclareOperation("GV_Nodes", [IsGVGraph]);

#! @Arguments graph
#! @Returns the edges of the provided graphviz graph.
#! @Description Gets the edges of the provided graphviz graph.
DeclareOperation("GV_Edges", [IsGVGraph]);

#! @Arguments graph, node_name
#! @Returns whether the graphviz graph contains a node with the provided name.
#! @Description Whether the graphviz graph contains a node with the provided name.
DeclareOperation("GV_HasNode",[IsGVGraph, IsString]);

#! @Subsection For only edges.

#! @Arguments edge
#! @Returns the head of the provided graphviz edge.
#! @Description Gets the head of the provided graphviz graph.
DeclareOperation("GV_Head", [IsGVEdge]);

#! @Arguments edge
#! @Returns the head of the provided graphviz tail.
#! @Description Gets the tail of the provided graphviz graph.
DeclareOperation("GV_Tail", [IsGVEdge]);

#! @Section Set Operations
#! This section covers operations for modifying graphviz objects.

#! @Subsection For modifying graphs.

#! @Arguments graph, name
#! @Returns the modified object.
#! @Description Sets the name of a graphviz graph.
DeclareOperation("GV_SetName",[IsGVGraph, IsString]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Adds a node to the graph.
#! If a node with the same name is already present the operation fails.
DeclareOperation("GV_AddNode", [IsGVGraph, IsGVNode]);

#! @Arguments graph, edge
#! @Returns the modified graph.
#! @Description Adds an edge to the graph.
#! If no nodes with the same name are in the graph then the edge's nodes will be added to the graph.
#! If different nodes with the same name are in the graph then the operation fails.
DeclareOperation("GV_AddEdge", [IsGVGraph, IsGVEdge]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Removes the node from the graph.
DeclareOperation("GV_RemoveNode", [IsGVGraph, IsGVNode]);

#! @Arguments graph, predicate
#! @Returns the modified graph.
#! @Description Filters the graph's edges using the provided predicate.
DeclareOperation("GV_FilterEdges", [IsGVGraph, IsFunction]);

#! @Arguments graph, head_name, tail_name
#! @Returns the modified graph.
#! @Description Filters the graph's edges, removing edges between nodes with the specified names.
DeclareOperation("GV_FilterEnds", [IsGVGraph, IsString, IsString]);

#! @Subsection For modifying object attributes.

#! @Arguments obj, attrs
#! @Returns the modified object.
#! @Description 
#!    Updates the attribtues of the object.
#!    All current attributes remain.
#!    If an attribute already exists and a new value is provided, the old value will be overwritten.
DeclareOperation("GV_SetAttrs", [IsGVObject, IsRecord]);
DeclareOperation("GV_SetAttr", [IsGVObject, IsObject, IsObject]);
DeclareOperation("GV_SetAttr", [IsGVObject, IsObject]);

#! @Arguments obj, attr
#! @Returns the modified object.
#! @Description Removes an attribute from the object provided.
DeclareOperation("GV_RemoveAttr", [IsGVObject, IsObject]);

#! @Section Outputting
#! @Arguments graph
#! @Returns the dot representation of the graphviz object.
DeclareOperation("GV_String", [IsGVGraph]);

# Graph types
BindGlobal("GV_DIGRAPH", "DIGRAPH");
BindGlobal("GV_GRAPH", "GRAPH");

