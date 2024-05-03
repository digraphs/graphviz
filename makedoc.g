#############################################################################
##
##  makedoc.g
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

## This file is a script which compiles the package manual.

if fail = LoadPackage("AutoDoc", "2022.10.20") then
    Error("AutoDoc version 2022.10.20 or newer is required.");
fi;

AutoDoc(rec(scaffold := true, autodoc := true));
QUIT;
