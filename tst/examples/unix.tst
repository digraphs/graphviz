#############################################################################
##
##  unix.tst
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# https://graphviz.readthedocs.io/en/stable/examples.html
# https://graphviz.org/Gallery/directed/unix.html

#@local u
gap> START_TEST("graphviz package: examples/unix.tst");
gap> LoadPackage("graphviz");
true

#
gap> u := GraphvizDigraph("unix");
<graphviz digraph unix with 0 nodes and 0 edges>
gap> GraphvizSetAttr(
> u, "node [color=\"lightblue2\", style=\"filled\", size=\"6,6\"]");
<graphviz digraph unix with 0 nodes and 0 edges>

#
gap> GraphvizAddEdge(u, "5th Edition", "6th Edition");
<graphviz edge (5th Edition, 6th Edition)>
gap> GraphvizAddEdge(u, "5th Edition", "PWB 1.0");
<graphviz edge (5th Edition, PWB 1.0)>
gap> GraphvizAddEdge(u, "6th Edition", "LSX");
<graphviz edge (6th Edition, LSX)>
gap> GraphvizAddEdge(u, "6th Edition", "1 BSD");
<graphviz edge (6th Edition, 1 BSD)>
gap> GraphvizAddEdge(u, "6th Edition", "Mini Unix");
<graphviz edge (6th Edition, Mini Unix)>
gap> GraphvizAddEdge(u, "6th Edition", "Wollongong");
<graphviz edge (6th Edition, Wollongong)>
gap> GraphvizAddEdge(u, "6th Edition", "Interdata");
<graphviz edge (6th Edition, Interdata)>
gap> GraphvizAddEdge(u, "Unix/TS 3.0", "Interdata");
<graphviz edge (Unix/TS 3.0, Interdata)>
gap> GraphvizAddEdge(u, "Interdata", "PWB 2.0");
<graphviz edge (Interdata, PWB 2.0)>
gap> GraphvizAddEdge(u, "Interdata", "7th Edition");
<graphviz edge (Interdata, 7th Edition)>
gap> GraphvizAddEdge(u, "7th Edition", "8th Edition");
<graphviz edge (7th Edition, 8th Edition)>
gap> GraphvizAddEdge(u, "7th Edition", "32V");
<graphviz edge (7th Edition, 32V)>
gap> GraphvizAddEdge(u, "7th Edition", "V7M");
<graphviz edge (7th Edition, V7M)>
gap> GraphvizAddEdge(u, "7th Edition", "Ultrix-11");
<graphviz edge (7th Edition, Ultrix-11)>
gap> GraphvizAddEdge(u, "7th Edition", "Xenix");
<graphviz edge (7th Edition, Xenix)>
gap> GraphvizAddEdge(u, "7th Edition", "UniPlus+");
<graphviz edge (7th Edition, UniPlus+)>
gap> GraphvizAddEdge(u, "V7M", "Ultrix-11");
<graphviz edge (V7M, Ultrix-11)>
gap> GraphvizAddEdge(u, "8th Edition", "9th Edition");
<graphviz edge (8th Edition, 9th Edition)>
gap> GraphvizAddEdge(u, "1 BSD", "2 BSD");
<graphviz edge (1 BSD, 2 BSD)>
gap> GraphvizAddEdge(u, "2 BSD", "2.8 BSD");
<graphviz edge (2 BSD, 2.8 BSD)>
gap> GraphvizAddEdge(u, "2.8 BSD", "Ultrix-11");
<graphviz edge (2.8 BSD, Ultrix-11)>
gap> GraphvizAddEdge(u, "2.8 BSD", "2.9 BSD");
<graphviz edge (2.8 BSD, 2.9 BSD)>
gap> GraphvizAddEdge(u, "32V", "3 BSD");
<graphviz edge (32V, 3 BSD)>
gap> GraphvizAddEdge(u, "3 BSD", "4 BSD");
<graphviz edge (3 BSD, 4 BSD)>
gap> GraphvizAddEdge(u, "4 BSD", "4.1 BSD");
<graphviz edge (4 BSD, 4.1 BSD)>
gap> GraphvizAddEdge(u, "4.1 BSD", "4.2 BSD");
<graphviz edge (4.1 BSD, 4.2 BSD)>
gap> GraphvizAddEdge(u, "4.1 BSD", "2.8 BSD");
<graphviz edge (4.1 BSD, 2.8 BSD)>
gap> GraphvizAddEdge(u, "4.1 BSD", "8th Edition");
<graphviz edge (4.1 BSD, 8th Edition)>
gap> GraphvizAddEdge(u, "4.2 BSD", "4.3 BSD");
<graphviz edge (4.2 BSD, 4.3 BSD)>
gap> GraphvizAddEdge(u, "4.2 BSD", "Ultrix-32");
<graphviz edge (4.2 BSD, Ultrix-32)>
gap> GraphvizAddEdge(u, "PWB 1.0", "PWB 1.2");
<graphviz edge (PWB 1.0, PWB 1.2)>
gap> GraphvizAddEdge(u, "PWB 1.0", "USG 1.0");
<graphviz edge (PWB 1.0, USG 1.0)>
gap> GraphvizAddEdge(u, "PWB 1.2", "PWB 2.0");
<graphviz edge (PWB 1.2, PWB 2.0)>
gap> GraphvizAddEdge(u, "USG 1.0", "CB Unix 1");
<graphviz edge (USG 1.0, CB Unix 1)>
gap> GraphvizAddEdge(u, "USG 1.0", "USG 2.0");
<graphviz edge (USG 1.0, USG 2.0)>
gap> GraphvizAddEdge(u, "CB Unix 1", "CB Unix 2");
<graphviz edge (CB Unix 1, CB Unix 2)>
gap> GraphvizAddEdge(u, "CB Unix 2", "CB Unix 3");
<graphviz edge (CB Unix 2, CB Unix 3)>
gap> GraphvizAddEdge(u, "CB Unix 3", "Unix/TS++");
<graphviz edge (CB Unix 3, Unix/TS++)>
gap> GraphvizAddEdge(u, "CB Unix 3", "PDP-11 Sys V");
<graphviz edge (CB Unix 3, PDP-11 Sys V)>
gap> GraphvizAddEdge(u, "USG 2.0", "USG 3.0");
<graphviz edge (USG 2.0, USG 3.0)>
gap> GraphvizAddEdge(u, "USG 3.0", "Unix/TS 3.0");
<graphviz edge (USG 3.0, Unix/TS 3.0)>
gap> GraphvizAddEdge(u, "PWB 2.0", "Unix/TS 3.0");
<graphviz edge (PWB 2.0, Unix/TS 3.0)>
gap> GraphvizAddEdge(u, "Unix/TS 1.0", "Unix/TS 3.0");
<graphviz edge (Unix/TS 1.0, Unix/TS 3.0)>
gap> GraphvizAddEdge(u, "Unix/TS 3.0", "TS 4.0");
<graphviz edge (Unix/TS 3.0, TS 4.0)>
gap> GraphvizAddEdge(u, "Unix/TS++", "TS 4.0");
<graphviz edge (Unix/TS++, TS 4.0)>
gap> GraphvizAddEdge(u, "CB Unix 3", "TS 4.0");
<graphviz edge (CB Unix 3, TS 4.0)>
gap> GraphvizAddEdge(u, "TS 4.0", "System V.0");
<graphviz edge (TS 4.0, System V.0)>
gap> GraphvizAddEdge(u, "System V.0", "System V.2");
<graphviz edge (System V.0, System V.2)>
gap> GraphvizAddEdge(u, "System V.2", "System V.3");
<graphviz edge (System V.2, System V.3)>

