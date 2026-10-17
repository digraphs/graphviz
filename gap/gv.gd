#############################################################################
##
##  gv.gd
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

## This file contains declarations of the internal/private functions for the
## graphviz package.

DeclareOperation("GV_GetCounter", [IsGraphvizGraphDigraphOrContext]);

DeclareOperation("GV_StringifyGraph",
                 [IsGraphvizGraphDigraphOrContext, IsBool]);

DeclareOperation("GV_Node", [IsGraphvizGraphDigraphOrContext, IsString]);
DeclareOperation("GV_Edge",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode, IsGraphvizNode]);
DeclareOperation("GV_GraphOrDigraph", [IsString, IsFunction]);
DeclareAttribute("GV_Filter", IsGraphvizGraph);
DeclareAttribute("GV_Filter", IsGraphvizDigraph);
DeclareOperation("GV_Subgraph", [IsGraphvizGraphDigraphOrContext, IsString]);
DeclareOperation("GV_Context", [IsGraphvizGraphDigraphOrContext, IsString]);

DeclareOperation("GV_GetParent", [IsGraphvizObject]);
DeclareOperation("GV_GraphTreeSearch",
[IsGraphvizGraphDigraphOrContext, IsFunction]);
DeclareOperation("GV_GraphSearchChildren",
[IsGraphvizGraphDigraphOrContext, IsFunction]);
DeclareOperation("GV_FindGraphWithNode",
[IsGraphvizGraphDigraphOrContext, IsString]);
DeclareOperation("GV_GetRoot", [IsGraphvizObject]);
DeclareOperation("GV_AddNode",
[IsGraphvizGraphDigraphOrContext, IsGraphvizNode]);
DeclareOperation("GV_AddEdge",
[IsGraphvizGraphDigraphOrContext, IsGraphvizEdge]);

DeclareGlobalFunction("GV_IsValidColor");
DeclareOperation("GV_ErrorIfNotNodeColoring", [IsGraphvizObject, IsList]);
