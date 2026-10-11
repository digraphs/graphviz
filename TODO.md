# Status log

## 2026-10-02

During GAPDays 2026 the graphviz working group made the following contributions

- There have been various improvements to the package infrastructure,
  improvements to CI, Makefile, PackageInfo
- The docs have been improved, there are now more examples, the readme now
  renders all its pictures correctly
- The splash function has been improved, we fixed an error relating to
  output directory creation, better error messages
- Started improving the internals and aligning it more closely with user
  expectations

Need to do:

- Make the behavior of function match user expectations more
  - e.g. GraphvizNodes returning all nodes belonging to subgraphs too
  - Setting attrs applying to the correct contexts
- Overhaul the internals to simplify functionality
  (there are parts of code that assume the hierarchy is not a tree when it is)
- Add better attribute handling
- Add missing core functionality
  - Vertex and edge coloring
  - Better html support
- Add html handling, use this to improve quotation
- Big documentation pass
- Big test pass

# Old todos

- save & load (potentially with 6-strings)
 - condense code in displaying defaults using the new graphviz pkg model
    - ex. all the symmetric vs not symmetric methods can be made a single method which chooses automatically relatively easily.
 - Allow photos to be used as nodes & composition of graphviz output photos (later)
 - Make an abstraction - find in subgraph tree - which does a traversal of the tree of subgraphs to find a graph satisfying a predicate.
 - Make custom resolution of edges for FDP (see fdp example from the python package)
 - implement the fdp example from the python package
 - make it so when duplicates are added to global graph attrs the old values are automatically replaced
 - Improve behaviour around ':' syntax - mimic python package

## TODO
 - Update docs
 - Add more unit tests
 - Thoroughly test the ':' syntax more (might have broke when the quotes were changed)
 - PrintObj method is missing for nodes (and probably edges)

## Other
 - relates to deadnaut github issue https://www.mankier.com/1/nauty-dretodot
 - https://users.cecs.anu.edu.au/~bdm/nauty/nug26.pdf
