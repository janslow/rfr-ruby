module RFR::Commands
  class ScreenUpdateHidCommand < HidCommand
    attr_reader :is_updating

    def initialize is_updating
      @is_updating = is_updating
    end

    def to_s
      if @is_updating
        "Updating screen"
      else
        "Finished updating screen"
      end
    end
  end
end