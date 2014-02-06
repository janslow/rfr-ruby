module RFR::Commands
  class SelectViewportHidCommand < HidCommand
    attr_reader :destination

    def initialize destination
      @destination = destination
    end

    def to_s
      "Select Viewport: #{@destination.yellow}"
    end
  end
end