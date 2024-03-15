 - save & load (potentially with 6-strings)
 - condense code in displaying defaults using the new graphviz pkg model
    - ex. all the symmetric vs not symmetric methods can be made a single method which chooses automatically relatively easily.
 - Allow photos to be used as nodes & composition of graphviz output photos (later)
 - Make an abstraction - find in subgraph tree - which does a traversal of the tree of subgraphs to find a graph satisfying a predicate.
 - Make custom resolution of edges for FDP (see fdp example from the python package)
 - implement the fdp example from the python package
 - make it so when duplicates are added to global graph attrs the old values are automatically replaced
 - Improve behaviour arround ':' synatx - mimic python package

## TODO (ONCE THIS IS EMPTY THEN DONE!)
 - Fix gaplint whitespace / small formatting complaints
 - Add shortcut functions (GV_SetColor, Set_Label)
 - Add replace Graphviz... instead of GV_... for external things
 - Fix node name implementation. (AddNode(node) -> node name is <node c>)
 - Make previous existing digraphs to dot functions return string and add ones which return graphviz objects Graphviz...
 - Make splash keep name splash and if the object given is GVObject then splash the string of the object (no intermediate)
 - Switch HashMaps back to records
 - Add warnings for non-recognized attributes
 - Add (Graphviz [IsObject]) decl which dependent packages implement use 
    - Add validation on quoted input

## Other
 - relates to deadnaut github issue https://www.mankier.com/1/nauty-dretodot
 - https://users.cecs.anu.edu.au/~bdm/nauty/nug26.pdf
