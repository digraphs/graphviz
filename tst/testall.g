# This file runs package tests. It is also referenced in the package metadata
# in PackageInfo.g.

LoadPackage("graphviz");

TestDirectory(DirectoriesPackageLibrary("graphviz", "tst"),
  rec(exitGAP := true, compareFunction := "uptowhitespace"));

FORCE_QUIT_GAP(1);  # if we ever get here, there was an error
