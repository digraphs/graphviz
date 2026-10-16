#############################################################################
##
##  gv.gi
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# TODO: add assertions to BindGlobals

###############################################################################
# Family + type
###############################################################################

BindGlobal("GV_ObjectFamily",
           NewFamily("GV_ObjectFamily", IsGraphvizObject));

BindGlobal("GV_NodeType", NewType(GV_ObjectFamily,
                                  IsGraphvizNode and
                                  IsComponentObjectRep and
                                  IsAttributeStoringRep));

BindGlobal("GV_EdgeType", NewType(GV_ObjectFamily,
                                  IsGraphvizEdge and
                                  IsComponentObjectRep and
                                  IsAttributeStoringRep));

BindGlobal("GV_GraphDigraphOrContextType",
           NewType(GV_ObjectFamily,
                   IsGraphvizGraphDigraphOrContext and
                   IsComponentObjectRep and
                   IsAttributeStoringRep));

###############################################################################
# Constructors etc
###############################################################################

# Graph child counter functions

BindGlobal("GV_IncCounter",
function(gv)
  Assert(0, IsGraphvizObject(gv));
  gv!.Counter := gv!.Counter + 1;
end);

InstallMethod(GV_GetCounter, "for a graphviz graph",
[IsGraphvizGraphDigraphOrContext], gv -> gv!.Counter);

InstallMethod(GV_Node, "for a string",
[IsGraphvizGraphDigraphOrContext, IsString],
function(gv, name)
  local result;
  Assert(0, not IsEmpty(name));
  result := Objectify(GV_NodeType,
                      rec(Name   := name,
                          Attrs  := rec(),
                          Parent := gv,
                          Idx    := GV_GetCounter(gv)));
  GV_IncCounter(gv);
  return result;
end);

InstallMethod(GV_Edge, "for two graphviz nodes",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode, IsGraphvizNode],
function(gv, head, tail)
  local result;
  result := Objectify(GV_EdgeType,
                      rec(Name   := StringFormatted("({}, {})",
                                                    GraphvizName(head),
                                                    GraphvizName(tail)),
                          Head   := head,
                          Tail   := tail,
                          Attrs  := rec(),
                          Parent := gv,
                          Idx    := GV_GetCounter(gv)));
  GV_IncCounter(gv);
  return result;
end);

# Graph constructors

InstallMethod(GV_GraphOrDigraph,
"for a string and a filter", [IsString, IsFunction],
function(name, filt)
  local result;
  Assert(0, filt = IsGraphvizGraph or filt = IsGraphvizDigraph);

  # Note that the components of the record below aren't attributes because we
  # require them to be mutable.
  result := Objectify(GV_GraphDigraphOrContextType,
                      rec(Name      := name,
                          Subgraphs := rec(),
                          Contexts  := rec(),
                          Nodes     := rec(),
                          Edges     := [],
                          Attrs     := rec(graph := rec(),
                                           edge := rec(),
                                           node := rec()),
                          Parent    := fail,
                          Idx       := 1,
                          Counter   := 1));
  SetFilterObj(result, filt);
  SetGV_Filter(result, filt);
  return result;
end);

InstallMethod(GV_Subgraph, "for a graphviz graph and a string",
[IsGraphvizGraphDigraphOrContext, IsString],
function(gv, name)
  local result;

  result          := GV_GraphOrDigraph(name, GV_Filter(gv));
  result!.Parent  := gv;
  result!.Idx     := GV_GetCounter(gv);

  GV_IncCounter(gv);
  return result;
end);

InstallMethod(GV_Context, "for a graphviz (di)graph or context and a string",
[IsGraphvizGraphDigraphOrContext, IsString],
function(gv, name)
  local result;
  result := GV_Subgraph(gv, name);
  SetFilterObj(result, IsGraphvizContext);
  return result;
end);

# Nodes

InstallMethod(GV_GetParent, "for a graphviz object",
[IsGraphvizObject], gv -> gv!.Parent);

