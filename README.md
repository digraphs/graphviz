## README

### Graphviz package for GAP

#### Copyright (C) 2024 by J. D. Mitchell and M. Pancer

## Graphviz for GAP

This package facilitates the creation and rendering of graph
descriptions in the [DOT][] language of the [Graphviz][] graph drawing
software from [GAP][].

You can create a graphviz object, assemble the graph by adding nodes and
edges, attributes, labels, colours, subgraphs, and clusters, and
retrieve its [DOT][] source code string. Save the source code to a file
and render it with the [Graphviz] installation on your system.

You can use the [Splash] function to directly inspect the resulting
graph.

This package was inspired by the python package of the same name
[Python Graphviz][].

## License

This package is distributed under the GNU General Public License v2 or later.
See the `LICENSE` file for more details.

## Links

- GitHub: [https://github.com/digraphs/graphviz](https://github.com/digraphs/graphviz)
- Documentation: TODO
- Changelog: TODO
- Issue Tracker: [https://github.com/digraphs/graphviz/issues](https://github.com/digraphs/graphviz/issues)
- Download: TODO

## Installation

This package requires [GAP][] version 4.11.0 or higher.  The most
up-to-date version of GAP, and instructions on how to install it, can be
obtained from the [main GAP webpage](https://www.gap-system.org). This
package has no further dependencies!

### From sources

To get the latest version of the package, download the archive file
`graphviz-x.x.x.tar.gz` from the [Graphviz package for GAP webpage][].
Then, inside the `pkg` subdirectory of your GAP installation, unpack the
archive `graphviz-x.x.x.tar.gz` in your `gap/pkg` directory, using

    gunzip graphviz-x.x.x.tar.gz; tar xvf graphviz-x.x.x.tar

for example.  This will create a subdirectory `graphviz-x.x.x`.

### Using the [PackageManager][]

Start GAP in the usual way, then type:

    LoadPackage("PackageManager");
    InstallPackage("graphviz");

## Quickstart

Create a graph object:

    gap> LoadPackage("graphviz");
    ───────────────────────────────────────────────────────────────────────────────────
    Loading graphviz 0.0.0 (TODO)
    by James D. Mitchell (https://jdbm.me) and
       Matthew Pancer (mp322@st-andrews.ac.uk).
    Homepage: https://digraphs.github.io/graphviz
    Report issues at https://github.com/digraphs/graphviz/issues
    ───────────────────────────────────────────────────────────────────────────────────
    true
    gap> dot := GraphvizDigraph("The Round Table");
    <graphviz digraph "The Round Table" with 0 nodes and 0 edges>

Add nodes and edges:

    gap> GraphvizSetAttr(GraphvizAddNode(dot, "A"), "label", "King Arthur");
    <graphviz node "A">
    gap> GraphvizSetAttr(GraphvizAddNode(dot, "B"), "label", "Sir Bedevere the Wise");
    <graphviz node "B">
    gap> GraphvizSetAttr(GraphvizAddNode(dot, "L"), "label", "Sir Lancelot the Brave");
    <graphviz node "L">
    gap> GraphvizAddEdge(dot, "A", "B");
    <graphviz edge (A, B)>
    gap> GraphvizAddEdge(dot, "A", "L");
    <graphviz edge (A, L)>
    gap> GraphvizSetAttr(GraphvizAddEdge(dot, "B", "L"), "constraint", false);

Check the generated source code:

    gap> Print(AsString(dot));
    //dot
    digraph {
        A [label="King Arthur"]
        B [label="Sir Bedevere the Wise"]
        L [label="Sir Lancelot the Brave"]
        A -> B
        A -> L
        B -> L [constraint=false]
    }

Save the source code:

    gap> FileString("round-table.gv", AsString(dot));
    134

Render and view the result:

    gap> Splash(dot);

![The Round Table](https://raw.github.com/digraphs/graphviz/main/docs/png/The_Round_Table.png)

## Issues

For questions, remarks, suggestions, and issues please use the
[issue tracker](https://github.com/digraphs/graphviz/issues).

[DOT]: https://www.graphviz.org/doc/info/lang.html
[GAP]: https://www.gap-system.org
[Graphviz]: https://www.graphviz.org
[Graphviz webpage]: https://digraphs.github.io/Digraphs
[PackageManager]: https://gap-packages.github.io/PackageManager
[Python Graphviz]: https://pypi.org/project/graphviz/
