#
# graphviz: This package facilitates the creation of graph descriptions in the DOT language of the Graphviz graph drawing software from GAP
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "graphviz" );

TestDirectory(DirectoriesPackageLibrary( "graphviz", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
