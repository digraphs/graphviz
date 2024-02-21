# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/directed/unix.html"""
LoadPackage("graphviz");

u := GV_Digraph("unix");
GV_SetAttr(u, "node [color=\"lightblue2\", style=\"filled\", size=\"6,6\"]");

GV_AddEdge(u, "5th Edition", "6th Edition");
GV_AddEdge(u, "5th Edition", "PWB 1.0");
GV_AddEdge(u, "6th Edition", "LSX");
GV_AddEdge(u, "6th Edition", "1 BSD");
GV_AddEdge(u, "6th Edition", "Mini Unix");
GV_AddEdge(u, "6th Edition", "Wollongong");
GV_AddEdge(u, "6th Edition", "Interdata");
GV_AddEdge(u, "Unix/TS 3.0", "Interdata");
GV_AddEdge(u, "Interdata", "PWB 2.0");
GV_AddEdge(u, "Interdata", "7th Edition");
GV_AddEdge(u, "7th Edition", "8th Edition");
GV_AddEdge(u, "7th Edition", "32V");
GV_AddEdge(u, "7th Edition", "V7M");
GV_AddEdge(u, "7th Edition", "Ultrix-11");
GV_AddEdge(u, "7th Edition", "Xenix");
GV_AddEdge(u, "7th Edition", "UniPlus+");
GV_AddEdge(u, "V7M", "Ultrix-11");
GV_AddEdge(u, "8th Edition", "9th Edition");
GV_AddEdge(u, "1 BSD", "2 BSD");
GV_AddEdge(u, "2 BSD", "2.8 BSD");
GV_AddEdge(u, "2.8 BSD", "Ultrix-11");
GV_AddEdge(u, "2.8 BSD", "2.9 BSD");
GV_AddEdge(u, "32V", "3 BSD");
GV_AddEdge(u, "3 BSD", "4 BSD");
GV_AddEdge(u, "4 BSD", "4.1 BSD");
GV_AddEdge(u, "4.1 BSD", "4.2 BSD");
GV_AddEdge(u, "4.1 BSD", "2.8 BSD");
GV_AddEdge(u, "4.1 BSD", "8th Edition");
GV_AddEdge(u, "4.2 BSD", "4.3 BSD");
GV_AddEdge(u, "4.2 BSD", "Ultrix-32");
GV_AddEdge(u, "PWB 1.0", "PWB 1.2");
GV_AddEdge(u, "PWB 1.0", "USG 1.0");
GV_AddEdge(u, "PWB 1.2", "PWB 2.0");
GV_AddEdge(u, "USG 1.0", "CB Unix 1");
GV_AddEdge(u, "USG 1.0", "USG 2.0");
GV_AddEdge(u, "CB Unix 1", "CB Unix 2");
GV_AddEdge(u, "CB Unix 2", "CB Unix 3");
GV_AddEdge(u, "CB Unix 3", "Unix/TS++");
GV_AddEdge(u, "CB Unix 3", "PDP-11 Sys V");
GV_AddEdge(u, "USG 2.0", "USG 3.0");
GV_AddEdge(u, "USG 3.0", "Unix/TS 3.0");
GV_AddEdge(u, "PWB 2.0", "Unix/TS 3.0");
GV_AddEdge(u, "Unix/TS 1.0", "Unix/TS 3.0");
GV_AddEdge(u, "Unix/TS 3.0", "TS 4.0");
GV_AddEdge(u, "Unix/TS++", "TS 4.0");
GV_AddEdge(u, "CB Unix 3", "TS 4.0");
GV_AddEdge(u, "TS 4.0", "System V.0");
GV_AddEdge(u, "System V.0", "System V.2");
GV_AddEdge(u, "System V.2", "System V.3");

Print(GV_String(u));
