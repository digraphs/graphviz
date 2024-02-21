 - subgraphs
 - save & load (potentially with 6-strings)
 - condense code in displaying defaults using the new graphviz pkg model
    - ex. all the symmetric vs not symmetric methods can be made a single method which chooses automatically relatively easily.
- for node/edge removal from subgraphs do you think it is better to remove the node from the parent if it is removed from the subgraph, or just to remove it from the subgraph. I Chose the latter for now as it seemed nicer - gives the user more fine grained control.

## TODO (ONCE THIS IS EMPTY THEN DONE!)
 - write tests for the ":" synatx stuff / come up with good solution for having ':' in names.
    - as long as consistent okay
 - ask james about prefered behaviour for adding node with the same name as an existing node. Currently fails.
 - Finish exmaples python graphviz docs.
 - GV_Attr(node, "");
 - Allow photos to be used as nodes & composition of graphviz output photos (later)
 - pip install gaplint (linting gap)!
 - keep removal at the level of the individual graph / subgraph
 - make it so when duplicates are added to global graph attrs the old values are automatically replaced
 - Should the parent graph have the child nodes in its node list even if it was not directly added to the parent?
 - nail down behaviour for subgraphs digraphs with the same name 
 - DO add history for graph contructions
 - make it so a graph cannot be a subgraph of a digraph and vice-versa
 - add attribute reseting after contexts
 - associate indicies  / do in order
 - run gaplint ASAP
 - get subgraph by name
 - dont allow subgraphs and graphs to contain the same set of nodes
    - add nice error message where to find it
 - make adding nodes and edges as object private.
 - make sure all functions can take objects as well as strings

## Other
 - relates to deadnaut github issue https://www.mankier.com/1/nauty-dretodot
 - https://users.cecs.anu.edu.au/~bdm/nauty/nug26.pdf