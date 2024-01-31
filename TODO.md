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