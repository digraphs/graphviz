#############################################################################
##
##  gv.gi
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# Code from the GAP standard library, repeated here so that the package works
# with GAP 4.11 since Pluralize was introduced to the GAP library in 4.12
if CompareVersionNumbers(GAPInfo.Version, "4.12") then
    InstallMethod(GV_Pluralize,
    "for an integer and a string",
    [IsInt, IsString], Pluralize);
else
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
fi;

###############################################################################
# Family + type
###############################################################################

BindGlobal("GV_MapType", NewType(GV_ObjectFamily,
                                 GV_IsMap and
                                 IsComponentObjectRep and
                                 IsAttributeStoringRep));

BindGlobal("GV_NodeType", NewType(GV_ObjectFamily,
                                    IsGraphvizNode and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GV_EdgeType", NewType(GV_ObjectFamily,
                                    IsGraphvizEdge and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

BindGlobal("GV_ContextType", NewType(GV_ObjectFamily,
                                    IsGraphvizContext and
                                    IsComponentObjectRep and
                                    IsAttributeStoringRep));

InstallMethod(\=, "for IsGraphvizNode and IsGraphvizNode",
[IsGraphvizNode, IsGraphvizNode],
{n1, n2} -> GraphvizName(n1) = GraphvizName(n2));

###############################################################################
# Constructors etc
###############################################################################

InstallMethod(GV_Map, "for no args",
[], {} -> Objectify(GV_MapType, rec(Data := rec())));

InstallMethod(GV_Node, "for a string",
[IsGraphvizGraphDigraphOrContext, IsString],
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
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode, IsGraphvizNode],
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
[IsGraphvizDigraph, IsString],
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
[IsGraphvizGraphDigraphOrContext, IsString],
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
[IsGraphvizGraphDigraphOrContext, IsString],
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

############################################################
# Graphviz Map Functions
############################################################

InstallMethod(\[\],
"for a graphviz map and a string",
[GV_IsMap, IsString],
function(m, o)
  if IsBound(m[o]) then
    return m!.Data.(o);
  fi;
  return fail;
end);

InstallMethod(\[\],
"for a graphviz map and an object",
[GV_IsMap, IsObject],
{m, o} -> m[String(o)]);

InstallMethod(\[\]\:\=,
"for a graphviz map and two objects",
[GV_IsMap, IsObject, IsObject],
function(m, key, val)
  m!.Data.(key) := val;
end);

InstallMethod(Unbind\[\],
"for a graphviz map and an object",
[GV_IsMap, IsObject],
function(m, key)
  Unbind(m!.Data.(key));
end);

InstallMethod(IsBound\[\],
"for a graphviz map and an object",
[GV_IsMap, IsObject],
{m, key} -> IsBound(m!.Data.(key)));

InstallMethod(GV_MapNames, "for a graphviz map",
[GV_IsMap], m -> RecNames(m!.Data));

InstallMethod(ViewObj, "for a graphviz map", [GV_IsMap],
function(m)
  ViewObj(m!.Data);
end);

InstallMethod(Size, "for a graphviz map",
[GV_IsMap], m -> Length(GV_MapNames(m)));

# ??

InstallMethod(GV_IncCounter,
"for a graphviz graph",
[IsGraphvizGraphDigraphOrContext],
function(x)
  x!.Counter := x!.Counter + 1;
end);

InstallMethod(GV_GetCounter, "for a graphviz graph",
[IsGraphvizGraphDigraphOrContext],
x -> x!.Counter);

# Nodes

InstallMethod(GV_HasNode,
"for a graphviz graph",
[IsGraphvizGraphDigraphOrContext, IsString],
{g, name} -> name in GV_MapNames(GraphvizNodes(g)));

InstallMethod(GV_GetParent,
"for a graphviz graph",
[IsGraphvizGraphDigraphOrContext], graph -> graph!.Parent);

InstallMethod(GV_GraphTreeSearch,
"for a graphviz graph and a predicate",
[IsGraphvizGraphDigraphOrContext, IsFunction],
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
    if not IsGraphvizGraphDigraphOrContext(parent) then
      continue;
    fi;
    if not ForAny(seen, s -> IsIdenticalObj(s, parent)) then
      Add(seen, parent);
      Add(to_visit, parent);
    fi;
  od;

  return fail;
end);

InstallMethod(GV_FindGraphWithNode,
"for a graphviz graph and a node",
[IsGraphvizGraphDigraphOrContext, IsString],
{g, n} -> GV_GraphTreeSearch(g, v -> v[n] <> fail));

InstallMethod(GV_GetRoot,
"for a graphviz graph",
[IsGraphvizGraphDigraphOrContext],
function(graph)
  while GV_GetParent(graph) <> fail do
    graph := GV_GetParent(graph);
  od;
  return graph;
end);

InstallMethod(GV_EnclosingNonContext,
"for a graphviz object with subobjects",
[IsGraphvizContext],
function(graph)
  local parent;

  repeat
    parent := GV_GetParent(graph);
  until parent = fail or not IsGraphvizContext(parent);
  return parent;
end);

InstallMethod(GV_FindNode,
"for a graphviz graph and a string",
[IsGraphvizGraphDigraphOrContext, IsString],
function(g, n)
  local graph;
  graph := GV_FindGraphWithNode(g, n);
  if graph = fail then
    return graph;
  fi;
  return graph[n];
end);

InstallMethod(GV_AddNode,
"for a graphviz graph and node",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode],
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

InstallMethod(GV_AddEdge,
"for a graphviz graph and edge",
[IsGraphvizGraphDigraphOrContext, IsGraphvizEdge],
function(x, edge)
  local head, head_name, tail_name, tail, hg, error, tg;

  head      := GraphvizHead(edge);
  tail      := GraphvizTail(edge);
  head_name := GraphvizName(head);
  tail_name := GraphvizName(tail);
  hg        := GV_FindGraphWithNode(x, head_name);
  tg        := GV_FindGraphWithNode(x, tail_name);

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

###############################################################################
# Stringifying
###############################################################################

# @ Return DOT graph head line.
InstallMethod(GV_StringifyGraphHead, "for a string",
[IsGraphvizGraphDigraphOrContext],
graph -> StringFormatted("graph {} {{\n", GraphvizName(graph)));

# @ Return DOT digraph head line.
InstallMethod(GV_StringifyDigraphHead, "for a string", [IsGraphvizDigraph],
graph -> StringFormatted("digraph {} {{\n", GraphvizName(graph)));

# @ Return DOT subgraph head line.
InstallMethod(GV_StringifySubgraphHead, "for a string",
[IsGraphvizGraphDigraphOrContext],
graph -> StringFormatted("subgraph {} {{\n", GraphvizName(graph)));

# @ Return DOT subgraph head line.
InstallMethod(GV_StringifyContextHead, "for a string", [IsGraphvizContext],
graph -> StringFormatted("// {} context \n", GraphvizName(graph)));

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
[IsGraphvizNode],
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
  Assert(0, IsGraphvizEdge(edge));
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
[IsGraphvizGraphDigraphOrContext],
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
[GV_IsMap],
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
          # TODO it doesn't seem to be possible to enter the if-statement
          # below, even with examples where the key contains spaces (probably
          # the quotes are added somewhere else). Either uncomment or delete
          # this code.
          # if ' ' in key then
          #   key := StringFormatted("\"{}\"", key);
          # fi;
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

InstallMethod(GV_GetIdx,
"for a graphviz object",
[IsGraphvizObject],
x -> x!.Idx);

InstallMethod(GV_ConstructHistory,
"for a graphviz graph",
[IsGraphvizGraphDigraphOrContext],
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
[IsGraphvizGraphDigraphOrContext, IsBool],
function(graph, is_subgraph)
  local result, obj;
  result := "";

  # get the correct head to use
  if is_subgraph then
    if IsGraphvizContext(graph) then
      Append(result, GV_StringifyContextHead(graph));
    else
      Append(result, GV_StringifySubgraphHead(graph));
    fi;
  elif IsGraphvizDigraph(graph) then
    Append(result, "//dot\n");
    Append(result, GV_StringifyDigraphHead(graph));
  elif IsGraphvizGraph(graph) then
    Append(result, "//dot\n");
    Append(result, GV_StringifyGraphHead(graph));
    # TODO doesn't seem to be possible to reach the case below either, uncomment
    # or delete
    # else
    #  Append(result, "//dot\n");
    #  Append(result, GV_StringifyContextHead(graph));
  fi;

  Append(result, GV_StringifyGraphAttrs(graph));

  # Add child graphviz objects
  for obj in GV_ConstructHistory(graph) do
    if IsGraphvizGraphDigraphOrContext(obj) then
      Append(result, GV_StringifyGraph(obj, true));
    elif IsGraphvizNode(obj) then
      Append(result, GV_StringifyNode(obj));
    elif IsGraphvizEdge(obj) then
      if IsGraphvizDigraph(GV_GetRoot(graph)) then
        Append(result, GV_StringifyEdge(obj, "->"));
      else
        Append(result, GV_StringifyEdge(obj, "--"));
      fi;
    fi;
  od;

  if IsGraphvizContext(graph) then
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

InstallGlobalFunction(GV_IsValidColor,
c -> IsString(c) and (GV_IsValidRGBColor(c) or c in GV_ValidColorNames));

InstallGlobalFunction(GV_ErrorIfNotNodeColoring,
function(gv, colors)
  local N;
  N := Size(GraphvizNodes(gv));
  if Length(colors) <> N then
    ErrorFormatted(
        "the number of node colors must be the same as the number",
        " of nodes, expected {} but found {}", N, Length(colors));
  fi;
  Perform(colors, ErrorIfNotValidColor);
end);
