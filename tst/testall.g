# This file runs package tests. It is also referenced in the package metadata
# in PackageInfo.g.

LoadPackage("GraphvizForGAP");
GapExitCode(1);

# compute packages not loaded and thus tests not run
# todo: check if loading other packages without erroring if it fails is possible
excl := [];
testOptions := rec(compareFunction := "uptowhitespace");
if Filename(DirectoriesSystemPrograms(), "dot") = fail then
  Add(excl, "splash.tst");
  Print("Skipping DOT validation: Graphviz program 'dot' not found\n");
else
  ReadPackage("GraphvizForGAP", "tst/testdot.g");
  testOptions.compareFunction := GV_TEST_DOT.Compare;
fi;
if Filename(DirectoriesSystemPrograms(), "pdflatex") = fail then
  Add(excl, "splash_latex.tst");
fi;

if not IsEmpty(excl) then
  Print("Excluding test files: ", excl, "\n");
fi;

success := TestDirectory(DirectoriesPackageLibrary("GraphvizForGAP", "tst"),
  rec(testOptions := testOptions, exclude := excl));

if IsBound(GV_TEST_DOT) then
  Print("DOT validation: ", GV_TEST_DOT.checked, " strings checked, ",
        GV_TEST_DOT.invalid, " intentionally invalid, ",
        GV_TEST_DOT.failures, " failures\n");
  success := success and GV_TEST_DOT.failures = 0;
fi;
if success then
  FORCE_QUIT_GAP(0);
fi;

FORCE_QUIT_GAP(1);  # if we ever get here, there was an error
