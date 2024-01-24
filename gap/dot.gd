
# Categories
DeclareCategory("IsGVObject", IsObject);
DeclareCategory("IsGVGraph", IsGVObject);
DeclareCategory("IsGVNode", IsGVObject);
DeclareCategory("IsGVEdge", IsGVObject);

# Constuctors
DeclareOperation("GV_Node", [IsString, IsRecord]);
DeclareOperation("GV_Node", [IsString]);

DeclareOperation("GV_Edge", [IsGVNode, IsGVNode, IsRecord]);
DeclareOperation("GV_Edge", [IsGVNode, IsGVNode]);

DeclareOperation("GV_Graph", [IsString]);
DeclareOperation("GV_Graph", []);

# Getters
DeclareOperation("GV_Name", [IsGVObject]);
DeclareOperation("GV_Attrs", [IsGVObject]);
DeclareOperation("GV_NodeAttrs", [IsGVObject]);
DeclareOperation("GV_EdgeAttrs", [IsGVObject]);
DeclareOperation("GV_Nodes", [IsGVObject]);
DeclareOperation("GV_Edges", [IsGVObject]);
DeclareOperation("GV_Head", [IsGVEdge]);
DeclareOperation("GV_Tail", [IsGVEdge]);
DeclareOperation("GV_Type", [IsGVGraph]);


DeclareOperation("GV_HasNode",[IsGVGraph, IsString]);

# Setters
DeclareOperation("GV_Name",[IsGVObject, IsString]);
DeclareOperation("GV_Type",[IsGVGraph, IsString]);

DeclareOperation("GV_Attrs", [IsGVObject, IsRecord]);
DeclareOperation("GV_NodeAttrs", [IsGVObject, IsRecord]);
DeclareOperation("GV_EdgeAttrs", [IsGVObject, IsRecord]);

DeclareOperation("GV_AddNode", [IsGVGraph, IsGVNode]);
DeclareOperation("GV_AddEdge", [IsGVGraph, IsGVEdge]);

DeclareOperation("GV_RemoveNode", [IsGVGraph, IsGVNode]);
DeclareOperation("GV_FilterEdges", [IsGVGraph, IsFunction]);
DeclareOperation("GV_FilterEnds", [IsGVGraph, IsString, IsString]);
