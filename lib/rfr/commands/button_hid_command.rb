module RFR::Commands
  class ButtonHidCommand < HidCommand
    attr_reader :button, :is_up

    def initialize button, is_up
      @button = button
      @is_up = is_up
    end

    def to_s
      "#{@button} #{@is_up ? 'up' : 'down'}"
    end
  end
end