module RFR::Parser
  class HidCommandParser
    def self.parse is_console, data
      if is_console
        HidCommandParser::console_parse data
      else
        HidCommandParser::rfr_parse data
      end
    end

    def self.console_parse data
      if data[1] == 144
        viewport, x, y, width, height, fontId, fg_color_scale, bg_color_scale = data.values_at(2..9)
        viewport = @@hid_viewports[viewport] if @@hid_viewports[viewport]
        fg_color_scale *= 16
        bg_color_scale *= 16
        fg_color = { red: fg_color_scale, green: fg_color_scale, blue: 0 }
        bg_color = { red: bg_color_scale, green: bg_color_scale, blue: 0 }
        RFR::Commands::SetupViewportHidCommand.new viewport, x, y, width, height, fontId, fg_color, bg_color
      elsif data[1] == 148
        destination = @@hid_destinations[data[2]] || data[2]
        message = RFR::Parser.parse_string data.drop(3)
        RFR::Commands::DisplayStringHidCommand.new message, destination
      else
        case data[0]
        when 161
          viewport = @@hid_viewports[data[1]] || data[1]
          RFR::Commands::SelectViewportHidCommand.new viewport
        when 162
          color_scale = data[1] * 16
          color = { red: color_scale, green: color_scale, blue: 0 }
          RFR::Commands::SetColorHidCommand.new color
        when 165
          x, y = data.values_at(1,2)
          RFR::Commands::SetPositionHidCommand.new x, y
        when 167
          is_updating = data[1] > 0
          RFR::Commands::ScreenUpdateHidCommand.new is_updating
        when 169
          RFR::Commands::DrawSoftkeyHidCommand.new
        when 195
          RFR::Commands::UnknownHidCommand.new :battery_status, data
        else
          RFR::Commands::UnknownCommand.new :hid_event, data
        end
      end
    end

    def self.rfr_parse data
      event_type_id = RFR::Parser.parse_int data.take(4)
      event_type = @@hid_event_types[event_type_id] || event_type_id
      params_bytes = data.drop(4)

      case event_type
      when :button_down, :button_up
        button_id = RFR::Parser.parse_int params_bytes.take(4)
        button = @@hid_buttons[button_id] || "unknown_#{button_id}"
        RFR::Commands::ButtonHidCommand.new button, event_type == :button_up
      else
        RFR::Commands::UnknownHidCommand.new event_type, params_bytes
      end
    end

    private
    @@hid_event_types = {
      0 => :no_event,
      1 => :online,
      2 => :offline,
      3 => :draw_box,
      4 => :draw_line,
      5 => :bitmap,
      6 => :button_down,
      7 => :button_up,
      8 => :wheel_move,
      9 => :screen_update,
      10 => :setup_viewport,
      11 => :select_viewport,
      12 => :set_color,
      13 => :battery_status,
      14 => :connect,
      15 => :disconnect,
      16 => :io_button_press,
      17 => :midi_input,
      18 => :apn_input,
      19 => :dmx_output,
      20 => :midi_output,
      21 => :apn_output,
      22 => :port_speed,
      23 => :icon,
      24 => :draw_battery,
      25 => :draw_softkey_grid,
      26 => :unicode,
      27 => :setup_softkeys,
      28 => :softkey_text,
      29 => :set_font,
      30 => :flush
    }
    @@hid_buttons = {
      4 => '@',
      8 => '7',
      9 => '8',
      10 => '9',
      11 => 'Thru',
      12 => '4',
      13 => '5',
      14 => '6',
      15 => '-',
      16 => '1',
      17 => '2',
      18 => '3',
      19 => '+',
      20 => 'C',
      21 => '0',
      22 => '.',
      23 => '*'
    }
    @@hid_viewports = {
      0 => 'prompt',
      1 => 'mode',
      2 => 'selected object',
      3 => 'object type',
      4 => 'objected value'
    }
    @@hid_destinations = {
      0 => 'selected viewport',
      1 => 'softkey 1',
      2 => 'softkey 2',
      3 => 'softkey 3',
      4 => 'softkey 4',
      5 => 'softkey 5',
      6 => 'softkey 6'
    }
  end
end