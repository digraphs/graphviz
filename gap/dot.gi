# ##############################################################################
# Private functionality
# ##############################################################################

DeclareOperation("GV_GetCounter", [IsGVGraph]);
DeclareOperation("GV_IncCounter", [IsGVGraph]);
DeclareCategory("IsGV_Map", IsObject);

DeclareOperation("GV_StringifyGraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifyDigraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifySubgraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifyContextHead", [IsGVGraph]);
DeclareOperation("GV_StringifyGraphEdge", [IsGVEdge]);
DeclareOperation("GV_StringifyDigraphEdge", [IsGVEdge]);
DeclareOperation("GV_StringifyNode", [IsGVNode]);
DeclareOperation("GV_StringifyGraphAttrs", [IsGVGraph]);
DeclareOperation("GV_StringifyNodeEdgeAttrs", [IsGV_Map]);
DeclareOperation("GV_StringifyGraph", [IsGVGraph, IsBool]);

DeclareOperation("GV_FindNode", [IsGVGraph, IsObject]);

## COPY OF GAP PLURALIZE TO ALLOW OLD VERSIONS OF GAP TO USE THE PACKAGE
DeclareOperation("GV_Pluralize", [IsInt, IsString]);

BindGlobal("GV_KNOWN_ATTRS", [
  "_background", "area", "arrowhead", "arrowsize", "arrowtail", "bb",
  "beautify", "bgcolor", "center", "charset", "class", "cluster", "clusterrank",
  "color", "colorscheme", "comment", "compound", "concentrate", "constraint",
  "Damping", "decorate", "defaultdist", "dim", "dimen", "dir",
  "diredgeconstraints", "distortion", "dpi", "edgehref", "edgetarget",
  "edgetooltip", "edgeURL", "epsilon", "esep", "fillcolor", "fixedsize",
  "fontcolor", "fontname", "fontnames", "fontpath", "fontsize", "forcelabels",
  "gradientangle", "group", "head_lp", "headclip", "headhref", "headlabel",
  "headport", "headtarget", "headtooltip", "headURL", "height", "href", "id",
  "image", "imagepath", "imagepos", "imagescale", "inputscale", "K", "label",
  "label_scheme", "labelangle", "labeldistance", "labelfloat", "labelfontcolor",
  "labelfontname", "labelfontsize", "labelhref", "labeljust", "labelloc",
  "labeltarget", "labeltooltip", "labelURL", "landscape", "layer",
  "layerlistsep", "layers", "layerselect", "layersep", "layout", "len",
  "levels", "levelsgap", "lhead", "lheight", "linelength", "lp", "ltail",
  "lwidth", "margin", "maxiter", "mclimit", "mindist", "minlen", "mode",
  "model", "newrank", "nodesep", "nojustify", "normalize", "notranslate",
  "nslimit", "nslimit1", "oneblock", "ordering", "orientation", "outputorder",
  "overlap", "overlap_scaling", "overlap_shrink", "pack", "packmode", "pad",
  "page", "pagedir", "pencolor", "penwidth", "peripheries", "pin", "pos",
  "quadtree", "quantum", "rank", "rankdir", "ranksep", "ratio", "rects",
  "regular", "remincross", "repulsiveforce", "resolution", "root", "rotate",
  "rotation", "samehead", "sametail", "samplepoints", "scale", "searchsize",
  "sep", "shape", "shapefile", "showboxes", "sides", "size", "skew",
  "smoothing", "sortv", "splines", "start", "style", "stylesheet", "tail_lp",
  "tailclip", "tailhref", "taillabel", "tailport", "tailtarget", "tailtooltip",
  "tailURL", "target", "TBbalance", "tooltip", "truecolor", "URL", "vertices",
  "viewport", "voro_margin", "weight", "width", "xdotversion", "xlabel", "xlp",
  "z"
]);

