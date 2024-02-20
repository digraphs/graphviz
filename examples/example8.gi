# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/directed/unix.html"""
LoadPackage("graphviz");

u := GV_Digraph("unix");
GV_SetAttr(u, "node [color=\"lightblue2\", style=\"filled\", size=\"6,6\"]");

GV_AddEdge(u, "6th Edition", "5th Edition");
GV_AddEdge(u, "PWB 1.0", "5th Edition");
GV_AddEdge(u, "LSX", "6th Edition");
GV_AddEdge(u, "1 BSD", "6th Edition");
GV_AddEdge(u, "Mini Unix", "6th Edition");
GV_AddEdge(u, "Wollongong", "6th Edition");
GV_AddEdge(u, "Interdata", "6th Edition");
GV_AddEdge(u, "Interdata", "Unix/TS 3.0");
GV_AddEdge(u, "PWB 2.0", "Interdata");
GV_AddEdge(u, "7th Edition", "Interdata");
GV_AddEdge(u, "8th Edition", "7th Edition");
GV_AddEdge(u, "32V", "7th Edition");
GV_AddEdge(u, "V7M", "7th Edition");
GV_AddEdge(u, "Ultrix-11", "7th Edition");
GV_AddEdge(u, "Xenix", "7th Edition");
GV_AddEdge(u, "UniPlus+", "7th Edition");
GV_AddEdge(u, "Ultrix-11", "V7M");
GV_AddEdge(u, "9th Edition", "8th Edition");
GV_AddEdge(u, "2 BSD", "1 BSD");
GV_AddEdge(u, "2.8 BSD", "2 BSD");
GV_AddEdge(u, "Ultrix-11", "2.8 BSD");
GV_AddEdge(u, "2.9 BSD", "2.8 BSD");
GV_AddEdge(u, "3 BSD", "32V");
GV_AddEdge(u, "4 BSD", "3 BSD");
GV_AddEdge(u, "4.1 BSD", "4 BSD");
GV_AddEdge(u, "4.2 BSD", "4.1 BSD");
GV_AddEdge(u, "2.8 BSD", "4.1 BSD");
GV_AddEdge(u, "8th Edition", "4.1 BSD");
GV_AddEdge(u, "4.3 BSD", "4.2 BSD");
GV_AddEdge(u, "Ultrix-32", "4.2 BSD");
GV_AddEdge(u, "PWB 1.2", "PWB 1.0");
GV_AddEdge(u, "USG 1.0", "PWB 1.0");
GV_AddEdge(u, "PWB 2.0", "PWB 1.2");
GV_AddEdge(u, "CB Unix 1", "USG 1.0");
GV_AddEdge(u, "USG 2.0", "USG 1.0");
GV_AddEdge(u, "CB Unix 2", "CB Unix 1");
GV_AddEdge(u, "CB Unix 3", "CB Unix 2");
GV_AddEdge(u, "Unix/TS++", "CB Unix 3");
GV_AddEdge(u, "PDP-11 Sys V", "CB Unix 3");
GV_AddEdge(u, "USG 3.0", "USG 2.0");
GV_AddEdge(u, "Unix/TS 3.0", "USG 3.0");
GV_AddEdge(u, "Unix/TS 3.0", "PWB 2.0");
GV_AddEdge(u, "Unix/TS 3.0", "Unix/TS 1.0");
GV_AddEdge(u, "TS 4.0", "Unix/TS 3.0");
GV_AddEdge(u, "TS 4.0", "Unix/TS++");
GV_AddEdge(u, "TS 4.0", "CB Unix 3");
GV_AddEdge(u, "System V.0", "TS 4.0");
GV_AddEdge(u, "System V.2", "System V.0");
GV_AddEdge(u, "System V.3", "System V.2");

Print(GV_String(u));
