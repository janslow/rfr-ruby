module RFR::Commands
  class SelectChannelCommand < Command
    attr_reader :system, :channel

    def initialize system, channel
      @system = system
      @channel = channel
    end

    def to_s
      "Select Channel #{@channel}"
    end
  end
end