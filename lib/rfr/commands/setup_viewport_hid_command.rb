module RFR::Commands
  class SetupViewportHidCommand < HidCommand
    attr_reader :viewport, :x, :y, :width, :height, :font, :fg_color, :bg_color

    def initialize viewport, x, y, width, height, font, fg_color, bg_color
      @viewport = viewport
      @x = x
      @y = y
      @width = width
      @height = height
      @font = font
      @fg_color = fg_color
      @bg_color = bg_color
    end

    def to_s
      "Setup Viewport: id #{@viewport.yellow}, position (#{@x},#{@y}), size (#{@width}, #{@height}), font #{@font}, foreground RGB(#{@fg_color[:red]}, #{@fg_color[:green]}, #{@fg_color[:blue]}), background RGB(#{@bg_color[:red]}, #{@bg_color[:green]}, #{@bg_color[:blue]})"
    end
  end
end