# code from the GAP standard library
InstallMethod(GV_Pluralize,
"for an integer and a string",
[IsInt, IsString],
function(args...)
  local nargs, i, count, include_num, str, len, out;

  nargs := Length(args);
  if nargs >= 1 and IsInt(args[1]) and args[1] >= 0 then
    i           := 2;
    count       := args[1];
    include_num := true;
  else
    i           := 1;
    include_num := false;  # if not given, assume pluralization is wanted.
  fi;

  if not (nargs in [i, i + 1] and
          IsString(args[i]) and
          (nargs = i or IsString(args[i + 1]))) then
    ErrorNoReturn("Usage: GV_Pluralize([<count>, ]<string>[, <plural>])");
  fi;

  str := args[i];
  len := Length(str);

  if len = 0 then
    ErrorNoReturn("the argument <str> must be a non-empty string");
  elif include_num and count = 1 then  # no pluralization needed
    return Concatenation("\>1\< ", str);
  elif nargs = i + 1 then  # pluralization given
    out := args[i + 1];
  elif len <= 2 then
    out := Concatenation(str, "s");

    # Guess and return the plural form of <str>.
    # Inspired by the "Ruby on Rails" inflection rules.

    # Uncountable nouns
  elif str in ["equipment", "information"] then
    out := str;

    # Irregular plurals
  elif str = "axis" then
    out := "axes";
  elif str = "child" then
    out := "children";
  elif str = "person" then
    out := "people";

    # Peculiar endings
  elif EndsWith(str, "ix") or EndsWith(str, "ex") then
    out := Concatenation(str{[1 .. len - 2]}, "ices");
  elif EndsWith(str, "x") then
    out := Concatenation(str, "es");
  elif EndsWith(str, "tum") or EndsWith(str, "ium") then
    out := Concatenation(str{[1 .. len - 2]}, "a");
  elif EndsWith(str, "sis") then
    out := Concatenation(str{[1 .. len - 3]}, "ses");
  elif EndsWith(str, "fe") and not EndsWith(str, "ffe") then
    out := Concatenation(str{[1 .. len - 2]}, "ves");
  elif EndsWith(str, "lf") or EndsWith(str, "rf") or EndsWith(str, "loaf") then
    out := Concatenation(str{[1 .. len - 1]}, "ves");
  elif EndsWith(str, "y") and not str[len - 1] in "aeiouy" then
    out := Concatenation(str{[1 .. len - 1]}, "ies");
  elif str{[len - 1, len]} in ["ch", "ss", "sh"] then
    out := Concatenation(str, "es");
  elif EndsWith(str, "s") then
    out := str;

    # Default to appending 's'
  else
    out := Concatenation(str, "s");
  fi;

  if include_num then
    return Concatenation("\>", String(args[1]), "\< ", out);
  fi;
  return out;
end);

###############################################################################
# Family + type
# ##############################################################################

BindGlobal("GV_ObjectFamily",
           NewFamily("GV_ObjectFamily",
                     IsGVObject));

BindGlobal("GV_MapType", NewType(GV_ObjectFamily,
                                 IsGV_Map and
                                 IsComponentObjectRep and
                                 IsAttributeStoringRep));

