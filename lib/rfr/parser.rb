module RFR
  module Parser
    require 'rfr/parser/command_parser'
    require 'rfr/parser/hid_command_parser'
    require 'rfr/parser/packet_parser'

    def Parser.parse_int bytes
      bytes.reverse.reduce(0) { |sum,i| (sum << 8) + i}
    end
    def Parser.parse_string data
      data.values_at(* data.each_index.select(&:even?)).map(&:chr).join
    end
  end
end