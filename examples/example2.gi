LoadPackage("graphviz");;
gr := DigraphDisjointUnion(CompleteDigraph(10),
                            CompleteDigraph(5),
                            CycleDigraph(2));;
gr := DigraphReflexiveTransitiveClosure(DigraphAddEdge(gr, [10, 11]));;
g := GV_DotPreorderDigraph(gr);;
Print(GV_String(g));
GV_Splash(g, rec(type := "dot"));
