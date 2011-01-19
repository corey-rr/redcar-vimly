#_vimly_

A small set of vim-like commands for the redcar text editor

Features include:

 - Selecting text (by word, character, and line)
 - Go to line
 - Undo
 - Delete selection
 - Running terminal commands*
 - Running ruby commands*

\* optionally uses selected text by replacing `_S_`

###examples

 - `help` displays a list of supported commands and expressions
 - `s4l` selects four lines
 - `s3w` selects three words
 - `g47` moves the cursor to line 47
 - `g6e` moves the cursor to the end of line 6
 - `u3` for undoes the last three actions
 - `d` nukes the current selection
 - `!ls` lists all files in the project directory
 - `i!ls` lists all files in the project directory _and inserts the output into the current document_
 - `r!1+1` does some math via Ruby
 - `ri!1+1` does some math via Ruby _and inserts the output into the current document_

###install

    cd ~/.redcar/plugins
    git clone git://github.com/kattrali/redcar-vimly.git vimly

###run

Menu > Plugins > Vimly > Open Vimly
or, more likely, use the keybinding (currently `Alt+M`, and `Esc` closes the bar)

###todo

 - Finish features
 - Move selection (by word, character, or line)
 - Switching windows
 - Save (all?) files, quit redcar
 - Command history. it would be handy to press the up and down arrows to run previous commands
 - Tab completion for file paths