# TODO: GV_GraphTreeSearch apparently searches both up and down in the tree,
# while GV_GraphSearchChildren only searches down. These could be amalgamated
# by just initialising to_visit with all the ancestors of the gv, then calling
# GV_GraphSearchChildren
InstallMethod(GV_GraphTreeSearch,
"for a graphviz (di)graph or context and a predicate",
[IsGraphvizGraphDigraphOrContext, IsFunction],
function(gv, pred)
  local seen, to_visit, subgraph, subsubgraph, context, parent, key;

  # TODO this shouldn't be necessary, the subgraphs should be a tree, so we
  # shouldn't be able to see a subgraph occurring in more than one object.
  seen     := [gv];
  to_visit := [gv];

  while Length(to_visit) > 0 do
    subgraph := Remove(to_visit, Length(to_visit));

    if pred(subgraph) then
      return subgraph;
    fi;

    # add subgraphs to list of to visit if not visited
    for key in RecNames(GraphvizSubgraphs(subgraph)) do
      subsubgraph := GraphvizSubgraphs(subgraph).(key);
      if not subsubgraph in seen then
        Add(seen, subsubgraph);
        Add(to_visit, subsubgraph);
      fi;
    od;

    # add contexts to list of to visit if not visited
    for key in RecNames(GraphvizContexts(subgraph)) do
      context := GraphvizContexts(subgraph).(key);
      if not context in seen then
        Add(seen, context);
        Add(to_visit, context);
      fi;
    od;

    # add parent if not visited
    parent := GV_GetParent(subgraph);

    if not IsGraphvizGraphDigraphOrContext(parent) then
      # TODO Not sure this can ever occur
      continue;
    elif not parent in seen then
      # TODO Not sure this can ever occur
      Add(seen, parent);
      Add(to_visit, parent);
    fi;
  od;

  return fail;
end);

# tree search only on the children of the graph
InstallMethod(GV_GraphSearchChildren,
"for a graphviz graph and a predicate",
[IsGraphvizGraphDigraphOrContext, IsFunction],
function(gv, func)
  local _, curr, queue, count, nexts, key;

  # TODO check func has right number of args

  queue := [gv];
  while Length(queue) > 0 do
    count := Length(queue);

    for _ in [1 .. count] do
      # TODO: make sure this is using a linked list rather than an array list
      curr := Remove(queue, 1);

      # Check this graph (visit)
      if func(curr) then
        return curr;
      fi;

      # Add children
      nexts := GraphvizSubgraphs(curr);
      for key in RecNames(nexts) do
        Add(queue, nexts.(key));
      od;
      nexts := GraphvizContexts(curr);
      for key in RecNames(nexts) do
        Add(queue, nexts.(key));
      od;
    od;
  od;

  return fail;
end);

InstallMethod(GV_FindGraphWithNode,
"for a graphviz graph and a node",
[IsGraphvizGraphDigraphOrContext, IsString],
{gv, name} -> GV_GraphTreeSearch(gv, subgraph -> IsBound(GraphvizNodes(subgraph).(name))));

InstallMethod(GV_GetRoot,
"for a graphviz graph",
[IsGraphvizObject],
function(gv)
  while GV_GetParent(gv) <> fail do
    gv := GV_GetParent(gv);
  od;
  return gv;
end);

BindGlobal("GV_Indent", lvl -> ListWithIdenticalEntries(2 * lvl, ' '));

BindGlobal("GV_Depth", function(gv)
  local depth;
  Assert(0, IsGraphvizObject(gv));
  depth := 0;
  while GV_GetParent(gv) <> fail do
    gv := GV_GetParent(gv);
    depth := depth + 1;
  od;
  return depth;
end);

InstallMethod(GV_AddNode,
"for a graphviz graph and node",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode],
function(gv, node)
  local name, nodes;
  name  := GraphvizName(node);
  nodes := GraphvizNodes(gv);
  nodes.(name) := node;
  return gv;
end);

InstallMethod(GV_AddEdge,
"for a graphviz graph and edge",
[IsGraphvizGraphDigraphOrContext, IsGraphvizEdge],
function(gv, edge)
  Add(gv!.Edges, edge);
  return gv;
end);

###############################################################################
# Stringifying
###############################################################################

BindGlobal("GV_StringifyGraphHead",
gv -> StringFormatted("graph {} {{\n", GraphvizName(gv)));

BindGlobal("GV_StringifyDigraphHead",
gv -> StringFormatted("digraph {} {{\n", GraphvizName(gv)));

BindGlobal("GV_StringifySubgraphHead",
gv -> StringFormatted("{}subgraph {} {{\n", GV_Indent(GV_Depth(gv)), GraphvizName(gv)));

