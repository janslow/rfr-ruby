module RFR
  class Packet
    attr_reader :info, :commands

    def initialize info, commands
      @info = info
      @commands = commands || []
    end
  end
end