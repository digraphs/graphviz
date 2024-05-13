#############################################################################
##
##  dot.gi
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#############################################################################
# Private functionality
#############################################################################

BindGlobal("NumberOfSubstrings",
function(string, substring)
  local pos, count;

  pos := 0;
  count := 0;
  while pos <= Length(string) and pos <> fail do
    pos := PositionSublist(string, substring, pos);
    if pos <> fail then
      count := count + 1;
    fi;
  od;
  return count;
end);

InstallGlobalFunction(ErrorFormatted,
function(arg...)
  local pos, fmt, n, msg;

  pos := PositionProperty(arg, x -> not IsString(x));
  if pos = fail then
    pos := Length(arg) + 1;
  fi;
  fmt := Concatenation(arg{[1 .. pos - 1]});
  n := NumberOfSubstrings(fmt, "{}");
  arg := Concatenation([Concatenation(arg{[1 .. Length(arg) - n]})],
                       arg{[Length(arg) - n + 1 .. Length(arg)]});
  msg := CallFuncList(StringFormatted, arg);
  # RemoveCharacters(msg, "\\\n");
  ErrorInner(
      rec(context := ParentLVars(GetCurrentLVars()),
          mayReturnVoid := false,
          mayReturnObj := false,
          lateMessage := "type 'quit;' to quit to outer loop",
          printThisStatement := false),
      [msg]);
end);

DeclareOperation("GV_GetCounter", [IsGVGraph]);
DeclareOperation("GV_IncCounter", [IsGVGraph]);
DeclareCategory("IsGV_Map", IsObject);
DeclareAttribute("Size", IsGV_Map);

DeclareOperation("GV_StringifyGraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifyDigraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifySubgraphHead", [IsGVGraph]);
DeclareOperation("GV_StringifyContextHead", [IsGVGraph]);
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
###############################################################################

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

InstallMethod(\=, "for IsGVNode and IsGVNode",
[IsGVNode, IsGVNode],
{n1, n2} -> GraphvizName(n1) = GraphvizName(n2));

###############################################################################
# Constructors etc
###############################################################################

DeclareOperation("GV_Node", [IsGVGraph, IsString]);
DeclareOperation("GV_Edge", [IsGVGraph, IsGVNode, IsGVNode]);
DeclareOperation("GV_Graph", [IsGVGraph, IsString]);
DeclareOperation("GV_Digraph", [IsGVDigraph, IsString]);
DeclareOperation("GV_Context", [IsGVGraph, IsString]);
DeclareOperation("GV_Map", []);

InstallMethod(GV_Map, "for no args",
[], {} -> Objectify(GV_MapType, rec(Data := rec())));

InstallMethod(GV_Node, "for a string",
[IsGVGraph, IsString],
function(graph, name)
  local out;
  if Length(name) = 0 then
    ErrorNoReturn("the 2nd argument (string/node name) cannot be empty");
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
{m, key} -> IsBound(m!.Data.(key)));

DeclareOperation("GV_MapNames", [IsGV_Map]);

InstallMethod(GV_MapNames, "for a graphviz map",
[IsGV_Map], m -> RecNames(m!.Data));

InstallMethod(ViewString, "for a graphviz map", [IsGV_Map],
m -> String(m!.Data));

InstallMethod(Size, "for a graphviz map",
[IsGV_Map], m -> Length(GV_MapNames(m)));

############################################################
# Stringify
############################################################

InstallMethod(ViewString, "for a graphviz node", [IsGVNode],
n -> StringFormatted("<graphviz node {}>", GraphvizName(n)));

InstallMethod(ViewString, "for a graphviz edge", [IsGVEdge],
function(e)
  local head, tail;
  head := GraphvizHead(e);
  tail := GraphvizTail(e);
  return StringFormatted("<graphviz edge ({}, {})>",
                         GraphvizName(head),
                         GraphvizName(tail));
end);

