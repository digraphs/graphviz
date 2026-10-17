[![CI](https://github.com/gap-packages/GraphvizForGAP/actions/workflows/CI.yml/badge.svg)](https://github.com/gap-packages/GraphvizForGAP/actions/workflows/CI.yml)
[![Code Coverage](https://codecov.io/github/gap-packages/GraphvizForGAP/coverage.svg)](https://codecov.io/gh/gap-packages/Graphviz)

# Graphviz for GAP

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

- GitHub: [https://github.com/gap-packages/GraphvizForGAP](https://github.com/gap-packages/GraphvizForGAP)
- Documentation: [https://gap-packages.github.io/GraphvizForGAP](https://gap-packages.github.io/GraphvizForGAP)
- Changelog: TODO
- Issue Tracker: [https://github.com/gap-packages/GraphvizForGAP/issues](https://github.com/gap-packages/GraphvizForGAP/issues)
- Download: [https://github.com/gap-packages/GraphvizForGAP/releases](https://github.com/gap-packages/GraphvizForGAP/releases)

## Installation

This package requires [GAP][] version 4.12.0 or higher.  The most
up-to-date version of GAP, and instructions on how to install it, can be
obtained from the [main GAP webpage](https://www.gap-system.org). This
package has no further dependencies!

### From sources

To get the latest version of the package, download the archive file
`GraphvizForGAP-x.x.x.tar.gz` from the [GitHub releases page](https://github.com/gap-packages/GraphvizForGAP/releases).
Then, inside the `pkg` subdirectory of your GAP installation, unpack the
archive `GraphvizForGAP-x.x.x.tar.gz` in your `gap/pkg` directory, using

    gunzip GraphvizForGAP-x.x.x.tar.gz; tar xvf GraphvizForGAP-x.x.x.tar

for example.  This will create a subdirectory `GraphvizForGAP-x.x.x`.

### Using the [PackageManager][]

Start GAP in the usual way, then type:

    LoadPackage("PackageManager");
    InstallPackage("GraphvizForGAP");

## Quickstart

Create a graph object:

    gap> LoadPackage("GraphvizForGAP");
    ───────────────────────────────────────────────────────────────────────────────────
    Loading GraphvizForGAP 0.0.0 (GAP representations of graphviz objects)
    by James D. Mitchell (https://jdbm.me) and
       Matthew Pancer (mp322@st-andrews.ac.uk).
    Homepage: https://gap-packages.github.io/GraphvizForGAP/
    Report issues at https://github.com/gap-packages/GraphvizForGAP/issues
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

![The Round Table](./doc/img/The_Round_Table.png)

## Testing

Run `make check` (or `make check GAP=/path/to/gap`). When Graphviz's `dot`
is on `PATH`, the suite also parses every generated `AsString` result using
`dot -Tcanon`. Validation failures report the DOT and Graphviz diagnostics
and fail the suite even if the saved output matches. CI installs Graphviz;
local runs without it explicitly report that validation is skipped.

Tests which intentionally produce invalid DOT must give a reason, for example
`AsString(gv : invalidDOT := "unquoted attribute name with spaces")`.
These cases must be rejected by Graphviz. This checks syntax, not layout or
whether the parsed graph has the intended meaning; the output comparisons
remain in place.

## Structure of the package

The goal for the structure of this packages is as follows:

- `GraphvizForGAP` provides a wrapper for the [`graphviz`](https://graphviz.org/) graph visualization tool:
  - It allows users to construct and manipulate `graphviz` graphs as GAP objects in a structured manner,
  - It has functionality for converting `graphviz` graphs to [DOT language](https://graphviz.org/doc/info/lang.html) strings which can be rendered using `graphviz` via the `dot` tool,
  - It provides a method for calling the `dot` tool from within GAP and saving or displaying the resulting output,
- e.g. `Digraphs` has code, which uses these functions so that a user can generate these visualisations
- e.g. `Digraphs` has `GraphvizForGAP` as an extension, so in particular only loads the code using the `GraphvizForGAP` functions if the `GraphvizForGAP` is loaded. As a result e.g. `Digraphs` can be used without installing `GraphvizForGAP`
- The main reason for this is that the packages dealing with the mathematical objects maintain their own visualisation themselves, to reduce maintenance burden in `GraphvizForGAP`. The package is meant to be small in scope.

## Issues

For questions, remarks, suggestions, and issues please use the
[issue tracker](https://github.com/gap-packages/GraphvizForGAP/issues).

[DOT]: https://www.graphviz.org/doc/info/lang.html
[GAP]: https://www.gap-system.org
[Graphviz]: https://www.graphviz.org
[PackageManager]: https://gap-packages.github.io/PackageManager
[Python Graphviz]: https://pypi.org/project/graphviz/
