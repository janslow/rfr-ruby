module RFR::Commands
  class UnknownCommand < Command
    attr_reader :type, :data

    def initialize type, data
      @type = type
      @data = data
    end

    def to_s
      data_s = @data.map(&:chr).join.gsub(/[^[:print:]]/i, '_')
      "UNKNOWN: #{@type}: #{@data.to_s}/#{data_s}"
    end
  end
end