BindGlobal("GV_StringifyContextHead",
function(gv)
  local indent;
  indent := GV_Indent(GV_Depth(gv));
  return StringFormatted("{1}{{\n{1}  // context \"{2}\" \n",
                         indent,
                         GraphvizName(gv));
end);

BindGlobal("GV_StringifyNodeName",
function(node)
  local name, old;

  Assert(0, IsGraphvizNode(node));
  name  := GraphvizName(node);
  if (ForAny("- .+", x -> x in name)
      or (IsDigitChar(First(name)) and IsAlphaChar(Last(name))))
      and not StartsWith(name, "\"") then
    old  := name;
    name := StringFormatted("\"{}\"", name);
    Info(InfoWarning, 1, "invalid node name ", old, " using ", name, " instead");
  fi;
  return name;
end);

BindGlobal("GV_StringifyAttrList",
function(attrs)
  local result, n, keys, key, val, i;

  Assert(0, IsRecord(attrs));

  result := "";
  n      := Length(RecNames(attrs));
  keys   := SSortedList(RecNames(attrs));

  if n <> 0 then
    Append(result, " [");
    for i in [1 .. n - 1] do
      key := keys[i];
      val := attrs.(key);
      if not StartsWith(val, "\"") then
        val := StringFormatted("\"{}\"", val);
      fi;

      Append(result, StringFormatted("{}={}, ", key, val));
    od;
    # handle last element
    key := keys[n];
    val := attrs.(key);
    if not StartsWith(val, "\"") then
      val := StringFormatted("\"{}\"", val);
    fi;
    Append(result, StringFormatted("{}={}]", key, val));
  fi;

  return result;
end);

BindGlobal("GV_StringifyNode",
function(node)
  local name, attrs;
  Assert(0, IsGraphvizNode(node));
  name  := GV_StringifyNodeName(node);
  attrs := GraphvizAttrs(node);
  return StringFormatted("{}{}{}\n",
                         GV_Indent(GV_Depth(node)),
                         name,
                         GV_StringifyAttrList(attrs));
end);

BindGlobal("GV_StringifyEdge",
function(edge, edge_str)
  local head, tail, attrs;
  Assert(0, IsGraphvizEdge(edge));
  Assert(0, IsString(edge_str));
  head  := GV_StringifyNodeName(GraphvizHead(edge));
  tail  := GV_StringifyNodeName(GraphvizTail(edge));
  attrs := GraphvizAttrs(edge);

  # handle : syntax
  return StringFormatted("{}{} {} {}{}\n",
                         GV_Indent(GV_Depth(edge)),
                         head,
                         edge_str,
                         tail,
                         GV_StringifyAttrList(attrs));
end);

BindGlobal("GV_GetIdx", gv -> gv!.Idx);

BindGlobal("GV_ConstructHistory",
function(gv)
  local ctxs, nodes, edges, subs,
        ctxs_hist, node_hist, edge_hist, subs_hist, hist;

  nodes := GraphvizNodes(gv);
  edges := GraphvizEdges(gv);
  subs  := GraphvizSubgraphs(gv);
  ctxs  := GraphvizContexts(gv);

  node_hist := List(RecNames(nodes), n -> [GV_GetIdx(nodes.(n)), nodes.(n)]);
  subs_hist := List(RecNames(subs), s -> [GV_GetIdx(subs.(s)), subs.(s)]);
  ctxs_hist := List(RecNames(ctxs), s -> [GV_GetIdx(ctxs.(s)), ctxs.(s)]);
  edge_hist := List(edges, e -> [GV_GetIdx(e), e]);

  hist := Concatenation(node_hist, edge_hist, subs_hist, ctxs_hist);
  SortBy(hist, v -> v[1]);

  Apply(hist, x -> x[2]);
  return hist;
end);

