



###############################################################################
# Private functionality
###############################################################################

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

BindGlobal("GV_Head",
function(x)
  Assert(1, IsGVObject(x));
  return x!.HeadFunc(GV_Name(x));
end);

###############################################################################
# Family + type
###############################################################################

BindGlobal("GV_ObjectFamily",
           NewFamily("GV_ObjectFamily",
                     IsGVObject));

BindGlobal("GV_GraphType", NewType(GV_ObjectFamily,
                                    IsGVGraph and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GV_NodeType", NewType(GV_ObjectFamily,
                                    IsGVNode and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GV_EdgeType", NewType(GV_ObjectFamily,
                                    IsGVEdge and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

###############################################################################
# Constuctors etc
###############################################################################

# Node constructors
InstallMethod(GV_Node, "for a string and a record", [IsString, IsRecord],
function(name, attrs)
  return Objectify(GV_NodeType, 
                  rec(
                    Name  := name,
                    Attrs := attrs                
                  ));
end);
InstallMethod(GV_Node, "for a string", [IsString],
function(name)
  return GV_Node(name, rec());
end);

# Edge constructors
InstallMethod(GV_Edge, "for a node, a node and a record", 
[IsGVNode, IsGVNode, IsRecord],
function(head, tail, attrs)
  return Objectify(GV_EdgeType, 
                rec(
                  Name  := "",
                  Head  := head,
                  Tail  := tail,
                  Attrs := attrs                
                ));
end);
InstallMethod(GV_Edge, "for a node and a node", [IsGVNode, IsGVNode],
function(head, tail)
  return GV_Edge(head, tail, rec());
end);

# Graph constructors
InstallMethod(GV_Graph, "for a string", [IsString],
function(name)
  return Objectify(GV_GraphType,
                      rec(Name       := name,
                          Nodes      := rec(),
                          Edges      := [],
                          Attrs      := [],
                          NodeAttrs  := [],
                          EdgeAttrs  := []));
end);

InstallMethod(GV_Graph, "for no args", [], {} -> GV_Graph(""));

############################################################
# Getters
############################################################
InstallMethod(GV_Name, "for a graphviz object", [IsGVObject], x -> x!.Name);
InstallMethod(GV_Attrs, "for a graphviz object", [IsGVObject], x -> x!.Attrs);

InstallMethod(GV_NodeAttrs, "for a graphviz object", [IsGVGraph], x -> x!.NodeAttrs);
InstallMethod(GV_EdgeAttrs, "for a graphviz object", [IsGVGraph], x -> x!.EdgeAttrs);
InstallMethod(GV_Nodes, "for a graphviz object", [IsGVGraph], x -> x!.Nodes);
InstallMethod(GV_Edges, "for a graphviz object", [IsGVGraph], x -> x!.Edges);