#
gap> AsString(u) =
> "//dot\ndigraph unix {\n\tnode [color=\"lightblue2\", style=\"filled\", size=\
> \"6,6\"] \n\t\"5th Edition\"\n\t\"6th Edition\"\n\t\"5th Edition\" -> \"6th Ed\
> ition\"\n\t\"PWB 1.0\"\n\t\"5th Edition\" -> \"PWB 1.0\"\n\tLSX\n\t\"6th Editi\
> on\" -> LSX\n\t\"1 BSD\"\n\t\"6th Edition\" -> \"1 BSD\"\n\t\"Mini Unix\"\n\t\
> \"6th Edition\" -> \"Mini Unix\"\n\tWollongong\n\t\"6th Edition\" -> Wollongon\
> g\n\tInterdata\n\t\"6th Edition\" -> Interdata\n\t\"Unix/TS 3.0\"\n\t\"Unix/TS\
>  3.0\" -> Interdata\n\t\"PWB 2.0\"\n\tInterdata -> \"PWB 2.0\"\n\t\"7th Editio\
> n\"\n\tInterdata -> \"7th Edition\"\n\t\"8th Edition\"\n\t\"7th Edition\" -> \
> \"8th Edition\"\n\t\"32V\"\n\t\"7th Edition\" -> \"32V\"\n\tV7M\n\t\"7th Editi\
> on\" -> V7M\n\t\"Ultrix-11\"\n\t\"7th Edition\" -> \"Ultrix-11\"\n\tXenix\n\t\
> \"7th Edition\" -> Xenix\n\t\"UniPlus+\"\n\t\"7th Edition\" -> \"UniPlus+\"\n\
> \tV7M -> \"Ultrix-11\"\n\t\"9th Edition\"\n\t\"8th Edition\" -> \"9th Edition\
> \"\n\t\"2 BSD\"\n\t\"1 BSD\" -> \"2 BSD\"\n\t\"2.8 BSD\"\n\t\"2 BSD\" -> \"2.8\
>  BSD\"\n\t\"2.8 BSD\" -> \"Ultrix-11\"\n\t\"2.9 BSD\"\n\t\"2.8 BSD\" -> \"2.9 \
> BSD\"\n\t\"3 BSD\"\n\t\"32V\" -> \"3 BSD\"\n\t\"4 BSD\"\n\t\"3 BSD\" -> \"4 BS\
> D\"\n\t\"4.1 BSD\"\n\t\"4 BSD\" -> \"4.1 BSD\"\n\t\"4.2 BSD\"\n\t\"4.1 BSD\" -\
> > \"4.2 BSD\"\n\t\"4.1 BSD\" -> \"2.8 BSD\"\n\t\"4.1 BSD\" -> \"8th Edition\"\
> \n\t\"4.3 BSD\"\n\t\"4.2 BSD\" -> \"4.3 BSD\"\n\t\"Ultrix-32\"\n\t\"4.2 BSD\" \
> -> \"Ultrix-32\"\n\t\"PWB 1.2\"\n\t\"PWB 1.0\" -> \"PWB 1.2\"\n\t\"USG 1.0\"\n\
> \t\"PWB 1.0\" -> \"USG 1.0\"\n\t\"PWB 1.2\" -> \"PWB 2.0\"\n\t\"CB Unix 1\"\n\
> \t\"USG 1.0\" -> \"CB Unix 1\"\n\t\"USG 2.0\"\n\t\"USG 1.0\" -> \"USG 2.0\"\n\
> \t\"CB Unix 2\"\n\t\"CB Unix 1\" -> \"CB Unix 2\"\n\t\"CB Unix 3\"\n\t\"CB Uni\
> x 2\" -> \"CB Unix 3\"\n\t\"Unix/TS++\"\n\t\"CB Unix 3\" -> \"Unix/TS++\"\n\t\
> \"PDP-11 Sys V\"\n\t\"CB Unix 3\" -> \"PDP-11 Sys V\"\n\t\"USG 3.0\"\n\t\"USG \
> 2.0\" -> \"USG 3.0\"\n\t\"USG 3.0\" -> \"Unix/TS 3.0\"\n\t\"PWB 2.0\" -> \"Uni\
> x/TS 3.0\"\n\t\"Unix/TS 1.0\"\n\t\"Unix/TS 1.0\" -> \"Unix/TS 3.0\"\n\t\"TS 4.\
> 0\"\n\t\"Unix/TS 3.0\" -> \"TS 4.0\"\n\t\"Unix/TS++\" -> \"TS 4.0\"\n\t\"CB Un\
> ix 3\" -> \"TS 4.0\"\n\t\"System V.0\"\n\t\"TS 4.0\" -> \"System V.0\"\n\t\"Sy\
> stem V.2\"\n\t\"System V.0\" -> \"System V.2\"\n\t\"System V.3\"\n\t\"System V\
> .2\" -> \"System V.3\"\n}\n";
#I  invalid node name 5th Edition using "5th Edition" instead
#I  invalid node name 6th Edition using "6th Edition" instead
#I  invalid node name 5th Edition using "5th Edition" instead
#I  invalid node name 6th Edition using "6th Edition" instead
#I  invalid node name PWB 1.0 using "PWB 1.0" instead
#I  invalid node name 5th Edition using "5th Edition" instead
#I  invalid node name PWB 1.0 using "PWB 1.0" instead
#I  invalid node name 6th Edition using "6th Edition" instead
#I  invalid node name 1 BSD using "1 BSD" instead
#I  invalid node name 6th Edition using "6th Edition" instead
#I  invalid node name 1 BSD using "1 BSD" instead
#I  invalid node name Mini Unix using "Mini Unix" instead
#I  invalid node name 6th Edition using "6th Edition" instead
#I  invalid node name Mini Unix using "Mini Unix" instead
#I  invalid node name 6th Edition using "6th Edition" instead
#I  invalid node name 6th Edition using "6th Edition" instead
#I  invalid node name Unix/TS 3.0 using "Unix/TS 3.0" instead
#I  invalid node name Unix/TS 3.0 using "Unix/TS 3.0" instead
#I  invalid node name PWB 2.0 using "PWB 2.0" instead
#I  invalid node name PWB 2.0 using "PWB 2.0" instead
#I  invalid node name 7th Edition using "7th Edition" instead
#I  invalid node name 7th Edition using "7th Edition" instead
#I  invalid node name 8th Edition using "8th Edition" instead
#I  invalid node name 7th Edition using "7th Edition" instead
#I  invalid node name 8th Edition using "8th Edition" instead
#I  invalid node name 32V using "32V" instead
#I  invalid node name 7th Edition using "7th Edition" instead
#I  invalid node name 32V using "32V" instead
#I  invalid node name 7th Edition using "7th Edition" instead
#I  invalid node name Ultrix-11 using "Ultrix-11" instead
#I  invalid node name 7th Edition using "7th Edition" instead
#I  invalid node name Ultrix-11 using "Ultrix-11" instead
#I  invalid node name 7th Edition using "7th Edition" instead
#I  invalid node name UniPlus+ using "UniPlus+" instead
#I  invalid node name 7th Edition using "7th Edition" instead
#I  invalid node name UniPlus+ using "UniPlus+" instead
#I  invalid node name Ultrix-11 using "Ultrix-11" instead
#I  invalid node name 9th Edition using "9th Edition" instead
#I  invalid node name 8th Edition using "8th Edition" instead
#I  invalid node name 9th Edition using "9th Edition" instead
#I  invalid node name 2 BSD using "2 BSD" instead
#I  invalid node name 1 BSD using "1 BSD" instead
#I  invalid node name 2 BSD using "2 BSD" instead
#I  invalid node name 2.8 BSD using "2.8 BSD" instead
#I  invalid node name 2 BSD using "2 BSD" instead
#I  invalid node name 2.8 BSD using "2.8 BSD" instead
#I  invalid node name 2.8 BSD using "2.8 BSD" instead
#I  invalid node name Ultrix-11 using "Ultrix-11" instead
#I  invalid node name 2.9 BSD using "2.9 BSD" instead
#I  invalid node name 2.8 BSD using "2.8 BSD" instead
#I  invalid node name 2.9 BSD using "2.9 BSD" instead
#I  invalid node name 3 BSD using "3 BSD" instead
#I  invalid node name 32V using "32V" instead
#I  invalid node name 3 BSD using "3 BSD" instead
#I  invalid node name 4 BSD using "4 BSD" instead
#I  invalid node name 3 BSD using "3 BSD" instead
#I  invalid node name 4 BSD using "4 BSD" instead
#I  invalid node name 4.1 BSD using "4.1 BSD" instead
#I  invalid node name 4 BSD using "4 BSD" instead
#I  invalid node name 4.1 BSD using "4.1 BSD" instead
#I  invalid node name 4.2 BSD using "4.2 BSD" instead
#I  invalid node name 4.1 BSD using "4.1 BSD" instead
#I  invalid node name 4.2 BSD using "4.2 BSD" instead
#I  invalid node name 4.1 BSD using "4.1 BSD" instead
#I  invalid node name 2.8 BSD using "2.8 BSD" instead
#I  invalid node name 4.1 BSD using "4.1 BSD" instead
#I  invalid node name 8th Edition using "8th Edition" instead
#I  invalid node name 4.3 BSD using "4.3 BSD" instead
#I  invalid node name 4.2 BSD using "4.2 BSD" instead
#I  invalid node name 4.3 BSD using "4.3 BSD" instead
#I  invalid node name Ultrix-32 using "Ultrix-32" instead
#I  invalid node name 4.2 BSD using "4.2 BSD" instead
#I  invalid node name Ultrix-32 using "Ultrix-32" instead
#I  invalid node name PWB 1.2 using "PWB 1.2" instead
#I  invalid node name PWB 1.0 using "PWB 1.0" instead
#I  invalid node name PWB 1.2 using "PWB 1.2" instead
#I  invalid node name USG 1.0 using "USG 1.0" instead
#I  invalid node name PWB 1.0 using "PWB 1.0" instead
#I  invalid node name USG 1.0 using "USG 1.0" instead
#I  invalid node name PWB 1.2 using "PWB 1.2" instead
#I  invalid node name PWB 2.0 using "PWB 2.0" instead
#I  invalid node name CB Unix 1 using "CB Unix 1" instead
#I  invalid node name USG 1.0 using "USG 1.0" instead
#I  invalid node name CB Unix 1 using "CB Unix 1" instead
#I  invalid node name USG 2.0 using "USG 2.0" instead
#I  invalid node name USG 1.0 using "USG 1.0" instead
#I  invalid node name USG 2.0 using "USG 2.0" instead
#I  invalid node name CB Unix 2 using "CB Unix 2" instead
#I  invalid node name CB Unix 1 using "CB Unix 1" instead
#I  invalid node name CB Unix 2 using "CB Unix 2" instead
#I  invalid node name CB Unix 3 using "CB Unix 3" instead
#I  invalid node name CB Unix 2 using "CB Unix 2" instead
#I  invalid node name CB Unix 3 using "CB Unix 3" instead
#I  invalid node name Unix/TS++ using "Unix/TS++" instead
#I  invalid node name CB Unix 3 using "CB Unix 3" instead
#I  invalid node name Unix/TS++ using "Unix/TS++" instead
#I  invalid node name PDP-11 Sys V using "PDP-11 Sys V" instead
#I  invalid node name CB Unix 3 using "CB Unix 3" instead
#I  invalid node name PDP-11 Sys V using "PDP-11 Sys V" instead
#I  invalid node name USG 3.0 using "USG 3.0" instead
#I  invalid node name USG 2.0 using "USG 2.0" instead
#I  invalid node name USG 3.0 using "USG 3.0" instead
#I  invalid node name USG 3.0 using "USG 3.0" instead
#I  invalid node name Unix/TS 3.0 using "Unix/TS 3.0" instead
#I  invalid node name PWB 2.0 using "PWB 2.0" instead
#I  invalid node name Unix/TS 3.0 using "Unix/TS 3.0" instead
#I  invalid node name Unix/TS 1.0 using "Unix/TS 1.0" instead
#I  invalid node name Unix/TS 1.0 using "Unix/TS 1.0" instead
#I  invalid node name Unix/TS 3.0 using "Unix/TS 3.0" instead
#I  invalid node name TS 4.0 using "TS 4.0" instead
#I  invalid node name Unix/TS 3.0 using "Unix/TS 3.0" instead
#I  invalid node name TS 4.0 using "TS 4.0" instead
#I  invalid node name Unix/TS++ using "Unix/TS++" instead
#I  invalid node name TS 4.0 using "TS 4.0" instead
#I  invalid node name CB Unix 3 using "CB Unix 3" instead
#I  invalid node name TS 4.0 using "TS 4.0" instead
#I  invalid node name System V.0 using "System V.0" instead
#I  invalid node name TS 4.0 using "TS 4.0" instead
#I  invalid node name System V.0 using "System V.0" instead
#I  invalid node name System V.2 using "System V.2" instead
#I  invalid node name System V.0 using "System V.0" instead
#I  invalid node name System V.2 using "System V.2" instead
#I  invalid node name System V.3 using "System V.3" instead
#I  invalid node name System V.2 using "System V.2" instead
#I  invalid node name System V.3 using "System V.3" instead
true

#
gap> STOP_TEST("graphviz package: examples/unix.tst");
