
module Redcar
  class Vimly
    class RunCommand < Redcar::Command
      def self.regex
        /^(i?)!(.*)$/
      end

      def self.description
        "Run a terminal command as a runnable or insert resulting text in a document (using optional 'i' before '!')"
      end

      def execute(params)
        options = params[:options]
        raise "No parameters given" unless options
        cmd = options.last
        if win = Redcar.app.focussed_window
          if tab = win.focussed_notebook_tab and tab.is_a? Redcar::EditTab
            doc = tab.edit_view.document
            cmd = replace_substitutions(doc,cmd)
          end
        end
        path = '.'
        if project = Redcar::Project::Manager.focussed_project
          path = project.path
        end
        if options.first.empty?
          Redcar::Runnables.run_process(path,cmd,cmd)
        else
          case Redcar.platform
          when :osx, :linux
            cmd = "cd #{path} && #{cmd}"
          when :windows
            cmd = "cd \"#{@path.gsub('/', '\\')}\" & #{cmd}"
          end
          insert_text(doc,`#{cmd}`) if doc
        end
      end

      def replace_substitutions(doc, text)
        text.gsub!('_S_', doc.selected_text || '')
        text
      end

      def insert_text(doc,text)
        begin
          if doc and text
            if doc.selection?
              doc.replace_selection(text)
            else
              doc.insert_at_cursor(text)
            end
          end
        rescue Object => e
          p e.message
        end
      end
    end

    class RunRuby < RunCommand
      def self.regex
        /^r(i?)!(.*)$/
      end

      def self.description
        "Evaluate a ruby expression in a REPL or insert text result in a document (using optional 'i' before '!')"
      end

      def execute(params)
        options = params[:options]
        raise "No parameters given" unless options
        cmd = options.last
        if win = Redcar.app.focussed_window
          if tab = win.focussed_notebook_tab and tab.is_a? Redcar::EditTab
            doc = tab.edit_view.document
            cmd = replace_substitutions(doc,cmd)
          end
          if options.first.empty?
            tab = win.all_tabs.detect do |t|
              t.title == "Ruby REPL" and t.is_a? Redcar::REPL::Tab
            end
            unless tab
              Redcar::Ruby::RubyOpenREPL.new.run
              tab = win.focussed_notebook_tab
            end
            tab.focus
            tab.set_command cmd
            tab.commit_changes
          else
            insert_text(doc,eval(cmd).to_s) if doc
          end
        end
      end
    end
  end
end