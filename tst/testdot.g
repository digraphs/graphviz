# Test-only instrumentation: validate the actual strings returned by AsString.
if not IsBound(GV_TEST_DOT) then
  BindGlobal("GV_TEST_DOT", rec(
    dot := Filename(DirectoriesSystemPrograms(), "dot"),
    directory := DirectoryTemporary(),
    originalAsString := ApplicableMethod(AsString, [GraphvizGraph()]),
    pending := [],
    checked := 0,
    invalid := 0,
    failures := 0));

  GV_TEST_DOT.Validate := function(source)
    local canonical, input, output, diagnostics, status, parsed;
    canonical := Filename(GV_TEST_DOT.directory, "canonical.dot");
    diagnostics := "";
    input := InputTextString(source);
    output := OutputTextString(diagnostics, false);
    # Pass paths as arguments; only the fixed redirection needs a shell.
    status := Process(GV_TEST_DOT.directory,
                      Filename(DirectoriesSystemPrograms(), "sh"),
                      input, output,
                      ["-c", "exec \"$1\" -Tcanon -o \"$2\" 2>&1", "sh",
                       GV_TEST_DOT.dot, canonical]);
    CloseStream(input);
    CloseStream(output);
    parsed := IsReadableFile(canonical) and not IsEmpty(StringFile(canonical));
    RemoveFile(canonical);
    return rec(valid := status = 0 and parsed,
               status := status, diagnostics := diagnostics);
  end;

  InstallMethod(AsString, "validate DOT during package tests",
  [IsGraphvizGraphDigraphOrContext], 100,
  function(graph)
    local entry;
    entry := rec(source := GV_TEST_DOT.originalAsString(graph),
                 reason := ValueOption("invalidDOT"));
    Add(GV_TEST_DOT.pending, entry);
    return entry.source;
  end);

  GV_TEST_DOT.Compare := function(expected, actual)
    local ok, entry, result, invalid;
    ok := true;
    for entry in GV_TEST_DOT.pending do
      result := GV_TEST_DOT.Validate(entry.source);
      invalid := IsString(entry.reason) and not IsEmpty(entry.reason);
      GV_TEST_DOT.checked := GV_TEST_DOT.checked + 1;
      if invalid then
        GV_TEST_DOT.invalid := GV_TEST_DOT.invalid + 1;
      fi;
      # Exit status 1 denotes rejected DOT, not a missing/crashed executable.
      if (invalid and (result.valid or result.status <> 1))
          or (not invalid and not result.valid) then
        ok := false;
        GV_TEST_DOT.failures := GV_TEST_DOT.failures + 1;
        if invalid then
          Print("DOT validation: expected invalid DOT (", entry.reason, ")\n");
        else
          Print("DOT validation: expected valid DOT\n");
        fi;
        Print("Graphviz exit status: ", result.status, "\n",
              result.diagnostics, "Generated DOT:\n", entry.source, "\n");
      fi;
    od;
    GV_TEST_DOT.pending := [];
    return ok and TEST.compareFunctions.uptowhitespace(expected, actual);
  end;
fi;
