#_vimly_

A small subset of vim-like commands for the redcar text editor

Features include:

 - Selecting text (by word, character, and line)
 - Go to line
 - Undo
 - Delete selection
 - Running terminal commands*
 - Running ruby commands*
 - Insert terminal or ruby command output in current document

\* optionally uses selected text by replacing `_S_`

###install

    cd ~/.redcar/plugins
    git clone git://github.com/kattrali/redcar-vimly.git vimly

###run

Menu > Plugins > Vimly > Open Vimly
or, more likely, use the keybinding (currently `Alt+M`, and `Esc` closes the bar)

The `help` command displays a list of supported commands and expressions

###todo

 - Move selection (by word, character, or line)
 - Switching windows
 - Save all files, quit redcar
 - Command history. it would be handy to press the up and down arrows to run previous commands
 - Tab completion for file paths