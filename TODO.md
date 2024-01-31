 - improve docs
 - subgraphs
 - save & load (potentially with 6-strings)
 - update tests for displaying defaults
 - condense code in displaying defaults using the new graphviz pkg model
    - ex. all the symmetric vs not symmetric methods can be made a single method which chooses automatically relatively easily.
 - add nicer shorthands for other methods. Eg. 
 ```gap
 GV_Edge(IsString, IsString) # creates an edge between two new nodes w/ the provided name strings
 GV_AddEdge(IsGVGraph, IsString, IsString) # creates an edge between two new nodes w/ the provided name strings and adds it to the graph
 ```

## Meeting with James
 - Add function for adding attributes as just pairs / list of pairs 
   - Use datatrsuctures package
 - GV_Attr(gv, "shape", "box");
 - GV_Attr(gv, "size", 1); // call string method on 1 automatically
 - gv["a"]; // gv get node
 - GV_Attr(node, "");

 - node name to index in node list

 - remove ability to convert from digraph to graph and vice versa
   - declare attribute

 - scrap the constructors which take in a record.
 - add declare operation `DeclareOperation("GV_Attr", [IsGVObject, IsObject, IsObject]);`
 - add declare operation `DeclareOperation("GV_Attr", [IsGVObject, IsString, IsObject]);`

 - pip install gaplint (linting gap)!
 - USE datastructures PACKAGE 
 - Sort nodes before outputting (nondeterminim)
 - Allow photos to be used as nodes & composition of graphviz output photos (later)
 - Replace edge and node attrs with strings instead 

 - Pluralize
