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

UrlEntity := function(name, url)
  return StringFormatted("""<Alt Not="Text"><URL Text="{1}">{2}</URL></Alt>
    <Alt Only="Text"><Package>{1}</Package></Alt>""", name, url);
end;

PackageEntity := function(name)
  if TestPackageAvailability(name) <> fail then
    return UrlEntity(PackageInfo(name)[1].PackageName,
                     PackageInfo(name)[1].PackageWWWHome);
  fi;
  return StringFormatted("<Package>{1}</Package>", name);
end;

if fail = LoadPackage("AutoDoc", "2022.10.20") then
    Error("AutoDoc version 2022.10.20 or newer is required.");
fi;

XMLEntities := rec();

XMLEntities.GAPGraphviz := PackageEntity("Graphviz");
XMLEntities.PyGraphviz := UrlEntity("graphviz",
                                    "https://pypi.org/project/graphviz/");
XMLEntities.DOT := UrlEntity("DOT",
                            "https://www.graphviz.org/doc/info/lang.html");
XMLEntities.Graphviz := UrlEntity("Graphviz", "https://www.graphviz.org");

AutoDoc("graphviz",
rec(scaffold := rec(entities := XMLEntities),
    autodoc := true,
    extract_examples := true,
));

Unbind(PackageEntity);
Unbind(UrlEntity);
Unbind(XMLEntities);
QUIT;