InstallMethod(ViewString, "for a graphviz graph", [IsGVGraph],
function(g)
  local result, edges, nodes, kind;

  result := "";
  edges  := Length(GraphvizEdges(g));
  nodes  := 0;

  GV_GraphTreeSearch(g, function(s)
    nodes := nodes + Length(GV_MapNames(GraphvizNodes(s)));
    return false;
  end);

  if IsGVDigraph(g) then
    kind := "digraph";
  elif IsGVContext(g) then
    kind := "context";
  else
    kind := "graph";
  fi;

  Append(result, StringFormatted("<graphviz {} ", kind));

  if GraphvizName(g) <> "" then
    Append(result, StringFormatted("{} ", GraphvizName(g)));
  fi;

  Append(result, StringFormatted("with {} ", GV_Pluralize(nodes, "node")));
  Append(result, StringFormatted("and {}>", GV_Pluralize(edges, "edge")));

  return result;
end);

############################################################
# Getters
############################################################

InstallMethod(GraphvizName, "for a graphviz object", [IsGVObject], x -> x!.Name);

InstallMethod(GraphvizAttrs, "for a graphviz object", [IsGVObject],
x -> x!.Attrs);

# TODO remove, the returned value is mutable, looks like a record but isn't
# one. Mutability is a problem, since if we do GraphvizNodes(gv)[1] := 2; then
# the object is corrupt.
InstallMethod(GraphvizNodes, "for a graphviz graph", [IsGVGraph],
x -> x!.Nodes);

InstallMethod(GraphvizNode, "for a graphviz graph and object",
[IsGVGraph, IsObject], {gv, obj} -> gv!.Nodes[String(obj)]);

# TODO remove for the same reason as GraphvizNodes, unless we can make the list
# immutable or return a copy.
InstallMethod(GraphvizEdges, "for a graphviz graph",
[IsGVGraph], x -> x!.Edges);

InstallMethod(GraphvizEdges,
"for a graphviz graph, object, and object",
[IsGVGraph, IsObject, IsObject],
function(gv, head, tail)
    head := GraphvizNode(gv, head);
    tail := GraphvizNode(gv, tail);
    # TODO if head = fail then...
    return Filtered(GraphvizEdges(gv), x -> GraphvizHead(x) = head and
    GraphvizTail(x) = tail);
end);

InstallMethod(GraphvizSubgraphs, "for a graphviz graph", [IsGVGraph],
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

InstallMethod(GV_GetCounter, "for a graphviz graph", [IsGVGraph],
x -> x!.Counter);

# Converting strings

DeclareOperation("GV_EnsureString", [IsObject]);
# TODO required? Replace with AsString
InstallMethod(GV_EnsureString,
"for an object",
[IsObject], ViewString);

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
{graph, node} -> GraphvizNodes(graph)[node]);

InstallOtherMethod(\[\],
"for a graphviz graph and string",
[IsGVGraph, IsObject],
{g, o} -> g[ViewString(o)]);

DeclareOperation("GV_HasNode", [IsGVGraph, IsObject]);

InstallMethod(GV_HasNode,
"for a graphviz graph",
[IsGVGraph, IsString],
{g, name} -> name in GV_MapNames(GraphvizNodes(g)));

DeclareOperation("GV_GetParent", [IsGVGraph]);

InstallMethod(GV_GetParent,
"for a graphviz graph",
[IsGVGraph], graph -> graph!.Parent);

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

############################################################
# Setters
############################################################

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
  local msg;

  if not name in GV_KNOWN_ATTRS then
    msg := Concatenation(
           StringFormatted("unknown attribute \"{}\", the", name),
           " graphviz object may no longer be valid, it can",
           " be removed using GraphvizRemoveAttr");
    Info(InfoWarning, 1, msg);
  fi;
  GraphvizAttrs(x)[String(name)] := String(value);
  return x;
end);

