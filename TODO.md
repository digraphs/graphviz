 - subgraphs
 - save & load (potentially with 6-strings)
 - condense code in displaying defaults using the new graphviz pkg model
    - ex. all the symmetric vs not symmetric methods can be made a single method which chooses automatically relatively easily.
- for node/edge removal from subgraphs do you think it is better to remove the node from the parent if it is removed from the subgraph, or just to remove it from the subgraph. I Chose the latter for now as it seemed nicer - gives the user more fine grained control.

## TODO
 - write tests for the ":" synatx stuff / come up with good solution for having ':' in names.
 - ask james about prefered behaviour for adding node with the same name as an existing node. Currently fails.
 - Finish exmaples python graphviz docs.
 - GV_Attr(node, "");
 - Allow photos to be used as nodes & composition of graphviz output photos (later)
 - pip install gaplint (linting gap)!
 - make it so when duplicates are added to global graph attrs the old values are automatically replaced
