#############################################################################
##
##  splash.gi
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# The contents of this file are transplanted from the Digraphs package to here.
# The original function was written by A. Egri-Nagy and Manuel Delgado, with
# some minor modifications by J. Mitchell.

BindGlobal("VizViewers",
           ["xpdf", "xdg-open", "open", "evince", "okular", "gv"]);

# Run the system program <prog> in the directory <dir> with the arguments
# <args>, discarding its standard output. No shell is involved, so the
# arguments need no quoting.
BindGlobal("GV_RunProgram",
function(dir, prog, args)
  local path, status;

  Info(InfoGraphviz, 2, "running ", prog, " ", args, " in ", Filename(dir, ""));
  path := Filename(DirectoriesSystemPrograms(), prog);
  if path = fail then
    ErrorNoReturn("the program \"", prog, "\" is not available");
  fi;
  Info(InfoGraphviz, 3, "found ", prog, " at ", path);

  status := Process(dir, path, InputTextNone(), OutputTextNone(), args);
  if status <> 0 then
    ErrorNoReturn("the program \"", prog, "\" failed with exit status ", status);
  fi;
end);

InstallGlobalFunction(Splash,
function(arg...)
  local file, str, opt, path, subdir, dir, tdir, viewer, type, inn, filetype, out,
  engine, i;

  if IsEmpty(arg) then
    ErrorNoReturn("the must be at least 1 argument, found none");
  elif not IsString(arg[1]) and not IsGraphvizGraphDigraphOrContext(arg[1]) then
    ErrorFormatted("the 1st argument must be a string or ",
                   "graphviz graph, found {}", TNAM_OBJ(arg[1]));
  elif IsGraphvizGraphDigraphOrContext(arg[1]) then
    file := GraphvizName(arg[1]);
    for i in [1 .. Length(file)] do
      if not IsAlphaChar(file[i]) and not IsDigitChar(file[i]) then
        file[i] := '_';
      fi;
    od;
    arg[1] := AsString(arg[1]);
  else
    file := "vizpicture";
  fi;
  str := arg[1];

  opt := rec();
  if IsBound(arg[2]) and IsRecord(arg[2]) then
    opt := arg[2];
  elif IsBound(arg[2]) then
    ErrorNoReturn("the 2nd argument must be a record");
  fi;

  path := UserHomeExpand("~/");
  if IsBound(opt.path) then
    path := opt.path;
  fi;
  if not EndsWith(path, "/") then
    path := Concatenation(path, "/");
  fi;

  if IsBound(opt.directory) or IsBound(opt.path) then
    if not IsDirectoryPath(path) then
      ErrorNoReturn("the directory \"", path, "\" does not exist");
    fi;
    subdir := "tmp.viz";
    if IsBound(opt.directory) then
      subdir := opt.directory;
    fi;
    if not subdir in DirectoryContents(path) then
      GV_RunProgram(DirectoryCurrent(), "mkdir", ["-p", Concatenation(path, subdir)]);
    fi;
    dir := Concatenation(path, subdir, "/");
  else
    tdir := DirectoryTemporary();
    dir := Filename(tdir, "");
  fi;

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

  Info(InfoGraphviz, 1, "Splash: rendering ", inn, " to ", out,
       " and opening it with ", viewer);
  FileString(inn, str);
  if type = "latex" then
    GV_RunProgram(Directory(dir), "pdflatex", [file]);
  else
    GV_RunProgram(DirectoryCurrent(), engine,
                  [Concatenation("-T", filetype), inn, "-o", out]);
  fi;

  # Only a shell can start the viewer in the background. The viewer and the
  # file reach it as $0 and $1, so they need no quoting.
  GV_RunProgram(DirectoryCurrent(), "sh",
                ["-c", "\"$0\" \"$1\" >/dev/null 2>&1 &", viewer, out]);
end);
