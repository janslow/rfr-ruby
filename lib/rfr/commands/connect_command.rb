module RFR::Commands
  class ConnectCommand < Command
    attr_reader :is_console, :name, :password

    def initialize is_console, name, password
      @is_console = is_console
      @name = name
      @password = password
    end

    def to_s
      if @is_console
        "I am the '#{@name}' console"
      else
        "I am a '#{@name}' remote. Your password is '#{@password}'"
      end
    end
  end
end