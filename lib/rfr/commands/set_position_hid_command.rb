module RFR::Commands
  class SetPositionHidCommand < HidCommand
    attr_reader :x, :y

    def initialize x, y
      @x = x
      @y = y
    end

    def to_s
      "Set position: (#{x},#{y})"
    end
  end
end