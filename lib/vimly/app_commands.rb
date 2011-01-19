
module Redcar
  class Vimly
    class HelpCommand < Redcar::Command
      def self.regex
        /^help$/
      end

      def self.description
        "Open this help dialog"
      end

      def execute(params)
        if win = Redcar.app.focussed_window
          text = "Vimly Commands\n==============\n\n"
          Vimly.commands.each do |c|
            name = c.to_s.sub('Command','')
            name = name.split('::').last
            name = name.split(/(?=[A-Z])/).map{|w| w}.join(" ")
            text << "#{name}:\n"
            text << "    Description: #{c.description}\n"
            regex_s = c.regex.to_s.gsub('(?-mix:','/')
            regex_s[-1] = '/'
            text << "    Expression : #{regex_s}\n\n"
          end
          tab = win.new_tab(Redcar::EditTab)
          tab.edit_view.document.text = text
          tab.title = "Vimly Cheat Sheet"
          tab.icon  = Redcar::Tab::HELP_ICON
          tab.edit_view.reset_undo
          tab.focus
        end
      end
    end
    class EditFileCommand < Redcar::Command

      def self.regex
        /^e (.*)/
      end

      def self.description
        "Open a file for editing using absolute or project path"
      end

      def execute(params)
        options = params[:options]
        raise "No parameters given" unless options
        path = options.first.lstrip
        unless File.exist? path
          if project = Redcar::Project::Manager.focussed_project
            if File.exist?(File.join(project.path,path))
              path = File.join(project.path,path)
            else
              possible = Dir.glob(File.join(project.path,'**',path,'*'))
              path = possible.first if possible.any?
            end
          end
        end
        Redcar::Project::Manager.open_file(path) if path and File.exist? path
      end
    end
  end
end