#! @Chapter 2
#! @ChapterTitle Automatic Digraph Converters
#! This chapter covers operations for automatically converting from digrpahs to graphviz objects.

#! @Section Digraph to Graphviz Conversion Operations

#! @Arguments digraph
#! @Returns the graphviz representation of the digraph. 
#! @Description Converts a digraph to it's graphviz representation. 
DeclareOperation("GV_DotDigraph", [IsDigraph]);

#! @Arguments digraph, vertex_colors, edge_colors
#! @Returns the graphviz representation of the digraph with the provided colors. 
#! @Description Converts a digraph to it's graphviz representation and colors 
#! the edges and verticies using the colors provided.
DeclareOperation("GV_DotColoredDigraph", [IsDigraph, IsList, IsList]);

#! @Arguments digraph, vertex_colors
#! @Returns the graphviz representation of the digraph. 
#! @Description Converts a digraph to it's graphviz representation 
#! and colors it's verticies with it's provided vertex colors.
DeclareOperation("GV_DotVertexColoredDigraph", [IsDigraph, IsList]);

#! @Arguments digraph, vertex_colors
#! @Returns the graphviz representation of the digraph. 
#! @Description Converts a digraph to it's graphviz representation 
#! and colors it's edges with the provided edge colors.
DeclareOperation("GV_DotEdgeColoredDigraph", [IsDigraph, IsList]);

#! @Arguments digraph, labels
#! @Returns the graphviz representation of the digraph. 
#! @Description Converts a digraph to it's graphviz representation 
#! and labels it's vertices with the provided labels.
DeclareOperation("GV_DotVertexLabelledDigraph", [IsDigraph]);

DeclareAttribute("GV_DotSymmetricDigraph", IsDigraph);
DeclareOperation("GV_DotSymmetricColoredDigraph", [IsDigraph, IsList, IsList]);
DeclareOperation("GV_DotSymmetricVertexColoredDigraph", [IsDigraph, IsList]);
DeclareOperation("GV_DotSymmetricEdgeColoredDigraph", [IsDigraph, IsList]);
DeclareAttribute("GV_DotPartialOrderDigraph", IsDigraph);
DeclareAttribute("GV_DotPreorderDigraph", IsDigraph);
DeclareSynonym("GV_DotQuasiorderDigraph", DotPreorderDigraph);
DeclareOperation("GV_DotHighlightedDigraph", [IsDigraph, IsList]);
DeclareOperation("GV_DotHighlightedDigraph", [IsDigraph, IsList, IsString, IsString]);
