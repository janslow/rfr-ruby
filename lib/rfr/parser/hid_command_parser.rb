module RFR::Parser
  class HidCommandParser
    def self.parse is_console, data
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
  end
end