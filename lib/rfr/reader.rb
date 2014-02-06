require 'yaml'

module RFR
  class Reader
    def initialize options = {}
      @options = options

      load_messages
      save_messages
    end

    def print_messages
      @messages.each(&method(:print_message))
    end

    private
    def load_messages
      fileString = File.read @options[:input_path]
      if @options[:input_yaml]
        @messages = YAML.load fileString
      else
        @messages = RFR::Parser::PacketParser.load_xml fileString
      end
    end

    def save_messages
      if @options[:output_yaml]
        @options[:output_path] = @options[:input_path][/^.*\./] + "yaml" unless @options[:output_path]
        File.open(@options[:output_path], 'w') { |f| f.write(@messages.to_yaml) }
      end
    end

    def print_message message
      if @options[:verbose]
        puts message
      else
        return if @options[:filter_rfr] && message.info[:src_friendly] != "rfr"
        format_string = "%-4s\t%9.5f\t"
        pretty_src = sprintf format_string, message.info[:src_friendly].bold, message.info[:time]
        
        message.commands.each do |command|
          puts pretty_src + command.to_s
        end
      end
    end
  end
end