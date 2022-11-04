
# Categories
DeclareCategory("IsGVObject", IsObject);

DeclareCategory("IsGVGraph", IsGVObject);
DeclareCategory("IsGVDigraph", IsGVObject);

# Constuctors
DeclareOperation("GV_Graph", [IsRecord]);
DeclareOperation("GV_Graph", []);
DeclareOperation("GV_Digraph", [IsRecord]);
DeclareOperation("GV_Digraph", []);

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
DeclareOperation("GV_Name",
                 [IsGVObject, IsString]);
DeclareOperation("GV_GraphAttr",
                 [IsGVObject, IsRecord, IsPosInt]);
DeclareOperation("GV_GraphAttr",
                 [IsGVObject, IsRecord]);
DeclareOperation("GV_NodeAttr",
                 [IsGVObject, IsRecord, IsPosInt]);
DeclareOperation("GV_NodeAttr",
                 [IsGVObject, IsRecord]);
DeclareOperation("GV_EdgeAttr",
                 [IsGVObject, IsRecord, IsPosInt]);
DeclareOperation("GV_EdgeAttr",
                 [IsGVObject, IsRecord]);
DeclareOperation("GV_Node",
                 [IsGVObject, IsString, IsString, IsRecord, IsPosInt]);
DeclareOperation("GV_Node",
                 [IsGVObject, IsString, IsString, IsRecord]);
DeclareOperation("GV_Node",
                 [IsGVObject, IsString, IsRecord, IsPosInt]);
DeclareOperation("GV_Node",
                 [IsGVObject, IsString, IsRecord]);
DeclareOperation("GV_Node",
                 [IsGVObject, IsString, IsString, IsPosInt]);
DeclareOperation("GV_Node",
                 [IsGVObject, IsString, IsString]);
DeclareOperation("GV_Node",
                 [IsGVObject, IsString, IsPosInt]);
DeclareOperation("GV_Node",
                 [IsGVObject, IsString]);
DeclareOperation("GV_Edge",
                 [IsGVObject, IsString, IsString, IsRecord, IsPosInt]);
DeclareOperation("GV_Edge",
                 [IsGVObject, IsString, IsString, IsRecord]);
DeclareOperation("GV_Edge",
                 [IsGVObject, IsString, IsString, IsPosInt]);
DeclareOperation("GV_Edge",
                 [IsGVObject, IsString, IsString]);
DeclareOperation("GV_Comment",
                 [IsGVObject, IsString, IsPosInt]);
DeclareOperation("GV_Comment",
                 [IsGVObject, IsString]);
DeclareOperation("GV_Remove",
                 [IsGVObject, IsPosInt]);

# Output
DeclareOperation("GV_String", [IsGVObject]);
