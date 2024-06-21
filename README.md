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
[Python Graphviz].

## Links

- GitHub: https://github.com/xflr6/graphviz
- Documentation: https://graphviz.readthedocs.io
- Changelog: https://graphviz.readthedocs.io/en/latest/changelog.html
- Issue Tracker: https://github.com/xflr6/graphviz/issues
- Download: https://pypi.org/project/graphviz/#files

## Installation

This package requires [GAP][] version 4.11.0 or higher.  The most
up-to-date version of GAP, and instructions on how to install it, can be
obtained from the [main GAP webpage](https://www.gap-system.org). This
package has no further dependencies!

### From sources

To get the latest version of the package, download the archive file
`graphviz-x.x.x.tar.gz` from the [Graphviz webpage][]. Then, inside the
`pkg` subdirectory of your GAP installation, unpack the archive
`graphviz-x.x.x.tar.gz` in your `gap/pkg` directory, using

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

    gap> FileString(TODO

Save and render and view the result:

.. code:: python

    >>> doctest_mark_exe()  # skip this line

    >>> dot.render('doctest-output/round-table.gv', view=True)  # doctest: +SKIP
    'doctest-output/round-table.gv.pdf'

.. image:: https://raw.github.com/xflr6/graphviz/master/docs/_static/round-table.svg
    :align: center
    :alt: round-table.svg

**Caveat:**
Backslash-escapes and strings of the form ``<...>``
have a special meaning in the DOT language.
If you need to render arbitrary strings (e.g. from user input),
check the details in the `user guide`_.

## Issues

For questions, remarks, suggestions, and issues please use the
[issue tracker](https://github.com/digraphs/graphviz/issues).

## License

This package is distributed under the GNU General Public License v2 or later.
See the `LICENSE` file for more details.

[PackageManager]: https://gap-packages.github.io/PackageManager
[Graphviz webpage]: https://digraphs.github.io/Digraphs
[GAP]: https://www.gap-system.org



See also
--------

- pygraphviz_ |--| full-blown interface wrapping the Graphviz C library with SWIG
- graphviz-python_ |--| official Python bindings
  (`documentation <graphviz-python-docs_>`_)
- pydot_ |--| stable pure-Python approach, requires pyparsing


License
-------

This package is distributed under the `MIT license`_.


.. _Graphviz:  https://www.graphviz.org
.. _DOT: https://www.graphviz.org/doc/info/lang.html
.. _upstream repo: https://gitlab.com/graphviz/graphviz/
.. _upstream-download: https://www.graphviz.org/download/
.. _upstream-archived: https://www2.graphviz.org/Archive/stable/
.. _upstream-windows: https://forum.graphviz.org/t/new-simplified-installation-procedure-on-windows/224

.. _set-path-windows: https://www.computerhope.com/issues/ch000549.htm
.. _set-path-linux: https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix
.. _set-path-darwin: https://stackoverflow.com/questions/22465332/setting-path-environment-variable-in-osx-permanently

.. _pip: https://pip.pypa.io

.. _Jupyter notebooks: https://jupyter.org
.. _IPython notebooks: https://ipython.org/notebook.html
.. _Jupyter QtConsole: https://qtconsole.readthedocs.io

.. _notebook: https://github.com/xflr6/graphviz/blob/master/examples/graphviz-notebook.ipynb
.. _notebook-nbviewer: https://nbviewer.org/github/xflr6/graphviz/blob/master/examples/graphviz-notebook.ipynb

.. _Anaconda: https://docs.anaconda.com/anaconda/install/
.. _conda-forge: https://conda-forge.org
.. _conda-forge-python-graphviz: https://anaconda.org/conda-forge/python-graphviz
.. _conda-forge-python-graphviz-feedstock: https://github.com/conda-forge/python-graphviz-feedstock
.. _conda-forge-graphviz: https://anaconda.org/conda-forge/graphviz
.. _conda-forge-graphviz-feedstock: https://github.com/conda-forge/graphviz-feedstock

.. _user guide: https://graphviz.readthedocs.io/en/stable/manual.html

.. _pygraphviz: https://pypi.org/project/pygraphviz/
.. _graphviz-python: https://pypi.org/project/graphviz-python/
.. _graphviz-python-docs: https://www.graphviz.org/pdf/gv.3python.pdf
.. _pydot: https://pypi.org/project/pydot/

.. _MIT license: https://opensource.org/licenses/MIT


.. |--| unicode:: U+2013
