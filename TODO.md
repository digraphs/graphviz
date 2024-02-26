 - save & load (potentially with 6-strings)
 - condense code in displaying defaults using the new graphviz pkg model
    - ex. all the symmetric vs not symmetric methods can be made a single method which chooses automatically relatively easily.
- Allow photos to be used as nodes & composition of graphviz output photos (later)

## TODO (ONCE THIS IS EMPTY THEN DONE!)
 - Make it so ':' is interpreted as a port if it is in a node name provided as a string to an edge, but not if it is in a node name provided a string to Add_Node()
 - Make it so adding a node by name to a graph fails if it exists in another child / parent / sibling graph, but if it is in this graph then it will reuse it automatically. 
 - update examples so that they all work 
 - pip install gaplint (linting gap)!
 - make it so when duplicates are added to global graph attrs the old values are automatically replaced
 - nail down behaviour for subgraphs digraphs with the same name 
 - add history for graph contructions (and order string output based on the history)
 - add attribute reseting after contexts
 - get subgraph by name
 - dont allow subgraphs and parent graphs to contain the same set of nodes
    - add nice error message where to find it
 - make sure all functions can take objects as well as strings

## Other
 - relates to deadnaut github issue https://www.mankier.com/1/nauty-dretodot
 - https://users.cecs.anu.edu.au/~bdm/nauty/nug26.pdf
