#! @Chapter
#! @ChapterTitle Creating graphviz objects
#! In this chapter we will cover the constructors and categories for graphviz objects.

#! @Section Creating graphviz objects

#! @BeginGroup Filters
#! @Description Every object in graphviz belongs to the IsGVObject category. 
#! The categories following it are for further specificity on the type of objects.
#! These are graphs, nodes and edges respectively.
DeclareCategory("IsGVObject", IsObject); 
DeclareCategory("IsGVGraph", IsGVObject);
DeclareCategory("IsGVDigraph", IsGVGraph);
DeclareCategory("IsGVNode", IsGVObject);
DeclareCategory("IsGVEdge", IsGVObject);
#! @EndGroup


#! @BeginGroup
#! @GroupTitle Constructors for Nodes
#! @Arguments name, attrs
#! @Returns a new graphviz node 
#! @Description 
#! Creates a new graphviz node with the provided name and optionally attritbutes. 
DeclareOperation("GV_Node", [IsString]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Constructors for Edges
#! @Arguments head, tail, attrs
#! @Returns a new graphviz edge
#! @Description 
#! Creates a new graphviz edge between the provided nodes with optionally provided attribtues. 
DeclareOperation("GV_Edge", [IsGVNode, IsGVNode]);
#! @EndGroup


#! @BeginGroup
#! @GroupTitle Constructors for Graphs
#! @Arguments name
#! @Returns a new graphviz graph
#! @Description Creates a new graphviz graph optionally with the provided name.
#! The graph by default is not a digraph.
DeclareOperation("GV_Graph", [IsString]);
DeclareOperation("GV_Graph", []);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Constructors for Digraphs
#! @Arguments name
#! @Returns a new graphviz digraph
#! @Description Creates a new graphviz digraph optionally with the provided name.
#! The graph by default is not a digraph.
DeclareOperation("GV_Digraph", [IsString]);
DeclareOperation("GV_Digraph", []);
#! @EndGroup

#! @Section Get Operations
#! This section covers the operations for getting information about graphviz objects.

#! @Arguments obj
#! @Returns the name of the provided graphviz object
#! @Description Gets the name of the provided graphviz object.
DeclareOperation("GV_Name", [IsGVObject]);

#! @Arguments obj
#! @Returns the attributes of the provided graphviz object
#! @Description Gets the attributes of the provided graphviz object.
DeclareOperation("GV_Attrs", [IsGVObject]);

#! @Arguments graph
#! @Returns the nodes of the provided graphviz graph.
#! @Description Gets the nodes of the provided graphviz graph.
DeclareOperation("GV_Nodes", [IsGVGraph]);

#! @Arguments graph
#! @Returns the edges of the provided graphviz graph.
#! @Description Gets the edges of the provided graphviz graph.
DeclareOperation("GV_Edges", [IsGVGraph]);

#! @Arguments edge
#! @Returns the head of the provided graphviz edge.
#! @Description Gets the head of the provided graphviz graph.
DeclareOperation("GV_Head", [IsGVEdge]);

#! @Arguments edge
#! @Returns the head of the provided graphviz tail.
#! @Description Gets the tail of the provided graphviz graph.
DeclareOperation("GV_Tail", [IsGVEdge]);

#! @Arguments graph, node_name
#! @Returns whether the graphviz graph contains a node with the provided name.
#! @Description Whether the graphviz graph contains a node with the provided name.
DeclareOperation("GV_HasNode",[IsGVGraph, IsString]);


#! @Section Set Operations
#! This section covers operations for modifying graphviz objects.

#! @Arguments graph, name
#! @Returns the modified object.
#! @Description Sets the name of a graphviz graph.
DeclareOperation("GV_SetName",[IsGVGraph, IsString]);

#! @Arguments obj, attrs
#! @Returns the modified object.
#! @Description 
#!    Updates the attribtues of the object.
#!    All current attributes remain.
#!    If an attribute already exists and a new value is provided, the old value will be overwritten.
DeclareOperation("GV_SetAttrs", [IsGVObject, IsRecord]);
DeclareOperation("GV_SetAttr", [IsGVObject, IsObject, IsObject]);
DeclareOperation("GV_SetAttr", [IsGVObject, IsObject]);

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

