module RFR::Commands
  class DisplayStringHidCommand < HidCommand
    attr_reader :message, :destination

    def initialize message, destination
      @message = message
      @destination = destination
    end

    def to_s
      "Print '#{@message.green}' in #{@destination}"
    end
  end
end