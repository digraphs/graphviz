#############################################################################
##
##  structs.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/Gallery/directed/unix.html

#@local s
gap> START_TEST("graphviz package: examples/structs.tst");
gap> LoadPackage("graphviz");
true
gap> s := GraphvizDigraph("structs");
<graphviz digraph structs with 0 nodes and 0 edges>
gap> GraphvizSetAttr(s, "node [shape=\"plaintext\"]");
<graphviz digraph structs with 0 nodes and 0 edges>

#
gap> GraphvizSetAttr(GraphvizAddNode(s, "struct1"), "label",
> """<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">
> <TR>
> <TD>left</TD>
> <TD PORT="f1">middle</TD><TD PORT="f2">right</TD>
> </TR>
> </TABLE>>""");
<graphviz node struct1>
gap> GraphvizSetAttr(GraphvizAddNode(s, "struct2"), "label",
> """<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">
> <TR>
> <TD PORT="f0">one</TD>
> <TD>two</TD>
> </TR>
> </TABLE>>""");
<graphviz node struct2>
gap> GraphvizSetAttr(GraphvizAddNode(s, "struct3"), "label",
> """<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4">
> <TR>
> <TD ROWSPAN="3">hello<BR/>world</TD>
> <TD COLSPAN="3">b</TD>
> <TD ROWSPAN="3">g</TD>
> <TD ROWSPAN="3">h</TD>
> </TR>
> <TR>
> <TD>c</TD>
> <TD PORT="here">d</TD>
> <TD>e</TD>
> </TR>
> <TR>
> <TD COLSPAN="3">f</TD>
> </TR>
> </TABLE>>""");
<graphviz node struct3>

#
gap> GraphvizAddEdge(s, "struct1:f1", "struct2:f0");
<graphviz edge (struct1:f1, struct2:f0)>
gap> GraphvizAddEdge(s, "struct1:f2", "struct3:here");
<graphviz edge (struct1:f2, struct3:here)>

#
gap> AsString(s);
"//dot\ndigraph structs {\n\tnode [shape=\"plaintext\"] \n\tstruct1 [label=<<T\
ABLE BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\">\n<TR>\n<TD>left</TD>\n<T\
D PORT=\"f1\">middle</TD><TD PORT=\"f2\">right</TD>\n</TR>\n</TABLE>>]\n\tstru\
ct2 [label=<<TABLE BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\">\n<TR>\n<TD\
 PORT=\"f0\">one</TD>\n<TD>two</TD>\n</TR>\n</TABLE>>]\n\tstruct3 [label=<<TAB\
LE BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\" CELLPADDING=\"4\">\n<TR>\n<\
TD ROWSPAN=\"3\">hello<BR/>world</TD>\n<TD COLSPAN=\"3\">b</TD>\n<TD ROWSPAN=\
\"3\">g</TD>\n<TD ROWSPAN=\"3\">h</TD>\n</TR>\n<TR>\n<TD>c</TD>\n<TD PORT=\"he\
re\">d</TD>\n<TD>e</TD>\n</TR>\n<TR>\n<TD COLSPAN=\"3\">f</TD>\n</TR>\n</TABLE\
>>]\n\tstruct1:f1\n\tstruct2:f0\n\tstruct1:f1 -> struct2:f0\n\tstruct1:f2\n\ts\
truct3:here\n\tstruct1:f2 -> struct3:here\n}\n"

#
gap> STOP_TEST("graphviz package: examples/structs.tst");