InstallMethod(GraphvizSetAttr, "for a graphviz graph, object and object",
[IsGVGraph, IsObject, IsObject],
function(x, name, value)
  local attrs, string, msg;

  if not name in GV_KNOWN_ATTRS then
    msg := Concatenation(
           StringFormatted("unknown attribute \"{}\", the", name),
           " graphviz object may no longer be valid, it can",
           " be removed using GraphvizRemoveAttr");
    Info(InfoWarning, 1, msg);
  fi;

  attrs := GraphvizAttrs(x);
  name := String(name);
  value := String(value);
  if ' ' in name then
    name := StringFormatted("\"{}\"", name);
  fi;
  if ' ' in value then
    value := StringFormatted("\"{}\"", value);
  fi;

  string := StringFormatted("{}={}", name, value);
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
    ErrorNoReturn(StringFormatted(error, name, GraphvizName(found)));
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

# TODO required?
InstallMethod(GraphvizAddNode, "for a graphviz graph and string",
[IsGVGraph, IsGVNode],
function(_, __)  # gaplint: disable=analyse-lvars
  local error;
  error := "Cannot add node objects directly to graphs. ";
  error := Concatenation(error, "Please use the node's name.");
  ErrorNoReturn(error);
end);

InstallMethod(GraphvizAddNode,
"for a graphviz graph and string",
[IsGVGraph, IsObject],
{x, name} -> GraphvizAddNode(x, ViewString(name)));

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
    # TODO improve
    ErrorFormatted("Different node in graph {} with name {}",
                   GraphvizName(hg),
                   head_name);
  fi;
  if tg <> fail and not IsIdenticalObj(tail, tg[tail_name]) then
    # TODO improve
    error := "Different node in graph {} with name {}.";
    ErrorNoReturn(StringFormatted(error,
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
    ErrorNoReturn(StringFormatted(error, name));
  fi;

  if IsGVDigraph(graph) then
    subgraph := GV_Digraph(graph, name);
  elif IsGVGraph(graph) then
    subgraph := GV_Graph(graph, name);
  else
    ErrorNoReturn("Filter must be a filter for a graph category.");
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
    ErrorNoReturn(StringFormatted(error, name));
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
{g, node} -> GraphvizRemoveNode(g, GraphvizName(node)));

# TODO GraphvizRemoveEdges(gv, n1, n2)

InstallMethod(GraphvizRemoveNode, "for a graphviz graph and a string",
[IsGVGraph, IsString],
function(g, name)
  local nodes;
  # TODO error if there's no such node
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
graph -> StringFormatted("graph {} {{\n", GraphvizName(graph)));

# @ Return DOT digraph head line.
InstallMethod(GV_StringifyDigraphHead, "for a string", [IsGVDigraph],
graph -> StringFormatted("digraph {} {{\n", GraphvizName(graph)));

# @ Return DOT subgraph head line.
InstallMethod(GV_StringifySubgraphHead, "for a string", [IsGVGraph],
graph -> StringFormatted("subgraph {} {{\n", GraphvizName(graph)));

# @ Return DOT subgraph head line.
InstallMethod(GV_StringifyContextHead, "for a string", [IsGVContext],
graph -> StringFormatted("// {} context \n", GraphvizName(graph)));

BindGlobal("GV_StringifyNodeName",
function(node)
  local name, old;

  Assert(0, IsGVNode(node));
  name  := GraphvizName(node);
  if (ForAny("- .+", x -> x in name)
      or (IsDigitChar(First(name)) and IsAlphaChar(Last(name))))
      and not StartsWith(name, "\"") then
    old  := name;
    name := StringFormatted("\"{}\"", name);
    Info(InfoWarning,
         1,
         "invalid node name ",
         old,
         " using ",
         name,
         " instead");
  fi;
  return name;
end);

# @ Return DOT node statement line.
InstallMethod(GV_StringifyNode, "for string and record",
[IsGVNode],
function(node)
  local name, attrs;
  name  := GV_StringifyNodeName(node);
  attrs := GraphvizAttrs(node);
  return StringFormatted("\t{}{}\n", name, GV_StringifyNodeEdgeAttrs(attrs));
end);

# @ Return DOT graph edge statement line.
BindGlobal("GV_StringifyEdge",
function(edge, edge_str)
  local head, tail, attrs;
  Assert(0, IsGVEdge(edge));
  Assert(0, IsString(edge_str));
  head  := GV_StringifyNodeName(GraphvizHead(edge));
  tail  := GV_StringifyNodeName(GraphvizTail(edge));
  attrs := GraphvizAttrs(edge);

  # handle : syntax
  return StringFormatted("\t{} {} {}{}\n",
                         head,
                         edge_str,
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
"for a GV_Map",
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
          if ' ' in val or '>' in val or '^' in val or '#' in val then
              # TODO avoid code duplication here, and below
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
        if ' ' in val or '>' in val or '^' in val or '#' in val then
          # TODO what are the allowed things in the value?
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
  local result, obj;
  result := "";

  # get the correct head to use
  if is_subgraph then
    if IsGVContext(graph) then
      Append(result, GV_StringifyContextHead(graph));
    elif IsGVGraph(graph) or IsGVDigraph(graph) then
      Append(result, GV_StringifySubgraphHead(graph));
    else
      ErrorNoReturn("Invalid subgraph type.");
    fi;
  elif IsGVDigraph(graph) then
    Append(result, "//dot\n");
    Append(result, GV_StringifyDigraphHead(graph));
  elif IsGVGraph(graph) then
    Append(result, "//dot\n");
    Append(result, GV_StringifyGraphHead(graph));
  elif IsGVContext(graph) then
    Append(result, "//dot\n");
    Append(result, GV_StringifyContextHead(graph));
  else
    ErrorNoReturn("Invalid graph type.");
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
        Append(result, GV_StringifyEdge(obj, "->"));
      else
        Append(result, GV_StringifyEdge(obj, "--"));
      fi;
    else
      ErrorNoReturn("Invalid graphviz object type.");
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
graph -> GV_StringifyGraph(graph, false));

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

BindGlobal("GV_IsValidColor",
c -> IsString(c) and (GV_IsValidRGBColor(c) or c in GV_ValidColorNames));

BindGlobal("GV_ErrorIfNotValidColor",
function(c)
  if not GV_IsValidColor(c) then
    if IsString(c) then
      c := StringFormatted("\"{}\"", c);
    fi;
    ErrorFormatted("invalid color {} ({}), ",
        "valid colors are RGB values or names from ",
        "the GraphViz 2.44.1 X11 Color Scheme",
        " http://graphviz.org/doc/info/colors.html",
        c,
        TNAM_OBJ(c));
  fi;
end);

BindGlobal("GV_ErrorIfNotNodeColoring",
function(gv, colors)
  local N;
  N := Size(GraphvizNodes(gv));
  if Length(colors) <> N then
    ErrorFormatted(
        "the number of node colors must be the same as the number",
        " of nodes, expected {} but found {}", N, Length(colors));
  fi;
  Perform(colors, GV_ErrorIfNotValidColor);
end);

InstallMethod(GraphvizSetNodeLabels,
"for a graphviz graph and list of colors",
[IsGVGraph, IsList],
function(gv, labels)
  local nodes, i;
  # TODO error if labels and nodes aren't same size
  # TODO GV_ErrorIfNotValidLabel
  nodes := GraphvizNodes(gv);
  for i in [1 .. Size(nodes)] do
    GraphvizSetAttr(nodes[i], "label", labels[i]);
  od;
  return gv;
end);

InstallMethod(GraphvizSetNodeColors,
"for a graphviz graph and list of colors",
[IsGVGraph, IsList],
function(gv, colors)
  local nodes, i;

  GV_ErrorIfNotNodeColoring(gv, colors);

  nodes := GraphvizNodes(gv);

  for i in [1 .. Size(nodes)] do
    GraphvizSetAttr(nodes[i], "color", colors[i]);
    GraphvizSetAttr(nodes[i], "style", "filled");
  od;
  return gv;
end);
