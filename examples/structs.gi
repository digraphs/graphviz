# # https://graphviz.readthedocs.io/en/stable/examples.html
# # """https://graphviz.org/Gallery/directed/unix.html"""
LoadPackage("graphviz");

s := GraphvizDigraph("structs");
GraphvizSetAttr(s, "node [shape=\"plaintext\"]");

GraphvizSetAttr(GraphvizAddNode(s, "struct1"), "label", "<<TABLE BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\"><TR><TD>left</TD><TD PORT=\"f1\">middle</TD><TD PORT=\"f2\">right</TD></TR></TABLE>>");
GraphvizSetAttr(GraphvizAddNode(s, "struct2"), "label", "<<TABLE BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\"><TR><TD PORT=\"f0\">one</TD><TD>two</TD></TR></TABLE>>");
GraphvizSetAttr(GraphvizAddNode(s, "struct3"), "label", "<<TABLE BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\" CELLPADDING=\"4\"><TR><TD ROWSPAN=\"3\">hello<BR/>world</TD><TD COLSPAN=\"3\">b</TD><TD ROWSPAN=\"3\">g</TD><TD ROWSPAN=\"3\">h</TD></TR><TR><TD>c</TD><TD PORT=\"here\">d</TD><TD>e</TD></TR><TR><TD COLSPAN=\"3\">f</TD></TR></TABLE>>");

GraphvizAddEdge(s, "struct1:f1", "struct2:f0");
GraphvizAddEdge(s, "struct1:f2", "struct3:here");

Print(AsString(s));
