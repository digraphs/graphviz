#############################################################################
##
##  display.gi
##  Copyright (C) 2014-21                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
# AN's code, adapted by WW

BindGlobal("GV_DIGRAPHS_DotDigraph",
function(D, node_funcs, edge_funcs)
  local out, nodes, tail, head, node, edge, graph, i, func, j, l;

  graph := GV_Graph("hgn");
  GV_Type(graph, GV_DIGRAPH);
  GV_NodeAttrs(graph, rec( shape := "circle"));

  for i in DigraphVertices(D) do
    node := GV_Node(StringFormatted("{}", i));
    GV_AddNode(graph, node);
    for func in node_funcs do
      func(graph, node);
    od;
  od;

  nodes := GV_Nodes(graph);
  out := OutNeighbours(D);
  for i in DigraphVertices(D) do
    l := Length(out[i]);
    for j in [1 .. l] do
      tail := nodes.(StringFormatted("{}", i));
      head := nodes.(StringFormatted("{}", out[i][j]));
      edge := GV_Edge(head, tail);
      GV_AddEdge(graph, edge);
      for func in edge_funcs do
        func(graph, edge);
      od;
    od;
  od;
  return graph;
end);

BindGlobal("GV_DIGRAPHS_ValidRGBValue",
function(str)
  local l, chars, x, i;
  l := Length(str);
  x := 0;
  chars := "0123456789ABCDEFabcdef";
  if l = 7 then
    if str[1] = '#' then
      for i in [2 .. l] do
        if str[i] in chars then
            x := x + 1;
        fi;
      od;
    fi;
  fi;
  if x = (l - 1) then
    return true;
  else
    return false;
  fi;
end);

BindGlobal("GV_DIGRAPHS_GraphvizColorsList", fail);

BindGlobal("GV_DIGRAPHS_GraphvizColors",
function()
  local f;
  if GV_DIGRAPHS_GraphvizColorsList = fail then
    f := IO_File(Concatenation(DIGRAPHS_Dir(), "/data/colors.p"));
    MakeReadWriteGlobal("GV_DIGRAPHS_GraphvizColorsList");
    GV_DIGRAPHS_GraphvizColorsList := IO_Unpickle(f);
    MakeReadOnlyGlobal("GV_DIGRAPHS_GraphvizColorsList");
    IO_Close(f);
  fi;
  return GV_DIGRAPHS_GraphvizColorsList;
end);

BindGlobal("GV_DIGRAPHS_ValidVertColors",
function(D, verts)
  local v, sum, colors, col;
  v := DigraphVertices(D);
  sum := 0;
  if Length(verts) <> Length(v) then
    ErrorNoReturn("the number of vertex colors must be the same as the number",
    " of vertices, expected ", Length(v), " but found ", Length(verts), "");
  fi;
  colors := GV_DIGRAPHS_GraphvizColors();
  if Length(verts) = Length(v) then
    for col in verts do
      if not IsString(col) then
        ErrorNoReturn("expected a string");
      elif GV_DIGRAPHS_ValidRGBValue(col) = false and
          (col in colors) = false then
        ErrorNoReturn("expected RGB Value or valid color name as defined",
        " by GraphViz 2.44.1 X11 Color Scheme",
        " http://graphviz.org/doc/info/colors.html");
      else
        sum := sum + 1;
      fi;
    od;
    if sum = Length(verts) then
      return true;
    fi;
  fi;
end);

BindGlobal("GV_DIGRAPHS_ValidEdgeColors",
function(D, edge)
  local out, l, counter, sum, colors, v, col;
  out := OutNeighbours(D);
  l := Length(edge);
  counter := 0;
  sum := 0;
  colors := GV_DIGRAPHS_GraphvizColors();
  if Length(edge) <> Length(out) then
    ErrorNoReturn("the list of edge colors needs to have the",
    " same shape as the out-neighbours of the digraph");
  else
    for v in [1 .. l] do
      sum := 0;
      if Length(out[v]) <> Length(edge[v]) then
        ErrorNoReturn("the list of edge colors needs to have the",
        " same shape as the out-neighbours of the digraph");
      else
        for col in edge[v] do
          if not IsString(col) then
            ErrorNoReturn("expected a string");
          elif GV_DIGRAPHS_ValidRGBValue(col) = false and
              (col in colors) = false then
            ErrorNoReturn("expected RGB Value or valid color name as defined",
            " by GraphViz 2.44.1 X11 Color Scheme",
            " http://graphviz.org/doc/info/colors.html");
          else
            sum := sum + 1;
          fi;
        od;
        if sum = Length(edge[v]) then
          counter := counter + 1;
        fi;
      fi;
    od;
    if counter = Length(edge) then
      return true;
    fi;
  fi;
end);

InstallMethod(GV_DotDigraph, "for a digraph by out-neighbours",
[IsDigraphByOutNeighboursRep],
D -> GV_DIGRAPHS_DotDigraph(D, [], []));