BindGlobal("GV_DigraphType", NewType(GV_ObjectFamily,
                                    IsGVDigraph and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

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

BindGlobal("GV_ContextType", NewType(GV_ObjectFamily,
                                    IsGVContext and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

# ##############################################################################
# Constuctors etc
# ##############################################################################
DeclareOperation("GV_Node", [IsGVGraph, IsString]);
DeclareOperation("GV_Edge", [IsGVGraph, IsGVNode, IsGVNode]);
DeclareOperation("GV_Graph", [IsGVGraph, IsString]);
DeclareOperation("GV_Digraph", [IsGVDigraph, IsString]);
DeclareOperation("GV_Context", [IsGVGraph, IsString]);
DeclareOperation("GV_Map", []);

InstallMethod(GV_Map,
"for a nothing",
[],
function()
  return Objectify(GV_MapType, rec(Data := rec()));
end);

InstallMethod(GV_Node,
"for a string",
[IsGVGraph, IsString],
function(graph, name)
  local out;
  if Length(name) = 0 then
    return ErrorNoReturn("Node name cannot be empty.");
  fi;
  out := Objectify(GV_NodeType,
                  rec(
                    Name  := name,
                    Attrs := GV_Map(),
                    Idx   := GV_GetCounter(graph)));
  GV_IncCounter(graph);
  return out;
end);

InstallMethod(GV_Edge, "for two graphviz nodes",
[IsGVGraph, IsGVNode, IsGVNode],
function(graph, head, tail)
  local out;
  out := Objectify(GV_EdgeType,
                rec(
                  Name  := "",
                  Head  := head,
                  Tail  := tail,
                  Attrs := GV_Map(),
                  Idx   := GV_GetCounter(graph)));
  GV_IncCounter(graph);
  return out;
end);

# Graph constructors

InstallMethod(GV_Digraph,
"for a graphviz digraph and a string",
[IsGVDigraph, IsString],
function(parent, name)
  local out;

  out         := GraphvizDigraph(name);
  out!.Parent := parent;
  out!.Idx    := GV_GetCounter(parent);

  GV_IncCounter(parent);
  return out;
end);

InstallMethod(GV_Graph,
"for a graphviz graph and a string",
[IsGVGraph, IsString],
function(parent, name)
  local out;

  out         := GraphvizGraph(name);
  out!.Parent := parent;
  out!.Idx    := GV_GetCounter(parent);

  GV_IncCounter(parent);
  return out;
end);

InstallMethod(GV_Context,
"for a string and a positive integer",
[IsGVGraph, IsString],
function(parent, name)
  local out;

  out := Objectify(GV_ContextType,
                      rec(
                        Name      := name,
                        Subgraphs := GV_Map(),
                        Nodes     := GV_Map(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := parent,
                        Idx       := GV_GetCounter(parent),
                        Counter   := 1));

  GV_IncCounter(parent);
  return out;
end);

# public constructors

InstallMethod(GraphvizGraph,
"for a string",
[IsString],
function(name)
  return Objectify(GV_GraphType,
                      rec(
                        Name      := name,
                        Subgraphs := GV_Map(),
                        Nodes     := GV_Map(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := fail,
                        Idx       := 1,
                        Counter   := 1));
end);

InstallMethod(GraphvizGraph,
"for an object",
[IsObject],
o -> GraphvizGraph(ViewString(o)));

InstallMethod(GraphvizDigraph,
"for a string",
[IsString],
function(name)
  return Objectify(GV_DigraphType,
                      rec(
                        Name      := name,
                        Subgraphs := GV_Map(),
                        Nodes     := GV_Map(),
                        Edges     := [],
                        Attrs     := [],
                        Parent    := fail,
                        Idx       := 1,
                        Counter   := 1));
end);

InstallMethod(GraphvizDigraph,
"for an object",
[IsObject],
o -> GraphvizDigraph(ViewString(o)));

InstallMethod(GraphvizGraph, "for no args", [], {} -> GraphvizGraph(""));
InstallMethod(GraphvizDigraph, "for no args", [], {} -> GraphvizDigraph(""));

# ###########################################################
# Graphviz Map Functions
# ###########################################################
InstallOtherMethod(\[\],
"for a graphviz map and an object",
[IsGV_Map, IsObject],
function(m, o)
  if IsBound(m[o]) then
    return m!.Data.(o);
  fi;
  return fail;
end);

InstallOtherMethod(\[\]\:\=,
"for a graphviz map and two objects",
[IsGV_Map, IsObject, IsObject],
function(m, key, val)
  m!.Data.(key) := val;
end);

InstallOtherMethod(Unbind\[\],
"for a graphviz map and an object",
[IsGV_Map, IsObject],
function(m, key)
  Unbind(m!.Data.(key));
end);

InstallOtherMethod(IsBound\[\],
"for a graphviz map and an object",
[IsGV_Map, IsObject],
function(m, key)
  return IsBound(m!.Data.(key));
end);

DeclareOperation("GV_MapNames", [IsGV_Map]);
InstallMethod(GV_MapNames,
"for a graphviz map",
[IsGV_Map],
m -> RecNames(m!.Data));

InstallMethod(ViewString,
"for a graphviz map",
[IsGV_Map],
m -> String(m!.Data));

# ###########################################################
# Stringify
# ###########################################################
InstallMethod(ViewString,
"for a graphviz node",
[IsGVNode],
n -> StringFormatted("<graphviz node {}>", GraphvizName(n)));

InstallMethod(ViewString, "for a graphviz edge", [IsGVEdge],
function(e)
  local head, tail;
  head := GraphvizHead(e);
  tail := GraphvizTail(e);
  return StringFormatted("<graphviz edge ({}, {})>",
                         GraphvizName(head), GraphvizName(tail));
end);

InstallMethod(ViewString, "for a graphviz graph", [IsGVGraph],
function(g)
  local result, edges, nodes;
  result := "";
  edges  := Length(GraphvizEdges(g));
  nodes  := Length(GV_MapNames(GraphvizNodes(g)));

  Append(result, StringFormatted("<graphviz graph ", GraphvizName(g)));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("{} ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", GV_Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", GV_Pluralize(edges, "edge")));

  return result;
end);

InstallMethod(ViewString, "for a graphviz digraph", [IsGVDigraph],
function(g)
  local result, edges, nodes;
  result := "";
  edges  := Length(GraphvizEdges(g));
  nodes  := Length(GV_MapNames(GraphvizNodes(g)));

  Append(result, StringFormatted("<graphviz digraph ", GraphvizName(g)));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("{} ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", GV_Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", GV_Pluralize(edges, "edge")));

  return result;
end);

InstallMethod(ViewString, "for a graphviz context", [IsGVContext],
function(g)
  local result, edges, nodes;
  result := "";
  edges  := Length(GraphvizEdges(g));
  nodes  := Length(GV_MapNames(GraphvizNodes(g)));

  Append(result, StringFormatted("<graphviz context ", GraphvizName(g)));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("{} ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", GV_Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", GV_Pluralize(edges, "edge")));

  return result;
end);

# ###########################################################
# Getters
# ###########################################################
InstallMethod(GraphvizName,
"for a graphviz object",
[IsGVObject],
x -> x!.Name);

InstallMethod(GraphvizAttrs,
"for a graphviz object",
[IsGVObject],
x -> x!.Attrs);

InstallMethod(GraphvizNodes,
"for a graphviz graph",
[IsGVGraph],
x -> x!.Nodes);

InstallMethod(GraphvizEdges,
"for a graphviz graph",
[IsGVGraph],
x -> x!.Edges);

InstallMethod(GraphvizSubgraphs,
"for a graphviz graph",
[IsGVGraph],
x -> x!.Subgraphs);

InstallMethod(GraphvizTail, "for a graphviz edge", [IsGVEdge], x -> x!.Tail);
InstallMethod(GraphvizHead, "for a graphviz edge", [IsGVEdge], x -> x!.Head);

InstallMethod(GraphvizGetSubgraph,
"for a graphviz graph and string",
[IsGVGraph, IsString],
{x, name} -> GraphvizSubgraphs(x)[name]);

InstallMethod(GraphvizGetSubgraph,
"for a graphviz graph and an object",
[IsGVGraph, IsObject],
{x, o} -> GraphvizSubgraphs(x)[ViewString(o)]);

InstallMethod(GV_IncCounter,
"for a graphviz graph",
[IsGVGraph],
function(x)
  x!.Counter := x!.Counter + 1;
end);

InstallMethod(GV_GetCounter,
"for a graphviz graph",
[IsGVGraph],
x -> x!.Counter);

# Converting strings

DeclareOperation("GV_EnsureString", [IsObject]);
InstallMethod(GV_EnsureString,
"for an object",
[IsObject],
x -> ViewString(x));

InstallMethod(GV_EnsureString,
"for a string",
[IsString],
x -> x);

# Accessing node attributes

InstallOtherMethod(\[\],
"for a graphviz node and a string",
[IsGVNode, IsString],
{node, key} -> GraphvizAttrs(node)[key]);

InstallOtherMethod(\[\],
"for a graphviz node and an object",
[IsGVNode, IsObject],
{node, key} -> node[GV_EnsureString(key)]);

# Setting node attributes

InstallOtherMethod(\[\]\:\=,
"for a graphviz node and two strings",
[IsGVNode, IsString, IsString],
function(node, key, val)
  GraphvizAttrs(node)[key] := val;
end);

InstallOtherMethod(\[\]\:\=,
"for a graphviz node and two strings",
[IsGVNode, IsObject, IsObject],
function(node, key, val)
  node[GV_EnsureString(key)] := GV_EnsureString(val);
end);

# Accessing edge attributes

InstallOtherMethod(\[\],
"for a graphviz node and a string",
[IsGVEdge, IsString],
{edge, key} -> GraphvizAttrs(edge)[key]);

InstallOtherMethod(\[\],
"for a graphviz node and an object",
[IsGVEdge, IsObject],
{edge, key} -> edge[GV_EnsureString(key)]);

InstallOtherMethod(\[\]\:\=,
"for a graphviz node and a string",
[IsGVEdge, IsString, IsString],
function(edge, key, val)
  GraphvizAttrs(edge)[key] := val;
end);

InstallOtherMethod(\[\]\:\=,
"for a graphviz node and an object",
[IsGVEdge, IsObject, IsObject],
function(edge, key, val)
  edge[GV_EnsureString(key)] := GV_EnsureString(val);
end);

InstallOtherMethod(\[\],
"for a graphviz graph and string",
[IsGVGraph, IsString],
function(graph, node)
  return GraphvizNodes(graph)[node];
end);

InstallOtherMethod(\[\],
"for a graphviz graph and string",
[IsGVGraph, IsObject],
{g, o} -> g[ViewString(o)]);

DeclareOperation("GV_HasNode", [IsGVGraph, IsObject]);
InstallMethod(GV_HasNode,
"for a graphviz graph",
[IsGVGraph, IsString],
function(g, name)
  return name in GV_MapNames(GraphvizNodes(g));
end);

DeclareOperation("GV_GetParent", [IsGVGraph]);
InstallMethod(GV_GetParent,
"for a graphviz graph",
[IsGVGraph],
function(graph)
  return graph!.Parent;
end);

DeclareOperation("GV_GraphTreeSearch", [IsGVGraph, IsFunction]);
InstallMethod(GV_GraphTreeSearch,
"for a graphviz graph and a predicate",
[IsGVGraph, IsFunction],
function(graph, pred)
  local seen, to_visit, g, key, subgraph, parent;
  seen     := [graph];
  to_visit := [graph];

  while Length(to_visit) > 0 do
    g := Remove(to_visit, Length(to_visit));

    # Check this graph
    if pred(g) then
      return g;
    fi;

    # add subgraphs to list of to visit if not visited
    for key in GV_MapNames(GraphvizSubgraphs(g)) do
      subgraph := GraphvizSubgraphs(g)[key];
      if not ForAny(seen, s -> IsIdenticalObj(s, subgraph)) then
        Add(seen, subgraph);
        Add(to_visit, subgraph);
      fi;
    od;

    # add parent if not visited
    parent := GV_GetParent(g);
    if not IsGVGraph(parent) then
      continue;
    fi;
    if not ForAny(seen, s -> IsIdenticalObj(s, parent)) then
      Add(seen, parent);
      Add(to_visit, parent);
    fi;
  od;

  return fail;
end);

DeclareOperation("GV_FindGraphWithNode", [IsGVGraph, IsString]);
InstallMethod(GV_FindGraphWithNode,
"for a graphviz graph and a node",
[IsGVGraph, IsString],
{g, n} -> GV_GraphTreeSearch(g, v -> v[n] <> fail));

DeclareOperation("GV_GetRoot", [IsGVGraph]);
InstallMethod(GV_GetRoot,
"for a graphviz graph",
[IsGVGraph],
function(graph)
  while GV_GetParent(graph) <> fail do
    graph := GV_GetParent(graph);
  od;
  return graph;
end);

InstallMethod(GraphvizFindGraph,
"for a graphviz graph and a string",
[IsGVGraph, IsString],
{g, s} -> GV_GraphTreeSearch(g, v -> GraphvizName(v) = s));

InstallMethod(GraphvizFindGraph,
"for a graphviz graph and a string",
[IsGVGraph, IsObject],
{g, o} -> GraphvizFindGraph(g, ViewString(o)));

InstallMethod(GV_FindNode,
"for a graphviz graph and a string",
[IsGVGraph, IsString],
function(g, n)
  local graph;
  graph := GV_FindGraphWithNode(g, n);
  if graph = fail then
    return graph;
  fi;
  return graph[n];
end);

# ###########################################################
# Setters
# ###########################################################
InstallMethod(GraphvizSetName, "for a graphviz object and string",
[IsGVGraph, IsString],
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GraphvizSetName, "for a graphviz object and string",
[IsGVGraph, IsObject],
{g, o} -> GraphvizSetName(g, ViewString(o)));

InstallMethod(GraphvizSetAttrs, "for a graphviz object and record",
[IsGVObject, IsRecord],
function(x, attrs)
  local name;
  for name in RecNames(attrs) do
    GraphvizSetAttr(x, name, attrs.(name));
  od;
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz object, object and object",
[IsGVObject, IsObject, IsObject],
function(x, name, value)
  if not name in GV_KNOWN_ATTRS then
    Print(StringFormatted("[WARNING] Unknown attribute {}\n", name));
  fi;
  GraphvizAttrs(x)[String(name)] := String(value);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz graph, object and object",
[IsGVGraph, IsObject, IsObject],
function(x, name, value)
  local attrs, string;

  # display warning if not known attribute
  if not name in GV_KNOWN_ATTRS then
    Print(StringFormatted("[WARNING] Unknown attribute {}\n", name));
  fi;

  attrs := GraphvizAttrs(x);
  if ' ' in name then
    name := StringFormatted("{}", name);
  fi;
  if ' ' in value then
    value := StringFormatted("{}", value);
  fi;

  string := StringFormatted("{}={}", String(name), String(value));
  Add(attrs, string);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz object, object and object",
[IsGVGraph, IsObject],
function(x, value)
  local attrs;
  attrs := GraphvizAttrs(x);

  Add(attrs, String(value));
  return x;
end);

InstallMethod(GraphvizSetLabel,
"for a graphviz object and an object",
[IsGVObject, IsObject],
{x, label} -> GraphvizSetAttr(x, "label", label));

InstallMethod(GraphvizSetColor,
"for a graphviz object and an object",
[IsGVObject, IsObject],
{x, color} -> GraphvizSetAttr(x, "color", color));

DeclareOperation("GV_AddNode", [IsGVGraph, IsGVNode]);
InstallMethod(GV_AddNode,
"for a graphviz graph and node",
[IsGVGraph, IsGVNode],
function(x, node)
  local found, error, name, nodes;
  name  := GraphvizName(node);
  nodes := GraphvizNodes(x);

  # dont add if already node with the same name
  found := GV_FindGraphWithNode(x, name);
  if found <> fail then
    error := "Already node with name {} in graph {}.";
    return ErrorNoReturn(StringFormatted(error, name, GraphvizName(found)));
  fi;

  nodes[name] := node;
  return x;
end);

InstallMethod(GraphvizAddNode, "for a graphviz graph and string",
[IsGVGraph, IsString],
function(x, name)
  local node;
  node := GV_Node(x, name);
  GV_AddNode(x, node);
  return node;
end);

InstallMethod(GraphvizAddNode, "for a graphviz graph and string",
[IsGVGraph, IsGVNode],
function(_, __)
  local error;
  error := "Cannot add node objects directly to graphs. ";
  error := Concatenation(error, "Please use the node's name.");
  ErrorNoReturn(error);
end);

InstallMethod(GraphvizAddNode,
"for a graphviz graph and string",
[IsGVGraph, IsObject],
function(x, name)
  return GraphvizAddNode(x, ViewString(name));
end);

DeclareOperation("GV_AddEdge", [IsGVGraph, IsGVEdge]);
InstallMethod(GV_AddEdge,
"for a graphviz graph and edge",
[IsGVGraph, IsGVEdge],
function(x, edge)
  local head, head_name, tail_name, tail, hg, error, tg;

  head      := GraphvizHead(edge);
  tail      := GraphvizTail(edge);
  head_name := GraphvizName(head);
  tail_name := GraphvizName(tail);
  hg        := GV_FindGraphWithNode(x, head_name);
  tg        := GV_FindGraphWithNode(x, tail_name);

  # if not already existing, add the nodes to the graph
  if hg = fail then
    GV_AddNode(x, head);
  fi;
  if tg = fail then
    GV_AddNode(x, tail);
  fi;

  # make sure the nodes exist / are the same as existing ones
  if hg <> fail and not IsIdenticalObj(head, hg[head_name]) then
    error := "Different node in graph {} with name {}.";
    return ErrorNoReturn(StringFormatted(error,
                                        GraphvizName(hg),
                                        head_name));
  fi;
  if tg <> fail and not IsIdenticalObj(tail, tg[tail_name]) then
    error := "Different node in graph {} with name {}.";
    return ErrorNoReturn(StringFormatted(error,
                                         GraphvizName(tg),
                                         tail_name));
  fi;

  Add(x!.Edges, edge);
  return x;
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz graph and two graphviz nodes",
[IsGVGraph, IsGVNode, IsGVNode],
function(x, head, tail)
  local edge, head_name, tail_name;

  head_name := GraphvizName(head);
  tail_name := GraphvizName(tail);

  # add the nodes to the graph if not present
  if GV_FindNode(x, head_name) = fail then
    GV_AddNode(x, head);
  fi;
  if GV_FindNode(x, tail_name) = fail then
    GV_AddNode(x, tail);
  fi;

  edge := GV_Edge(x, head, tail);
  GV_AddEdge(x, edge);
  return edge;
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz graph and two strings",
[IsGVGraph, IsString, IsString],
function(x, head, tail)
  local head_node, tail_node;

  head_node := GV_FindNode(x, head);
  if head_node = fail then
    head_node := GV_Node(x, head);
  fi;

  tail_node := GV_FindNode(x, tail);
  if tail_node = fail then
    tail_node := GV_Node(x, tail);
  fi;

  return GraphvizAddEdge(x, head_node, tail_node);
end);

InstallMethod(GraphvizAddEdge,
"for a graphviz graph and two objects",
[IsGVGraph, IsObject, IsObject],
function(x, o1, o2)
  if not IsString(o1) then
    o1 := ViewString(o1);
  fi;
  if not IsString(o2) then
    o2 := ViewString(o2);
  fi;
  return GraphvizAddEdge(x, o1, o2);
end);

InstallMethod(GraphvizAddSubgraph,
"for a graphviz graph and string",
[IsGVGraph, IsString],
function(graph, name)
  local error, subgraphs, subgraph;

  subgraphs := GraphvizSubgraphs(graph);
  if IsBound(subgraphs[name]) then
    error := "The graph already contains a subgraph with name {}.";
    return ErrorNoReturn(StringFormatted(error, name));
  fi;

  if IsGVDigraph(graph) then
    subgraph := GV_Digraph(graph, name);
  elif IsGVGraph(graph) then
    subgraph := GV_Graph(graph, name);
  else
    return ErrorNoReturn("Filter must be a filter for a graph category.");
  fi;

  subgraphs[name] := subgraph;
  return subgraph;
end);

InstallMethod(GraphvizAddSubgraph,
"for a graphviz graph and an object",
[IsGVGraph, IsObject],
{g, o} -> GraphvizAddSubgraph(g, ViewString(o)));

InstallMethod(GraphvizAddSubgraph,
"for a grpahviz graph",
[IsGVGraph],
function(graph)
  return GraphvizAddSubgraph(graph, StringFormatted("no_name_{}",
                                               String(GV_GetCounter(graph))));
end);

InstallMethod(GraphvizAddContext,
"for a graphviz graph and a string",
[IsGVGraph, IsString],
function(graph, name)
  local ctx, error, subgraphs;

  subgraphs := GraphvizSubgraphs(graph);
  if IsBound(subgraphs[name]) then
    error := "The graph already contains a subgraph with name {}.";
    return ErrorNoReturn(StringFormatted(error, name));
  fi;

  ctx             := GV_Context(graph, name);
  subgraphs[name] := ctx;
  return ctx;
end);

InstallMethod(GraphvizAddContext,
"for a graphviz graph",
[IsGVGraph],
g -> GraphvizAddContext(g, StringFormatted("no_name_{}",
                                      String(GV_GetCounter(g)))));

InstallMethod(GraphvizAddContext,
"for a graphviz graph and an object",
[IsGVGraph, IsObject],
{g, o} -> GraphvizAddContext(g, ViewString(o)));

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and node",
[IsGVGraph, IsGVNode],
function(g, node)
  return GraphvizRemoveNode(g, GraphvizName(node));
end);

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and a string",
[IsGVGraph, IsString],
function(g, name)
  local nodes;
  nodes := GraphvizNodes(g);
  Unbind(nodes[name]);

  # remove incident edges
  GraphvizFilterEdges(g,
    function(e)
      local head, tail;
      head := GraphvizHead(e);
      tail := GraphvizTail(e);
      return name <> GraphvizName(tail) and name <> GraphvizName(head);
    end);

  return g;
end);

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and a string",
[IsGVGraph, IsObject],
{g, o} -> GraphvizRemoveNode(g, ViewString(o)));

InstallMethod(GraphvizFilterEdges, "for a graphviz graph and edge filter",
[IsGVGraph, IsFunction],
function(g, filter)
  local edge, idx, edges;

  edges := GraphvizEdges(g);
  idx   := Length(edges);
  while idx > 0 do
    edge := edges[idx];
    if not filter(edge) then
      Remove(edges, idx);
    fi;
    idx := idx - 1;
  od;

  return g;
end);

InstallMethod(GraphvizFilterEnds, "for a graphviz graph and two strings",
[IsGVGraph, IsString, IsString],
function(g, hn, tn)
  GraphvizFilterEdges(g,
    function(e)
      local head, tail, tmp;
      head := GraphvizHead(e);
      tail := GraphvizTail(e);
      if IsGVDigraph(g) then
        return tn <> GraphvizName(tail) or hn <> GraphvizName(head);
      else
        tmp := tn <> GraphvizName(tail) or hn <> GraphvizName(head);
        return tmp and (hn <> GraphvizName(tail) or tn <> GraphvizName(head));
      fi;
    end);

  return g;
end);

InstallMethod(GraphvizFilterEnds, "for a graphviz graph and two strings",
[IsGVGraph, IsObject, IsObject],
function(g, o1, o2)
  if not IsString(o1) then
    o1 := ViewString(o1);
  fi;
  if not IsString(o2) then
    o2 := ViewString(o2);
  fi;

  GraphvizFilterEnds(g, o1, o2);
end);

InstallMethod(GraphvizRemoveAttr, "for a graphviz object and an object",
[IsGVObject, IsObject],
function(obj, attr)
  local attrs;
  attrs := GraphvizAttrs(obj);
  Unbind(attrs[String(attr)]);
  return obj;
end);

InstallMethod(GraphvizRemoveAttr, "for a graphviz graph and an object",
[IsGVGraph, IsObject],
function(obj, attr)
  local attrs;
  attrs      := GraphvizAttrs(obj);
  obj!.Attrs := Filtered(attrs, item -> item[1] <> String(attr));
  return obj;
end);

# ##############################################################################
# Stringifying
# ##############################################################################

# @ Return DOT graph head line.
InstallMethod(GV_StringifyGraphHead, "for a string", [IsGVGraph],
function(graph)
  return StringFormatted("graph {} {{\n", GraphvizName(graph));
end);

# @ Return DOT digraph head line.
InstallMethod(GV_StringifyDigraphHead, "for a string", [IsGVDigraph],
function(graph)
  return StringFormatted("digraph {} {{\n", GraphvizName(graph));
end);

# @ Return DOT subgraph head line.
InstallMethod(GV_StringifySubgraphHead, "for a string", [IsGVGraph],
function(graph)
  return StringFormatted("subgraph {} {{\n", GraphvizName(graph));
end);

# @ Return DOT subgraph head line.
InstallMethod(GV_StringifyContextHead, "for a string", [IsGVContext],
function(graph)
  return StringFormatted("// {} context \n", GraphvizName(graph));
end);

# @ Return DOT node statement line.
InstallMethod(GV_StringifyNode, "for string and record",
[IsGVNode],
function(node)
  local attrs, name;

  name  := GraphvizName(node);
  attrs := GraphvizAttrs(node);
  return StringFormatted("\t{}{}\n", name, GV_StringifyNodeEdgeAttrs(attrs));
end);

# @ Return DOT graph edge statement line.
InstallMethod(GV_StringifyGraphEdge, "for a graphviz edge",
[IsGVEdge],
function(edge)
  local head, tail, attrs;
  head  := GraphvizName(GraphvizHead(edge));
  tail  := GraphvizName(GraphvizTail(edge));
  attrs := GraphvizAttrs(edge);

  # handle : syntax
  return StringFormatted("\t{} -- {}{}\n",
                         head,
                         tail,
                         GV_StringifyNodeEdgeAttrs(attrs));
end);

# @ Return DOT digraph edge statement line.
InstallMethod(GV_StringifyDigraphEdge, "for a graphviz edge",
[IsGVEdge],
function(edge)
  local head, tail, attrs;
  head  := GraphvizName(GraphvizHead(edge));
  tail  := GraphvizName(GraphvizTail(edge));
  attrs := GraphvizAttrs(edge);

  # handle : syntax
  return StringFormatted("\t{} -> {}{}\n",
                         head,
                         tail,
                         GV_StringifyNodeEdgeAttrs(attrs));
end);

InstallMethod(GV_StringifyGraphAttrs,
"for a graphviz graph",
[IsGVGraph],
function(graph)
  local result, attrs, kv;
  attrs  := GraphvizAttrs(graph);
  result := "";

  if Length(attrs) <> 0 then
    Append(result, "\t");
    for kv in attrs do
      Append(result,
             StringFormatted("{} ", kv));
    od;
    Append(result, "\n");
  fi;
  return result;
end);

InstallMethod(GV_StringifyNodeEdgeAttrs,
"for a record",
[IsGV_Map],
function(attrs)
  local result, keys, key, val, n, i, tmp;

  result := "";
  n      := Length(GV_MapNames(attrs));
  keys   := SSortedList(GV_MapNames(attrs));

  if n <> 0 then
    Append(result, " [");
    for i in [1 .. n - 1] do
        key := keys[i];
        val := attrs[key];

        tmp := Chomp(val);
        if "label" = key and StartsWith(tmp, "<<") and EndsWith(tmp, ">>") then
          val := StringFormatted("{}", val);
        else
            if ' ' in key then
              key := StringFormatted("\"{}\"", key);
            fi;
            if ' ' in val then
              val := StringFormatted("\"{}\"", val);
            fi;
        fi;

        Append(result,
               StringFormatted("{}={}, ",
                               key,
                               val));
    od;

    # handle last element
    key := keys[n];
    val := attrs[key];

    tmp := Chomp(val);
    if "label" = key and StartsWith(tmp, "<<") and EndsWith(tmp, ">>") then
      val := StringFormatted("{}", val);
    else
        if ' ' in key then
          key := StringFormatted("\"{}\"", key);
        fi;
        if ' ' in val then
          val := StringFormatted("\"{}\"", val);
        fi;
    fi;

    Append(result,
           StringFormatted("{}={}]",
                           key,
                           val));
  fi;

  return result;
end);

DeclareOperation("GV_GetIdx", [IsGVObject]);
InstallMethod(GV_GetIdx,
"for a graphviz object",
[IsGVObject],
x -> x!.Idx);

DeclareOperation("GV_ConstructHistory", [IsGVGraph]);
InstallMethod(GV_ConstructHistory,
"for a graphviz graph",
[IsGVGraph],
function(graph)
  local nodes, edges, subs, node_hist, edge_hist, subs_hist, hist;

  nodes := GraphvizNodes(graph);
  edges := GraphvizEdges(graph);
  subs  := GraphvizSubgraphs(graph);

  node_hist := List(GV_MapNames(nodes), n -> [GV_GetIdx(nodes[n]), nodes[n]]);
  subs_hist := List(GV_MapNames(subs), s -> [GV_GetIdx(subs[s]), subs[s]]);
  edge_hist := List(edges, e -> [GV_GetIdx(e), e]);

  hist := Concatenation(node_hist, edge_hist, subs_hist);
  SortBy(hist, v -> v[1]);

  Apply(hist, x -> x[2]);
  return hist;
end);

InstallMethod(GV_StringifyGraph,
"for a graphviz graph and a string",
[IsGVGraph, IsBool],
function(graph, is_subgraph)
  local result, obj, tmp;
  result := "";

  # get the correct head to use
  if is_subgraph then
    if IsGVContext(graph) then
      Append(result, GV_StringifyContextHead(graph));
    elif IsGVGraph(graph) or IsGVDigraph(graph) then
      Append(result, GV_StringifySubgraphHead(graph));
    else
      return ErrorNoReturn("Invalid subgraph type.");
    fi;
  elif IsGVDigraph(graph) then
    Append(result, GV_StringifyDigraphHead(graph));
  elif IsGVGraph(graph) then
    Append(result, GV_StringifyGraphHead(graph));
  elif IsGVContext(graph) then
    Append(result, GV_StringifyContextHead(graph));
  else
    return ErrorNoReturn("Invalid graph type.");
  fi;

  Append(result, GV_StringifyGraphAttrs(graph));

  # Add child graphviz objects
  for obj in GV_ConstructHistory(graph) do
    if IsGVGraph(obj) then
      Append(result, GV_StringifyGraph(obj, true));
    elif IsGVNode(obj) then
      Append(result, GV_StringifyNode(obj));
    elif IsGVEdge(obj) then
      if IsGVDigraph(GV_GetRoot(graph)) then
        Append(result, GV_StringifyDigraphEdge(obj));
      else
        Append(result, GV_StringifyGraphEdge(obj));
      fi;
    else
      return ErrorNoReturn("Invalid graphviz object type.");
    fi;
  od;

  if IsGVContext(graph) then
    # reset attributes following the context
    if GV_GetParent(graph) <> fail then
      Append(result, GV_StringifyGraphAttrs(GV_GetParent(graph)));
    fi;
    Append(result, "\n");
  else
    Append(result, "}\n");
  fi;
  return result;
end);

InstallMethod(AsString, "for a graphviz graph",
[IsGVGraph],
function(graph)
  return GV_StringifyGraph(graph, false);
end);
