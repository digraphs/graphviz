# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/directed/unix.html"""
LoadPackage("graphviz");

u := GraphvizDigraph("unix");
GraphvizSetAttr(
u, "node [color=\"lightblue2\", style=\"filled\", size=\"6,6\"]");

GraphvizAddEdge(u, "5th Edition", "6th Edition");
GraphvizAddEdge(u, "5th Edition", "PWB 1.0");
GraphvizAddEdge(u, "6th Edition", "LSX");
GraphvizAddEdge(u, "6th Edition", "1 BSD");
GraphvizAddEdge(u, "6th Edition", "Mini Unix");
GraphvizAddEdge(u, "6th Edition", "Wollongong");
GraphvizAddEdge(u, "6th Edition", "Interdata");
GraphvizAddEdge(u, "Unix/TS 3.0", "Interdata");
GraphvizAddEdge(u, "Interdata", "PWB 2.0");
GraphvizAddEdge(u, "Interdata", "7th Edition");
GraphvizAddEdge(u, "7th Edition", "8th Edition");
GraphvizAddEdge(u, "7th Edition", "32V");
GraphvizAddEdge(u, "7th Edition", "V7M");
GraphvizAddEdge(u, "7th Edition", "Ultrix-11");
GraphvizAddEdge(u, "7th Edition", "Xenix");
GraphvizAddEdge(u, "7th Edition", "UniPlus+");
GraphvizAddEdge(u, "V7M", "Ultrix-11");
GraphvizAddEdge(u, "8th Edition", "9th Edition");
GraphvizAddEdge(u, "1 BSD", "2 BSD");
GraphvizAddEdge(u, "2 BSD", "2.8 BSD");
GraphvizAddEdge(u, "2.8 BSD", "Ultrix-11");
GraphvizAddEdge(u, "2.8 BSD", "2.9 BSD");
GraphvizAddEdge(u, "32V", "3 BSD");
GraphvizAddEdge(u, "3 BSD", "4 BSD");
GraphvizAddEdge(u, "4 BSD", "4.1 BSD");
GraphvizAddEdge(u, "4.1 BSD", "4.2 BSD");
GraphvizAddEdge(u, "4.1 BSD", "2.8 BSD");
GraphvizAddEdge(u, "4.1 BSD", "8th Edition");
GraphvizAddEdge(u, "4.2 BSD", "4.3 BSD");
GraphvizAddEdge(u, "4.2 BSD", "Ultrix-32");
GraphvizAddEdge(u, "PWB 1.0", "PWB 1.2");
GraphvizAddEdge(u, "PWB 1.0", "USG 1.0");
GraphvizAddEdge(u, "PWB 1.2", "PWB 2.0");
GraphvizAddEdge(u, "USG 1.0", "CB Unix 1");
GraphvizAddEdge(u, "USG 1.0", "USG 2.0");
GraphvizAddEdge(u, "CB Unix 1", "CB Unix 2");
GraphvizAddEdge(u, "CB Unix 2", "CB Unix 3");
GraphvizAddEdge(u, "CB Unix 3", "Unix/TS++");
GraphvizAddEdge(u, "CB Unix 3", "PDP-11 Sys V");
GraphvizAddEdge(u, "USG 2.0", "USG 3.0");
GraphvizAddEdge(u, "USG 3.0", "Unix/TS 3.0");
GraphvizAddEdge(u, "PWB 2.0", "Unix/TS 3.0");
GraphvizAddEdge(u, "Unix/TS 1.0", "Unix/TS 3.0");
GraphvizAddEdge(u, "Unix/TS 3.0", "TS 4.0");
GraphvizAddEdge(u, "Unix/TS++", "TS 4.0");
GraphvizAddEdge(u, "CB Unix 3", "TS 4.0");
GraphvizAddEdge(u, "TS 4.0", "System V.0");
GraphvizAddEdge(u, "System V.0", "System V.2");
GraphvizAddEdge(u, "System V.2", "System V.3");

Print(AsString(u));
