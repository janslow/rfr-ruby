module RFR::Commands
  class UnknownHidCommand < HidCommand
    attr_reader :event_type, :params

    def initialize event_type, params
      @event_type = event_type
      @params = params
    end

    def to_s
      params_s = @params.map(&:chr).join.dump
      "UNKNOWN EVENT #{@event_type} #{@params.to_s}/#{params_s}".red
    end
  end
end