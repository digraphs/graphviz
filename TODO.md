 - improve docs
 - subgraphs
 - save & load (potentially with 6-strings)
 - condense code in displaying defaults using the new graphviz pkg model
    - ex. all the symmetric vs not symmetric methods can be made a single method which chooses automatically relatively easily.
- todo improve node name valdiation (ex. node-1 should not be a valid name)

## Meeting with James
- ask james about prefered behaviour for adding node with the same name as an existing node. Currently fails.
 - Test all example from the python graphviz docs.
 - GV_Attr(node, "");

 - Allow photos to be used as nodes & composition of graphviz output photos (later)
 - Sort edges before outputting (nondeterminim) ???
 - pip install gaplint (linting gap)!
 - make it so when duplicates are added to global graph attrs the old values are automatically replaced

## Done
 - Add function for adding attributes as just pairs
 - Replace global edge and node attrs with strings instead 
 - USE datastructures PACKAGE (hashmaps)
 - Sort nodes before outputting (nondeterminim)
 - Sort node / edge attrs before outputting (nondeterminim)
 - Pluralize
 - add declare operation `DeclareOperation("GV_Attr", [IsGVObject, IsObject, IsObject]);`
 - add declare operation `DeclareOperation("GV_Attr", [IsGVObject, IsString, IsObject]);`
    - GV_Attr(gv, "shape", "box");
    - GV_Attr(gv, "size", 1); // call string method on 1 automatically
 - scrap the constructors which take in a record.
 - access nodes by index
    - gv["a"]; // gv get node
 - update tests for displaying defaults

