gap> START_TEST("graphviz package: dot-validation.tst");

# The validator is installed by testall.g when Graphviz is available.
#@if IsBound(GV_TEST_DOT)
gap> GV_TEST_DOT.Validate("graph { a -- b }").valid;
true
gap> GV_TEST_DOT.Validate("digraph { a -> b }").valid;
true
gap> GV_TEST_DOT.Validate("graph { }").valid;
true

# Graphviz accepts empty input with status 0; require an actual parsed graph.
gap> GV_TEST_DOT.Validate("").valid;
false
gap> GV_TEST_DOT.Validate("// only a comment\n").valid;
false
gap> GV_TEST_DOT.Validate("digraph { a -- b }").valid;
false
gap> GV_TEST_DOT.Validate("graph { a -- b").valid;
false
gap> GV_TEST_DOT.Validate("graph { a [bad name=1] }").valid;
false
gap> GV_TEST_DOT.Validate("graph context+subgraph { }").valid;
false
gap> GV_TEST_DOT.Validate("graph { a [label=\"<<B X=\"1\">text</B>>\"] }").valid;
false
#@fi

gap> STOP_TEST("graphviz package: dot-validation.tst", 0);
