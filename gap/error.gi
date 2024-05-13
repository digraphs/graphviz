#############################################################################
##
##  error.gi
##  Copyright (C) 2024                                      James Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

BindGlobal("NumberOfSubstrings",
function(string, substring)
  local pos, count;

  pos := 0;
  count := 0;
  while pos <= Length(string) and pos <> fail do
    pos := PositionSublist(string, substring, pos);
    if pos <> fail then
      count := count + 1;
    fi;
  od;
  return count;
end);

InstallGlobalFunction(ErrorFormatted,
function(arg...)
  local pos, fmt, n, msg;

  pos := PositionProperty(arg, x -> not IsString(x));
  if pos = fail then
    pos := Length(arg) + 1;
  fi;
  fmt := Concatenation(arg{[1 .. pos - 1]});
  n := NumberOfSubstrings(fmt, "{}");
  arg := Concatenation([Concatenation(arg{[1 .. Length(arg) - n]})],
                       arg{[Length(arg) - n + 1 .. Length(arg)]});
  msg := CallFuncList(StringFormatted, arg);
  # RemoveCharacters(msg, "\\\n");
  ErrorInner(
      rec(context := ParentLVars(GetCurrentLVars()),
          mayReturnVoid := false,
          mayReturnObj := false,
          lateMessage := "type 'quit;' to quit to outer loop",
          printThisStatement := false),
      [msg]);
end);
