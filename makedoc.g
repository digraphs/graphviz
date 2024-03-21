#
# graphviz: This package facilitates the creation of graph descriptions in the
# DOT language of the Graphviz graph drawing software from GAP
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2022.10.20") then
    Error("AutoDoc version 2018.02.14 or newer is required.");
fi;

AutoDoc(rec(scaffold := true, autodoc := true));
QUIT;