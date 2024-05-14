# TODO file header
# TODO rename file to remove "i" suffix

if not IsBound(Splash) then
  BindGlobal("VizViewers",
             ["xpdf", "xdg-open", "open", "evince", "okular", "gv"]);

  BindGlobal("Splash",
  function(arg...)
    local str, opt, path, dir, tdir, file, viewer, type, inn, filetype, out,
          engine;

    if IsEmpty(arg) then
      ErrorNoReturn("the must be at least 1 argument, found none");
    elif not IsString(arg[1]) and not IsGraphvizGraphOrDigraph(arg[1]) then
      ErrorFormatted("the 1st argument must be a string or ",
                     "graphviz graph, found {}", TNAM_OBJ(arg[1]));
    elif IsGraphvizGraphOrDigraph(arg[1]) then
      arg[1] := String(arg[1]);
    fi;
    str := arg[1];

    opt := rec();
    if IsBound(arg[2]) and IsRecord(arg[2]) then
      opt := arg[2];
    elif IsBound(arg[2]) then
      ErrorNoReturn("the 2nd argument must be a record,");
    fi;

    path := UserHomeExpand("~/");
    if IsBound(opt.path) then
      path := opt.path;
    fi;

    if IsBound(opt.directory) then
      if not opt.directory in DirectoryContents(path) then
        Exec(Concatenation("mkdir ", path, opt.directory));
      fi;
      dir := Concatenation(path, opt.directory, "/");
    elif IsBound(opt.path) then
      if not "tmp.viz" in DirectoryContents(path) then
        tdir := Directory(Concatenation(path, "/", "tmp.viz"));
        dir := Filename(tdir, "");
      fi;
    else
      tdir := DirectoryTemporary();
      dir := Filename(tdir, "");
    fi;

    # TODO use the graphs name
    file := "vizpicture";
    if IsBound(opt.filename) then
      file := opt.filename;
    fi;

    if IsBound(opt.viewer) then
      viewer := opt.viewer;
      if not IsString(viewer) then
        ErrorNoReturn("the option `viewer` must be a string, not an ",
                      TNAM_OBJ(viewer));
      elif Filename(DirectoriesSystemPrograms(), viewer) = fail then
        ErrorNoReturn("the viewer \"", viewer, "\" specified in the option ",
                      "`viewer` is not available");
      fi;
    else
      viewer := First(VizViewers, x ->
                      Filename(DirectoriesSystemPrograms(), x) <> fail);
      if viewer = fail then
        ErrorNoReturn("none of the default viewers ", VizViewers,
                      " is available, please specify an available viewer",
                      " in the options record component `viewer`,");
      fi;
    fi;

    if IsBound(opt.type) and (opt.type = "latex" or opt.type = "dot") then
      type := opt.type;
    elif Length(str) >= 6 and str{[1 .. 6]} = "%latex" then
      type := "latex";
    elif Length(str) >= 5 and str{[1 .. 5]} = "//dot" then
      type := "dot";
    else
      ErrorNoReturn("the component \"type\" of the 2nd argument <a record> ",
                    " must be \"dot\" or \"latex\",");
    fi;
    if type = "latex" then
      inn := Concatenation(dir, file, ".tex");
    else
      inn := Concatenation(dir, file, ".dot");
    fi;

    filetype := "pdf";
    if IsBound(opt.filetype) and IsString(opt.filetype) and type <> "latex" then
      filetype := opt.filetype;
    fi;
    out := Concatenation(dir, file, ".", filetype);

    engine := "dot";
    if IsBound(opt.engine) then
      engine := opt.engine;
      if not engine in ["dot", "neato", "twopi", "circo",
                        "fdp", "sfdp", "patchwork"] then
        ErrorNoReturn("the component \"engine\" of the 2nd argument ",
                      "<a record> must be one of: \"dot\", \"neato\", ",
                      "\"twopi\", \"circo\", \"fdp\", \"sfdp\", ",
                      "or \"patchwork\"");
      fi;
    fi;

    FileString(inn, str);
    if type = "latex" then
      Exec(Concatenation("cd ", dir, ";",
                         "pdflatex ", file, " 2>/dev/null 1>/dev/null"));
    else
      Exec(Concatenation(engine, " -T", filetype, " ", inn, " -o ", out));
    fi;
    Exec(Concatenation(viewer, " ", out, " 2>/dev/null 1>/dev/null &"));
  end);
fi;
