#############################################################################
##
##  splash.gd
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This function is transplanted from the Digraphs package to here. The original
# function was written by A. Egri-Nagy and Manuel Delgado, with some minor
# modifications by J. Mitchell.

#! @ChapterInfo Full Reference, Outputting
#! @Arguments x[, opts]
#! @Returns Nothing.
#! @Description
#! This function attempts to convert the string <A>str</A> into a pdf
#! document and open this document, i.e. to splash it all over your monitor.<P/>
#!
#! The argument <A>x</A> must be one of: TODO
#!
#! must correspond to a valid <C>dot</C> or
#! <C>LaTeX</C> text file and you must have have <C>GraphViz</C> and
#! <C>pdflatex</C> installed on your computer.  For details about these file
#! formats, see <URL>https://www.latex-project.org</URL> and
#! <URL>https://www.graphviz.org</URL>.<P/>
#!
#! The optional second argument <A>opts</A> should be a record with
#! components corresponding to various options, given below.
#!
#! <List>
#!   <Mark>path</Mark>
#!   <Item>
#!     this should be a string representing the path to the directory where
#!     you want <C>Splash</C> to do its work. The default value of this
#!     option is <C>"~/"</C>.
#!   </Item>
#!
#!   <Mark>directory</Mark>
#!   <Item>
#!     this should be a string representing the name of the directory in
#!     <C>path</C> where you want <C>Splash</C> to do its work. This function
#!     will create this directory if does not already exist. <P/>
#!
#!     The default value of this option is <C>"tmp.viz"</C> if the option
#!     <C>path</C> is present, and the result of
#!     <Ref Func="DirectoryTemporary" BookName="ref"/> is used otherwise.
#!   </Item>
#!
#!   <Mark>filename</Mark>
#!   <Item>
#!     this should be a string representing the name of the file where
#!     <A>str</A> will be written.  The default value of this option is
#!     <C>"vizpicture"</C>.
#!   </Item>
#!
#!   <Mark>viewer</Mark>
#!   <Item>
#!     this should be a string representing the name of the program which
#!     should open the files produced by <C>GraphViz</C> or <C>pdflatex</C>.
#!   </Item>
#!
#!   <Mark>type</Mark>
#!   <Item>
#!     this option can be used to specify that the string <A>str</A> contains
#!     a &LaTeX; or <C>dot</C> document. You can specify this option in
#!     <A>str</A> directly by making the first line <C>"%latex"</C> or
#!     <C>"//dot"</C>.  There is no default value for this option, this
#!     option must be specified in <A>str</A> or in <A>opt.type</A>.
#!   </Item>
#!
#!   <Mark>engine</Mark>
#!   <Item>
#!     this option can be used to specify the GraphViz engine to use
#!     to render a <C>dot</C> document. The valid choices are <C>"dot"</C>,
#!     <C>"neato"</C>, <C>"circo"</C>, <C>"twopi"</C>, <C>"fdp"</C>,
#!     <C>"sfdp"</C>, and <C>"patchwork"</C>. Please refer to the
#!     GraphViz documentation for details on these engines.
#!     The default value for this option is <C>"dot"</C>, and it
#!     must be specified in <A>opt.engine</A>.
#!   </Item>
#!
#!   <Mark>filetype</Mark>
#!   <Item>
#!     this should be a string representing the type of file which
#!     <C>Splash</C> should produce. For &LaTeX; files, this option is
#!     ignored and the default value <C>"pdf"</C> is used.
#!   </Item>
#! </List>
#!
#! This function was originally written by Attila Egri-Nagy and Manuel Delgado,
#! the present version incorporates some minor changes.<P/>
#! @BeginLogSession
#! gap> TODO
#! gap> Splash();
#! @EndLogSession
DeclareGlobalFunction("Splash");
