
require 'vimly/app_commands'
require 'vimly/doc_commands'
require 'vimly/run_commands'

module Redcar
  class Vimly
    def self.menus
      Redcar::Menu::Builder.build do
        sub_menu "Plugins" do
          sub_menu "Vimly" do
            item "Open Vimly", OpenVimly
          end
        end
      end
    end

    def self.keymaps
      map = Redcar::Keymap.build("main", [:osx, :linux, :windows]) do
        link "Alt+M", OpenVimly
      end
      [map]
    end

    def self.commands
      [
        SelectCommand,
        SelectLinesCommand,
        RunCommand,
        RunRuby,
        GoToLine,
        DeleteCommand,
        UndoCommand,
        EditFileCommand,
        HelpCommand
      ]
    end

    def self.parse text
      command = commands.detect {|c| text =~ c.regex }
      if command
        text  =~ command.regex
        command = command.new
        options = { :options => Regexp.last_match.captures }
        command.run(options)
      end
    end

    class OpenVimly < Redcar::Command
      def execute
        if win = Redcar.app.focussed_window
          win.open_speedbar(Vimly::Bar.new)
        end
      end
    end

    class Bar < Redcar::Speedbar
      label :label, ':'

      textbox :command

      button :execute, 'Run', 'Return' do
        unless command.value.empty?
          Vimly.parse(command.value)
          command.value = ''
        end
      end
    end
  end
end