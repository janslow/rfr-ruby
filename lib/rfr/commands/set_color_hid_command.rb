module RFR::Commands
  class SetColorHidCommand < HidCommand
    attr_reader :color

    def initialize color
      @color = color
    end

    def to_s
      "Set color: RGB(#{@color[:red]}, #{@color[:green]}, #{@color[:blue]})"
    end
  end
end