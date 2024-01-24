



###############################################################################
# Private functionality
###############################################################################

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
                          Attrs      := rec(),
                          NodeAttrs  := rec(),
                          EdgeAttrs  := rec()));
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
  edges := Length(GV_Edges(g));
  nodes := Length(RecNames(GV_Nodes(g)));

  if GV_Type(g) = GV_GRAPH then
    Append(result, StringFormatted("<graph ", GV_Name(g)));
  elif GV_Type(g) = GV_DIGRAPH then
    Append(result, StringFormatted("<digraph ", GV_Name(g))); 
  fi;

  if GV_Name(g) <> "" then
    Append(result, StringFormatted("{} ", GV_Name(g)));
  fi;

  if nodes = 1 then
    Append(result, "with 1 node ");
  else
    Append(result, StringFormatted("with {} nodes ", nodes));
  fi;

  if edges = 1 then
    Append(result, "and 1 edge>");
  else
    Append(result, StringFormatted("and {} edges>", edges));
  fi;
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
InstallMethod(GV_Type, "for a graphviz graph", [IsGVGraph], x -> x!.Type);

InstallMethod(GV_Tail, "for a graphviz edge", [IsGVEdge], x -> x!.Tail);
InstallMethod(GV_Head, "for a graphviz edge", [IsGVEdge], x -> x!.Head);

InstallMethod(GV_HasNode, "for a graphviz graph", [IsGVGraph, IsString], 
function(g, name)
  return IsBound(GV_Nodes(g).(name));
end);

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

InstallMethod(GV_Attrs, "for a graphviz object and record",
[IsGVObject, IsRecord], 
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GV_Attrs(x).(name) := attrs.(name);
  od;
  return x;
end);

InstallMethod(GV_NodeAttrs, "for a graphviz graph and record",
[IsGVGraph, IsRecord], 
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GV_NodeAttrs(x).(name) := attrs.(name);
  od;
  return x;
end);

InstallMethod(GV_EdgeAttrs, "for a graphviz graph and record",
[IsGVGraph, IsRecord], 
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GV_EdgeAttrs(x).(name) := attrs.(name);
  od;
  return x;
end);

InstallMethod(GV_AddNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode], 
function(x, node)
  local name, nodes;
  name := GV_Name(node);
  nodes := GV_Nodes(x);

  # dont add if already node with the same name
  if IsBound(nodes.(name)) then
    Print(StringFormatted("FAIL: Already node with name {}.\n", name));
    return fail;
  fi;

  nodes.(name) := node;
  return x;
end);

InstallMethod(GV_AddEdge, "for a graphviz graph and edge",
[IsGVGraph, IsGVEdge], 
function(x, edge)
  local help;
  help := function(node) 
    if not GV_HasNode(x, GV_Name(node)) then
      GV_AddNode(x, node);
    fi;
  end;

  help(GV_Head(edge));
  help(GV_Tail(edge));
  InsertElmList(x!.Edges, 1, edge);
  return x;
end);

InstallMethod(GV_RemoveNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode],
function(g, n)
  local nodes, name, out;
  nodes := GV_Nodes(g);
  name := GV_Name(n);
  Unbind(nodes.(name));

  GV_FilterEdges(g, 
    function(e)
      local head, tail;
      head := GV_Head(e);
      tail := GV_Tail(e);
      return name <> GV_Name(tail) and name <> GV_Name(head); 
    end);

  return g;
end); 

InstallMethod(GV_FilterEdges, "for a graphviz graph and edge filter",
[IsGVGraph, IsFunction],
function(g, filter)
  g!.Edges := Filtered(GV_Edges(g), filter);
  return g;
end);

InstallMethod(GV_FilterEnds, "for a graphviz graph and two strings",
[IsGVGraph, IsString, IsString],
function(g, hn, tn)
  g!.Edges := Filtered(GV_Edges(g), 
    function(e)
      local head, tail;
      head := GV_Head(e);
      tail := GV_Tail(e);
      return tn <> GV_Name(tail) or hn <> GV_Name(head); 
    end);
  return g;
end);

InstallMethod(GV_FilterEnds, "for a graphviz graph and two strings",
[IsGVGraph, IsString, IsString],
function(g, hn, tn)
  g!.Edges := Filtered(GV_Edges(g), 
    function(e)
      local head, tail;
      head := GV_Head(e);
      tail := GV_Tail(e);
      return tn <> GV_Name(tail) or hn <> GV_Name(head); 
    end);
  return g;
end);

###############################################################################
# Stringifying
###############################################################################

#@ Return comment header line.
InstallMethod(GV_StringifyComment, "for a string", [IsString],
function(line)
  return StringFormatted("//{}\n", line);
end);

#@ Return DOT subgraph start line.
InstallMethod(GV_StringifySubgraphBegin, "for a string", [IsString],
function(name)
  return StringFormatted("\tsubgraph {} {{\n", name);
end);

#@ Return DOT subgraph end line.
InstallMethod(GV_StringifySubgraphEnd, "for a string", [],
function()
  return StringFormatted("\t}}\n");
end);


#@ Return DOT graph head line.
InstallMethod(GV_StringifyGraphHead, "for a string", [IsString],
function(name)
  return StringFormatted("graph {} {{\n", name);
end);

#@ Return DOT digraph head line.
InstallMethod(GV_StringifyDigraphHead, "for a string", [IsString],
function(name)
  return StringFormatted("digraph {} {{\n", name);
end);

