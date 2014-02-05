module RFR
  module Commands
    require 'rfr/commands/command'
    
    require 'rfr/commands/connect_command'
    require 'rfr/commands/select_channel_command'
    require 'rfr/commands/unknown_command'

    require 'rfr/commands/hid_command'
    
    require 'rfr/commands/button_hid_command'
    require 'rfr/commands/unknown_hid_command'
  end
end