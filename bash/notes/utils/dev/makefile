=H= Overview

The «make» utility automatically determines which pieces of a large program need to be recompiled, and issues commands to recompile them.
It reads a file called «Makefile» that describes relationships between files and the commands to update them.

=H= Makefile Structure

Makefiles contain five kinds of things:
- «Explicit rules». Specifies when and how to remake one or more files.
- «Implicit rules» . Specifies when and how to remake a class of files based on their names.
- «Variable definitions». A line that specifies a text string value for a variable that can be substituted into the text later.
- «Directives». An instruction for make to do something special while reading the makefile (like reading another makefile).
- «Comments». ‹#› in a line of a makefile starts a comment.

Lines are joined with a backslash ‹\› for continuation.

=H= Explicit rules

Syntax:‹
‹target ... : prerequisites
        recipe
        ...
        ...›

Where:
- «target»: File to be created or action name. Multiple targets can be specified (separated with space).
- «prerequisites»: Files the target depends on (can be none).
- «recipe»: Commands to execute (each line must begin with a tab, not spaces).

When the target is a file, the recipe should be run if:
- The target file does not exist
- Any of its prerequisites change (is more recent)

There can be multiple rules for one target - prerequisites accumulate:‹
target: prerequisites1
target: prerequisites2
    recipe›

Targets that do not refer to files but are just actions are called «phony targets».
«.PHONY» prevents conflicts with files named the same way as target (‹clean› in the example).
‹.PHONY: clean
clean:
    ...›

By default, make starts with the first target (not targets starting with ‘.’ unless they also contain one or more ‘/’).
This is called «the default goal».
You can override this behavior using the command line or with the ‹.DEFAULT_GOAL› special variable.

=H= Implicit rules
