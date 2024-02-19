# #! @Chapter 2
# #! @ChapterTitle Automatic Digraph Converters
# #! This chapter covers operations for automatically converting from digrpahs to graphviz objects.

# #! @Section Digraph to Graphviz Conversion Operations

# #! @Arguments digraph
# #! @Returns the graphviz representation of the digraph. 
# #! @Description Converts a digraph to it's graphviz representation. 
# DeclareOperation("GV_DotDigraph", [IsDigraph]);

# #! @Arguments digraph, vertex_colors, edge_colors
# #! @Returns the graphviz representation of the digraph with the provided colors. 
# #! @Description Converts a digraph to it's graphviz representation and colors 
# #! the edges and verticies using the colors provided.
# DeclareOperation("GV_DotColoredDigraph", [IsDigraph, IsList, IsList]);

# #! @Arguments digraph, vertex_colors
# #! @Returns the graphviz representation of the digraph. 
# #! @Description Converts a digraph to it's graphviz representation 
# #! and colors it's verticies with it's provided vertex colors.
# DeclareOperation("GV_DotVertexColoredDigraph", [IsDigraph, IsList]);

# #! @Arguments digraph, vertex_colors
# #! @Returns the graphviz representation of the digraph. 
# #! @Description Converts a digraph to it's graphviz representation 
# #! and colors it's edges with the provided edge colors.
# DeclareOperation("GV_DotEdgeColoredDigraph", [IsDigraph, IsList]);

# #! @Arguments digraph, labels
# #! @Returns the graphviz representation of the digraph. 
# #! @Description Converts a digraph to it's graphviz representation 
# #! and labels it's vertices with the provided labels.
# DeclareOperation("GV_DotVertexLabelledDigraph", [IsDigraph]);

# #! @Arguments graph
# #! @Returns the graphviz representation of the graph. 
# #! @Description Converts a graph to it's graphviz representation.
# DeclareAttribute("GV_DotSymmetricDigraph", IsDigraph);

# #! @Arguments graph, vertex_colors, edge_colors
# #! @Returns the graphviz representation of the graph with the provided colors. 
# #! @Description Converts a graph to it's graphviz representation and colors 
# #! the edges and verticies using the colors provided.
# DeclareOperation("GV_DotSymmetricColoredDigraph", [IsDigraph, IsList, IsList]);

# #! @Arguments graph, vertex_colors
# #! @Returns the graphviz representation of the graph. 
# #! @Description Converts a graph to it's graphviz representation 
# #! and colors it's verticies with it's provided vertex colors.
# DeclareOperation("GV_DotSymmetricVertexColoredDigraph", [IsDigraph, IsList]);

# #! @Arguments graph, vertex_colors
# #! @Returns the graphviz representation of the graph. 
# #! @Description Converts a graph to it's graphviz representation 
# #! and colors it's edges with the provided edge colors.
# DeclareOperation("GV_DotSymmetricEdgeColoredDigraph", [IsDigraph, IsList]);

# #! @Arguments digraph, vertex_colors
# #! @Returns the graphviz representation of a partial order digraph. 
# #! @Description Converts a partial order digraph to it's graphviz representation 
# DeclareOperation("GV_DotPartialOrderDigraph", [IsDigraph]);

# #! @Arguments digraph
# #! @Returns the graphviz representation of a preorder digraph. 
# #! @Description Converts a preorder digraph to it's graphviz representation 
# DeclareAttribute("GV_DotPreorderDigraph", IsDigraph);

# # TODO GAP AUTODOC DOES NOT HAVE SUPPORT FOR SYNONYMS - ASK SUPERVISORS
# # CURRENT IDEA IS TO MODIFY THE AUTODOC CODE TO DO IT - HAVE BASIC VERSION
# # BUT NEEDS WORK!
# DeclareSynonym("GV_DotQuasiorderDigraph", DotPreorderDigraph);

# #! @Arguments digraph, hight_verts
# #! @Returns the graphviz representation of a digraph with the 
# #! highlighted verticies in black and the others in grey. 
# #! @Description Converts a highlighted digraph to it's graphviz representation 
# DeclareOperation("GV_DotHighlightedDigraph", [IsDigraph, IsList]);

# #! @Arguments digraph, hight_verts, hight_color, low_color
# #! @Returns the graphviz representation of a digraph with the 
# #! highlighted verticies in the high_color and the others in the low_color. 
# #! @Description Converts a highlighted digraph to it's graphviz representation 
# DeclareOperation("GV_DotHighlightedDigraph", [IsDigraph, IsList, IsString, IsString]);

# #! @Arguments digraph, record
# #! @Description displays the provided graphviz graph, configured with options from the record. 
# DeclareOperation("GV_Splash", [IsGVGraph, IsRecord]);