#@ Return DOT node statement line.
InstallMethod(GV_StringifyNode, "for string and record",
[IsString, IsRecord],
function(name, attrs)
  return StringFormatted("\t{}{}\n", name, GV_StringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT graph edge statement line.
InstallMethod(GV_StringifyGraphEdge, "for string, string, record",
[IsString, IsString, IsRecord],
function(tail, head, attrs)
  return StringFormatted("\t{} -- {}{}\n",
                         tail,
                         head,
                         GV_StringifyNodeEdgeAttrs(attrs));

end);

#@ Return DOT digraph edge statement line.
InstallMethod(GV_StringifyDigraphEdge, "for string, string, record",
[IsString, IsString, IsRecord],
function(tail, head, attrs)
  return StringFormatted("\t{} -> {}{}\n",
                         tail,
                         head,
                         GV_StringifyNodeEdgeAttrs(attrs));

end);

#@ Return DOT subgraph head line.
InstallMethod(GV_StringifySubgraph, "for a string",
[IsString],
function(name)
  return StringFormatted("subgraph {}{{\n", name);
end);

#@ Return plain DOT subgraph head line.
InstallMethod(GV_StringifyPlainSubgraph, "for a string",
[IsString],
function(name)
  return StringFormatted("{}{{\n", name);
end);

InstallMethod(GV_StringifyGraphAttrs, "for a record", [IsRecord],
function(attrs)
  local result, attr_names, n, i;
  result := "";
  attr_names := NamesOfComponents(attrs);
  n := Length(attr_names);
  if n <> 0 then
    Append(result, "\t");
    for i in [1 .. n] do
      Append(result,
             StringFormatted("{}=\"{}\" ",
                             attr_names[i],
                             attrs.(attr_names[i])));
    od;
    Append(result, "\n");
  fi;
  return result;
end);

InstallMethod(GV_StringifyNodeEdgeAttrs, "for a record", [IsRecord],
function(attrs)
  local result, attr_names, n, i;

  result := "";
  attr_names := NamesOfComponents(attrs);
  n := Length(attr_names);
  if n <> 0 then
    Append(result, " [");
    for i in [1 .. n - 1] do
      if attr_names[i] = "label" then
        Append(result,
               StringFormatted("{}=\"{}\", ",
                               attr_names[i],
                               attrs.(attr_names[i])));
      else
        Append(result,
               StringFormatted("{}={}, ",
                               attr_names[i],
                               attrs.(attr_names[i])));
      fi;
    od;
    if attr_names[n] = "label" then
      Append(result,
             StringFormatted("{}=\"{}\"]",
                             attr_names[n],
                             attrs.(attr_names[n])));
    else
      Append(result,
             StringFormatted("{}={}]",
                             attr_names[n],
                             attrs.(attr_names[n])));
    fi;
  fi;
  return result;
end);

DeclareOperation("GV_ValidateSubgraphs", [IsGVObject]);
InstallMethod(GV_ValidateSubgraphs, "validate graphviz subgraphs",
[IsGVObject],
function(x)
  local depth, lineIdx, line, lines;

  lineIdx := 0;
  depth := 0;
  lines := GV_Lines(x);
  for lineIdx in [1..Length(lines)] do
    line := lines[lineIdx];

    if line[1] = "SubBegin" then
      depth := depth + 1;
    elif line[1] = "SubEnd" then
      depth := depth - 1;
    fi;

    if depth < 0 then
      return [depth, lineIdx];
    fi;
  od;

  return [depth, lineIdx];
end);

InstallMethod(GV_String, "for a graphviz object",
[IsGVObject],
function(x)
  local result, info, line, i;

  info := GV_ValidateSubgraphs(x);
  if info[1] < 0 then
    return StringFormatted("Failed to output - Too many ending brackets. Line: {}\n", info[2]);
  elif info[1] > 0 then 
    return "Failed to output - Too few ending brackets\n";
  fi;

  result := "";
  for i in [1 .. Length(GV_Lines(x))] do
    line := GV_Lines(x)[i];
    if line[1] = "Head" then
      Append(result, GV_Head(x));
    elif line[1] = "Node" then
      Append(result,
             CallFuncList(GV_StringifyNode, [line[2], GV_Nodes(x).(line[2])]));
    elif line[1] = "Edge" then
      Append(result, CallFuncList(x!.EdgeFunc, GV_Edges(x)[line[2]]));
    elif line[1] = "GraphAttr" then
      Append(result, GV_StringifyGraphAttrs(GV_GraphAttrs(x)[line[2]]));
    elif line[1] = "NodeAttr" then
      Append(result,
             StringFormatted("\tnode {}\n",
                             GV_StringifyNodeEdgeAttrs(GV_NodeAttrs(x)[line[2]])));
    elif line[1] = "EdgeAttr" then
      Append(result,
             StringFormatted("\tedge {}\n",
                             GV_StringifyNodeEdgeAttrs(GV_EdgeAttrs(x)[line[2]])));
    elif line[1] = "Comment" then
      Append(result, GV_StringifyComment(GV_Comments(x)[line[2]]));
    elif line[1] = "SubBegin" then
      Append(result, GV_StringifySubgraphBegin(GV_Subgraphs(x)[line[2]]));
    elif line[1] = "SubEnd" then
      Append(result, GV_StringifySubgraphEnd());
    fi;
  od;
  Append(result, "}\n");
  return result;
end);


