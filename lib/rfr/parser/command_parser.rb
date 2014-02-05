module RFR::Parser
  class CommandParser
    def self.parse is_console, bytes
      length = RFR::Parser.parse_int(bytes.shift 4) - 1
      type = @@rfr_command_types[bytes.shift]
      data_bytes = bytes.shift length
      return CommandParser::parse_command is_console, type, data_bytes
    end

    def self.parse_command is_console, type, data
      case type
      when :connect
        parse_connect_command is_console, data
      when :select_channel
        parse_select_channel_command data
      when :hid_event
        if is_console
          RFR::Commands::UnknownCommand.new type, data
        else
          HidCommandParser::parse data
        end
      else
        RFR::Commands::UnknownCommand.new type, data
      end
    end

    def self.parse_select_channel_command data
      system = RFR::Parser.parse_int data.take(4)
      channel = RFR::Parser.parse_int data.values_at(4..7)

      return RFR::Commands::SelectChannelCommand.new system, channel
    end

    def self.parse_connect_command is_console, data
      if is_console
        name = RFR::Parser.parse_string data.values_at(2..-2)
      else
        parts = RFR::Parser.parse_string(data).split(0.chr)
        password = parts.first
        name = parts.last
      end

      return RFR::Commands::ConnectCommand.new is_console, name, password
    end

    @@rfr_command_types = {
      0 => :unknown,
      1 => :hid_event,
      2 => :connect,
      3 => :disconnect,
      4 => :channel_listen,
      5 => :params_absolute,
      6 => :params_delta,
      7 => :param_mode_coarse,
      8 => :param_mode_fine,
      9 => :select_channel,
      10 => :next,
      11 => :last,
      12 => :flip,
      13 => :params_home,
      14 => :params_min,
      15 => :params_max,
      16 => :get_cues,
      17 => :cue_list,
      18 => :stop,
      19 => :go,
      20 => :goto_cue,
      21 => :next_cue,
      22 => :last_cue,
      23 => :select_cue,
      24 => :follow_active_cue,
      25 => :params_range,
      26 => :heartbeat
    }
  end
end