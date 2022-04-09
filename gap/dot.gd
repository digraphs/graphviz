DeclareCategory("IsGVObject", IsObject);
DeclareCategory("IsGVGraph", IsGVObject);
DeclareCategory("IsGVDigraph", IsGVObject);

DeclareOperation("GV_Graph", []);
DeclareOperation("GV_Graph", [IsRecord]);
DeclareOperation("GV_Digraph", [IsString]);

# Getters
DeclareOperation("GV_Name", [IsGVObject]);
DeclareOperation("GV_GraphAttrs", [IsGVObject]);
DeclareOperation("GV_NodeAttrs", [IsGVObject]);
DeclareOperation("GV_EdgeAttrs", [IsGVObject]);
DeclareOperation("GV_Nodes", [IsGVObject]);
DeclareOperation("GV_Edges", [IsGVObject]);
DeclareOperation("GV_Comments", [IsGVObject]);
DeclareOperation("GV_Lines", [IsGVObject]);

# Setters
DeclareOperation("GV_Name", [IsGVObject, IsString]);
DeclareOperation("GV_GraphAttr", [IsGVObject, IsRecord, IsPosInt]);
DeclareOperation("GV_GraphAttr", [IsGVObject, IsRecord]);
DeclareOperation("GV_NodeAttr", [IsGVObject, IsRecord]);
DeclareOperation("GV_EdgeAttr", [IsGVObject, IsRecord]);
DeclareOperation("GV_Node", [IsGVObject, IsString, IsRecord]);
DeclareOperation("GV_Node", [IsGVObject, IsString, IsString, IsRecord]);
DeclareOperation("GV_Node", [IsGVObject, IsString, IsString]);
DeclareOperation("GV_Node", [IsGVObject, IsString]);
DeclareOperation("GV_Edge", [IsGVObject, IsString, IsString, IsRecord]);
DeclareOperation("GV_Edge", [IsGVObject, IsString, IsString]);
DeclareOperation("GV_Comment", [IsGVObject, IsString, IsPosInt]);
DeclareOperation("GV_Comment", [IsGVObject, IsString]);
DeclareOperation("GV_Remove", [IsGVObject, IsPosInt]);

DeclareOperation("GV_StringifyComment", [IsString]);
DeclareOperation("GV_StringifyGraphHead", [IsString]);
DeclareOperation("GV_StringifyDigraphHead", [IsString]);
DeclareOperation("GV_StringifyGraphEdge", [IsString, IsString, IsRecord]);
DeclareOperation("GV_StringifyDigraphEdge", [IsString, IsString, IsRecord]);
DeclareOperation("GV_StringifySubgraph", [IsString]);
DeclareOperation("GV_StringifyPlainSubgraph", [IsString]);
DeclareOperation("GV_StringifyNode", [IsString, IsRecord]);
DeclareOperation("GV_StringifyGraphAttrs", [IsRecord]);
DeclareOperation("GV_StringifyNodeEdgeAttrs", [IsRecord]);

DeclareOperation("GV_String", [IsGVObject]);

# Private
DeclareOperation("GV_Head", [IsGVObject]);
DeclareOperation("GV_EdgeFunc", [IsGVObject]);
