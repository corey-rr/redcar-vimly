
module Redcar
  class Vimly
    class DeleteCommand < Redcar::EditTabCommand
      def self.regex
        /^d$/
      end

      def self.description
        "Nuke selection"
      end

      def execute(params)
        if doc.selection?
          doc.replace_selection('')
        end
      end
    end

    class GoToLine < Redcar::EditTabCommand
      def self.regex
        /^g(\d+)$/
      end

      def self.description
        "Go to a line in a document"
      end

      def execute(params)
        options = params[:options]
        raise "No parameters given" unless options
        line = [[options.first.to_i - 1,doc.line_count].min,0].max
        doc.cursor_offset = doc.offset_at_line(line)
      end
    end

    class SelectCommand < Redcar::EditTabCommand
      def self.regex
        /^s(\d*)(c|w|l)$/
      end

      def self.description
        "Select text by a number of characters, words, or lines"
      end

      def execute(params)
        options = params[:options]
        raise "No parameters given" unless options
        offset  = doc.cursor_offset
        count   = options.first.empty? ? 1 : [options.first.to_i,0].max
        type    = options.last
        case type
        when "c"
          end_offset = [offset+count,doc.length].min
        when "l"
          current_line = doc.line_at_offset(offset)
          end_offset   = doc.offset_at_line_end([current_line+count,doc.line_count].min)
        when "w"
          end_offset = doc.word_range_at_offset(offset).last
          (1..count).each do |i|
            end_offset = doc.word_range_at_offset(end_offset + 1).last
          end
        end
        doc.set_selection_range(offset, end_offset)
      end
    end

    class SelectLinesCommand < Redcar::EditTabCommand
      def self.regex
        /^sl(\d+)-(\d+)$/
      end

      def self.description
        "Select a number of lines in a document"
      end

      def execute(params)
        options = params[:options]
        raise "No parameters given" unless options
        line1 = options.first.to_i - 1
        line2 = options.last.to_i - 1
        first = [[[line1,line2].min,doc.line_count].min,0].max
        last  = [[[line1,line2].max,doc.line_count].min,0].max
        first_offset = doc.offset_at_line(first)
        end_offset   = doc.offset_at_line_end(last)
        doc.set_selection_range(first_offset,end_offset)
      end
    end
  end
end