# The following tests rely on the Digraphs package and thus will only be run if it is loaded. 
# This behavior is defined in the testall.g file, but might be automated by the package extensions,
# see: https://github.com/gap-system/gap/issues/6082

# Fix adding of quotes to labels
gap> G := AsList(SymmetricGroup(3));
[ (), (2,3), (1,3), (1,3,2), (1,2,3), (1,2) ]
gap> D := Digraph(G, {x, y} -> x * y = y * x);
<immutable digraph with 6 vertices, 18 edges>
gap> SetDigraphVertexLabels(D, G);
gap> gv := GraphvizVertexLabelledGraph(D);
<graphviz graph "hgn" with 6 nodes and 6 edges>

#
gap> STOP_TEST("graphviz package: dot.tst", 0);