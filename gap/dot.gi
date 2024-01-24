



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

# Graph types
BindGlobal("GV_DIGRAPH", "DIGRAPH");
BindGlobal("GV_GRAPH", "GRAPH");

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
                      rec(Type       := GV_GRAPH, 
                          Name       := name,
                          Nodes      := rec(),
                          Edges      := [],
                          Attrs      := [],
                          NodeAttrs  := [],
                          EdgeAttrs  := []));
end);

InstallMethod(GV_Graph, "for no args", [], {} -> GV_Graph(""));

############################################################
# Stringify
############################################################
InstallMethod(ViewString, "", [IsGVNode], n -> StringFormatted("<node {}>", GV_Name(n)));
InstallMethod(ViewString, "", [IsGVEdge], 
function(e)
  local head, tail;
  head := GV_Head(e);
  tail := GV_Tail(e);
  return StringFormatted("<edge ({}, {})>", GV_Name(head), GV_Name(tail));
end);
InstallMethod(ViewString, "", [IsGVGraph], 
function(g)
  local result, edges, nodes;
  result := "";
  edges := GV_Edges(g);
  nodes := GV_Nodes(g);

  if GV_Type(g) = GV_GRAPH then
    Append(result, StringFormatted("<graph ", GV_Name(g)));
  elif GV_Type(g) = GV_DIGRAPH then
    Append(result, StringFormatted("<digraph ", GV_Name(g))); 
  fi;

  if GV_Name(g) <> "" then
    Append(result, StringFormatted("{} ", GV_Name(g)));
  fi;

  Append(result, StringFormatted("with {} nodes and {} edges>", 
                                  Length(RecNames(nodes)),
                                  Length(edges)));
  return result;
end);

############################################################
# Getters
############################################################
InstallMethod(GV_Name, "for a graphviz object", [IsGVObject], x -> x!.Name);
InstallMethod(GV_Attrs, "for a graphviz object", [IsGVObject], x -> x!.Attrs);

InstallMethod(GV_NodeAttrs, "for a graphviz graph", [IsGVGraph], x -> x!.NodeAttrs);
InstallMethod(GV_EdgeAttrs, "for a graphviz graph", [IsGVGraph], x -> x!.EdgeAttrs);
InstallMethod(GV_Nodes, "for a graphviz graph", [IsGVGraph], x -> x!.Nodes);
InstallMethod(GV_Edges, "for a graphviz graph", [IsGVGraph], x -> x!.Edges);
InstallMethod(GV_Type, "got a graphviz graph", [IsGVGraph], x -> x!.Type);

InstallMethod(GV_Tail, "got a graphviz edge", [IsGVEdge], x -> x!.Tail);
InstallMethod(GV_Head, "got a graphviz edge", [IsGVEdge], x -> x!.Head);

############################################################
# Setters
############################################################
InstallMethod(GV_Name, "for a graphviz object and string",
[IsGVObject, IsString], 
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GV_Type, "for a graphviz object and string",
[IsGVGraph, IsString], 
function(x, type)
  if type <> GV_GRAPH and type <> GV_DIGRAPH then
    Print(StringFormatted("Invalid graph type. Must be {} or {}.",
                          GV_GRAPH, GV_DIGRAPH));
    return fail;
  fi;
  x!.Type := type;
  return x;
end);