InstallMethod(GV_StringifyGraph,
"for a graphviz graph and a string",
[IsGraphvizGraphDigraphOrContext, IsBool],
function(gv, is_subgraph)
  local result, record, type, obj;

  result := "";

  # get the correct head to use
  if is_subgraph then
    if IsGraphvizContext(gv) then
      Append(result, GV_StringifyContextHead(gv));
    else
      Append(result, GV_StringifySubgraphHead(gv));
    fi;
  elif IsGraphvizDigraph(gv) then
    Append(result, "//dot\n");
    Append(result, GV_StringifyDigraphHead(gv));
  elif IsGraphvizGraph(gv) then
    Append(result, "//dot\n");
    Append(result, GV_StringifyGraphHead(gv));
  else
    ErrorFormatted("Unknown gv category, ",
                   "expected a context, digraph or gv.");
  fi;

  for type in ["graph", "node", "edge"] do
    record := GraphvizAttrs(gv).(type);
    if Length(RecNames(record)) > 0 then
      Append(result,
        StringFormatted("{}{}{}\n",
                        GV_Indent(GV_Depth(gv) + 1),
                        type,
                        GV_StringifyAttrList(record)));
    fi;
  od;

  # Add child graphviz objects
  for obj in GV_ConstructHistory(gv) do
    if IsGraphvizGraphDigraphOrContext(obj) then
      Append(result, GV_StringifyGraph(obj, true));
    elif IsGraphvizNode(obj) then
      Append(result, GV_StringifyNode(obj));
    elif IsGraphvizEdge(obj) then
      if (IsGraphvizDigraph(GV_GetRoot(gv))) then
        Append(result, GV_StringifyEdge(obj, "->"));
      else
        Append(result, GV_StringifyEdge(obj, "--"));
      fi;
    fi;
  od;

  Append(result, StringFormatted("{}}}", GV_Indent(GV_Depth(gv))));
  if GV_Depth(gv) > 0 then
    Append(result, "\n");
  fi;
  return result;
end);

