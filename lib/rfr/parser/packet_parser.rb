require 'xmlsimple'

module RFR::Parser
  class PacketParser
    def self.load_xml xmlString, friendly_hostnames = {}
      xml = XmlSimple.xml_in(xmlString)
      messages = xml['packet'].collect do |packet|
        protocols = PacketParser::parse_xml packet, friendly_hostnames
      end
    end
    def self.parse_xml packet, friendly_hostnames
      info = {}
      commands = []
      bytes = []
      packet['proto'].each do |proto|
        case proto["name"]
        when "frame"
          proto['field'].each do |field|
            case field['name']
            when 'frame.time_relative'
              info[:time] = field['show'].to_f
            when 'frame.number'
              info[:number] = field['show'].to_i
            end
          end
        when "ip"
          proto['field'].each do |field|
            case field['name']
            when 'ip.src'
              info[:src] = field['show']
            when 'ip.dst'
              info[:dst] = field['show']
            end
          end
          info[:src_friendly] = friendly_hostnames[info[:src]]
          info[:dst_friendly] = friendly_hostnames[info[:dst]]
        when "tcp"
          proto['field'].each do |field|
            case field['name']
            when 'tcp.srcport'
              info[:srcport] = field['show'].to_i
            when 'tcp.dstport'
              info[:dstport] = field['show'].to_i
            end
          end
        when "fake-field-wrapper"
          bytes = proto['field'].first['field'].select{ |f| f['name'] == 'data.data' }
          .map { |h| h['show'] }.first.split(':').map(&:hex)
        end
      end
      is_console = info[:srcport] == 3031
      info[:src_friendly] = (is_console ? 'EOS' : 'rfr') unless info[:src_friendly]
      while bytes.length > 0
        commands.push RFR::Parser::CommandParser::parse(is_console, bytes)
      end
      return RFR::Packet.new info, commands
    end
  end
end