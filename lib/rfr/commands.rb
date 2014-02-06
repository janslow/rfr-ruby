module RFR
  module Commands
    require 'rfr/commands/command'
    
    require 'rfr/commands/connect_command'
    require 'rfr/commands/select_channel_command'
    require 'rfr/commands/unknown_command'

    require 'rfr/commands/hid_command'
    
    require 'rfr/commands/button_hid_command'
    require 'rfr/commands/display_string_hid_command'
    require 'rfr/commands/draw_softkey_hid_command'
    require 'rfr/commands/select_viewport_hid_command'
    require 'rfr/commands/screen_update_hid_command'
    require 'rfr/commands/set_color_hid_command'
    require 'rfr/commands/set_position_hid_command'
    require 'rfr/commands/setup_viewport_hid_command'
    require 'rfr/commands/unknown_hid_command'
  end
end