BindGlobal("GV_ValidColorNames",
  ["aliceblue", "antiquewhite", "antiquewhite1", "antiquewhite2",
  "antiquewhite3", "antiquewhite4", "aquamarine", "aquamarine1", "aquamarine2",
  "aquamarine3", "aquamarine4", "azure", "azure1", "azure2", "azure3",
  "azure4", "beige", "bisque", "bisque1", "bisque2", "bisque3", "bisque4",
  "black", "blanchedalmond", "blue", "blue1", "blue2", "blue3", "blue4",
  "blueviolet", "brown", "brown1", "brown2", "brown3", "brown4", "burlywood",
  "burlywood1", "burlywood2", "burlywood3", "burlywood4", "cadetblue",
  "cadetblue1", "cadetblue2", "cadetblue3", "cadetblue4", "chartreuse",
  "chartreuse1", "chartreuse2", "chartreuse3", "chartreuse4", "chocolate",
  "chocolate1", "chocolate2", "chocolate3", "chocolate4", "coral", "coral1",
  "coral2", "coral3", "coral4", "cornflowerblue", "cornsilk", "cornsilk1",
  "cornsilk2", "cornsilk3", "cornsilk4", "crimson", "cyan", "cyan1", "cyan2",
  "cyan3", "cyan4", "darkgoldenrod", "darkgoldenrod1", "darkgoldenrod2",
  "darkgoldenrod3", "darkgoldenrod4", "darkgreen", "darkkhaki",
  "darkolivegreen", "darkolivegreen1", "darkolivegreen2", "darkolivegreen3",
  "darkolivegreen4", "darkorange", "darkorange1", "darkorange2", "darkorange3",
  "darkorange4", "darkorchid", "darkorchid1", "darkorchid2", "darkorchid3",
  "darkorchid4", "darksalmon", "darkseagreen", "darkseagreen1",
  "darkseagreen2", "darkseagreen3", "darkseagreen4", "darkslateblue",
  "darkslategray", "darkslategray1", "darkslategray2", "darkslategray3",
  "darkslategray4", "darkslategrey", "darkturquoise", "darkviolet", "deeppink",
  "deeppink1", "deeppink2", "deeppink3", "deeppink4", "deepskyblue",
  "deepskyblue1", "deepskyblue2", "deepskyblue3", "deepskyblue4", "dimgray",
  "dimgrey", "dodgerblue", "dodgerblue1", "dodgerblue2", "dodgerblue3",
  "dodgerblue4", "firebrick", "firebrick1", "firebrick2", "firebrick3",
  "firebrick4", "floralwhite", "forestgreen", "gainsboro", "ghostwhite",
  "gold", "gold1", "gold2", "gold3", "gold4", "goldenrod", "goldenrod1",
  "goldenrod2", "goldenrod3", "goldenrod4", "gray", "gray0", "gray1", "gray10",
  "gray100", "gray11", "gray12", "gray13", "gray14", "gray15", "gray16",
  "gray17", "gray18", "gray19", "gray2", "gray20", "gray21", "gray22",
  "gray23", "gray24", "gray25", "gray26", "gray27", "gray28", "gray29",
  "gray3", "gray30", "gray31", "gray32", "gray33", "gray34", "gray35",
  "gray36", "gray37", "gray38", "gray39", "gray4", "gray40", "gray41",
  "gray42", "gray43", "gray44", "gray45", "gray46", "gray47", "gray48",
  "gray49", "gray5", "gray50", "gray51", "gray52", "gray53", "gray54",
  "gray55", "gray56", "gray57", "gray58", "gray59", "gray6", "gray60",
  "gray61", "gray62", "gray63", "gray64", "gray65", "gray66", "gray67",
  "gray68", "gray69", "gray7", "gray70", "gray71", "gray72", "gray73",
  "gray74", "gray75", "gray76", "gray77", "gray78", "gray79", "gray8",
  "gray80", "gray81", "gray82", "gray83", "gray84", "gray85", "gray86",
  "gray87", "gray88", "gray89", "gray9", "gray90", "gray91", "gray92",
  "gray93", "gray94", "gray95", "gray96", "gray97", "gray98", "gray99",
  "green", "green1", "green2", "green3", "green4", "greenyellow", "grey",
  "grey0", "grey1", "grey10", "grey100", "grey11", "grey12", "grey13",
  "grey14", "grey15", "grey16", "grey17", "grey18", "grey19", "grey2",
  "grey20", "grey21", "grey22", "grey23", "grey24", "grey25", "grey26",
  "grey27", "grey28", "grey29", "grey3", "grey30", "grey31", "grey32",
  "grey33", "grey34", "grey35", "grey36", "grey37", "grey38", "grey39",
  "grey4", "grey40", "grey41", "grey42", "grey43", "grey44", "grey45",
  "grey46", "grey47", "grey48", "grey49", "grey5", "grey50", "grey51",
  "grey52", "grey53", "grey54", "grey55", "grey56", "grey57", "grey58",
  "grey59", "grey6", "grey60", "grey61", "grey62", "grey63", "grey64",
  "grey65", "grey66", "grey67", "grey68", "grey69", "grey7", "grey70",
  "grey71", "grey72", "grey73", "grey74", "grey75", "grey76", "grey77",
  "grey78", "grey79", "grey8", "grey80", "grey81", "grey82", "grey83",
  "grey84", "grey85", "grey86", "grey87", "grey88", "grey89", "grey9",
  "grey90", "grey91", "grey92", "grey93", "grey94", "grey95", "grey96",
  "grey97", "grey98", "grey99", "honeydew", "honeydew1", "honeydew2",
  "honeydew3", "honeydew4", "hotpink", "hotpink1", "hotpink2", "hotpink3",
  "hotpink4", "indianred", "indianred1", "indianred2", "indianred3",
  "indianred4", "indigo", "invis", "ivory", "ivory1", "ivory2", "ivory3",
  "ivory4", "khaki", "khaki1", "khaki2", "khaki3", "khaki4", "lavender",
  "lavenderblush", "lavenderblush1", "lavenderblush2", "lavenderblush3",
  "lavenderblush4", "lawngreen", "lemonchiffon", "lemonchiffon1",
  "lemonchiffon2", "lemonchiffon3", "lemonchiffon4", "lightblue", "lightblue1",
  "lightblue2", "lightblue3", "lightblue4", "lightcoral", "lightcyan",
  "lightcyan1", "lightcyan2", "lightcyan3", "lightcyan4", "lightgoldenrod",
  "lightgoldenrod1", "lightgoldenrod2", "lightgoldenrod3", "lightgoldenrod4",
  "lightgoldenrodyellow", "lightgray", "lightgrey", "lightpink", "lightpink1",
  "lightpink2", "lightpink3", "lightpink4", "lightsalmon", "lightsalmon1",
  "lightsalmon2", "lightsalmon3", "lightsalmon4", "lightseagreen",
  "lightskyblue", "lightskyblue1", "lightskyblue2", "lightskyblue3",
  "lightskyblue4", "lightslateblue", "lightslategray", "lightslategrey",
  "lightsteelblue", "lightsteelblue1", "lightsteelblue2", "lightsteelblue3",
  "lightsteelblue4", "lightyellow", "lightyellow1", "lightyellow2",
  "lightyellow3", "lightyellow4", "limegreen", "linen", "magenta", "magenta1",
  "magenta2", "magenta3", "magenta4", "maroon", "maroon1", "maroon2",
  "maroon3", "maroon4", "mediumaquamarine", "mediumblue", "mediumorchid",
  "mediumorchid1", "mediumorchid2", "mediumorchid3", "mediumorchid4",
  "mediumpurple", "mediumpurple1", "mediumpurple2", "mediumpurple3",
  "mediumpurple4", "mediumseagreen", "mediumslateblue", "mediumspringgreen",
  "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream",
  "mistyrose", "mistyrose1", "mistyrose2", "mistyrose3", "mistyrose4",
  "moccasin", "navajowhite", "navajowhite1", "navajowhite2", "navajowhite3",
  "navajowhite4", "navy", "navyblue", "none", "oldlace", "olivedrab",
  "olivedrab1", "olivedrab2", "olivedrab3", "olivedrab4", "orange", "orange1",
  "orange2", "orange3", "orange4", "orangered", "orangered1", "orangered2",
  "orangered3", "orangered4", "orchid", "orchid1", "orchid2", "orchid3",
  "orchid4", "palegoldenrod", "palegreen", "palegreen1", "palegreen2",
  "palegreen3", "palegreen4", "paleturquoise", "paleturquoise1",
  "paleturquoise2", "paleturquoise3", "paleturquoise4", "palevioletred",
  "palevioletred1", "palevioletred2", "palevioletred3", "palevioletred4",
  "papayawhip", "peachpuff", "peachpuff1", "peachpuff2", "peachpuff3",
  "peachpuff4", "peru", "pink", "pink1", "pink2", "pink3", "pink4", "plum",
  "plum1", "plum2", "plum3", "plum4", "powderblue", "purple", "purple1",
  "purple2", "purple3", "purple4", "red", "red1", "red2", "red3", "red4",
  "rosybrown", "rosybrown1", "rosybrown2", "rosybrown3", "rosybrown4",
  "royalblue", "royalblue1", "royalblue2", "royalblue3", "royalblue4",
  "saddlebrown", "salmon", "salmon1", "salmon2", "salmon3", "salmon4",
  "sandybrown", "seagreen", "seagreen1", "seagreen2", "seagreen3", "seagreen4",
  "seashell", "seashell1", "seashell2", "seashell3", "seashell4", "sienna",
  "sienna1", "sienna2", "sienna3", "sienna4", "skyblue", "skyblue1",
  "skyblue2", "skyblue3", "skyblue4", "slateblue", "slateblue1", "slateblue2",
  "slateblue3", "slateblue4", "slategray", "slategray1", "slategray2",
  "slategray3", "slategray4", "slategrey", "snow", "snow1", "snow2", "snow3",
  "snow4", "springgreen", "springgreen1", "springgreen2", "springgreen3",
  "springgreen4", "steelblue", "steelblue1", "steelblue2", "steelblue3",
  "steelblue4", "tan", "tan1", "tan2", "tan3", "tan4", "thistle", "thistle1",
  "thistle2", "thistle3", "thistle4", "tomato", "tomato1", "tomato2",
  "tomato3", "tomato4", "transparent", "turquoise", "turquoise1", "turquoise2",
  "turquoise3", "turquoise4", "violet", "violetred", "violetred1",
  "violetred2", "violetred3", "violetred4", "wheat", "wheat1", "wheat2",
  "wheat3", "wheat4", "white", "whitesmoke", "yellow", "yellow1", "yellow2",
  "yellow3", "yellow4", "yellowgreen"]);

BindGlobal("GV_IsValidRGBColor",
function(str)
  local valid, i;

  valid := "0123456789ABCDEFabcdef";

  if Length(str) <> 7 or str[1] <> '#' then
    return false;
  fi;

  for i in [2 .. 7] do
    if not str[i] in valid then
      return false;
    fi;
  od;
  return true;
end);

# TODO make this an operation
InstallGlobalFunction(GV_IsValidColor,
c -> IsString(c) and (GV_IsValidRGBColor(c) or c in GV_ValidColorNames));

InstallGlobalFunction(GV_ErrorIfNotNodeColoring,
function(gv, colors)
  local N;
  N := GraphvizNumberOfNodes(gv);
  if Length(colors) <> N then
    ErrorFormatted(
        "the number of node colors must be the same as the number",
        " of nodes, expected {} but found {}", N, Length(colors));
  fi;
  Perform(colors, ErrorIfNotValidColor);
end);
