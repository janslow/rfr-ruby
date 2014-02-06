require 'term/ansicolor'
class String
    include Term::ANSIColor
end

require 'rfr/commands'
require 'rfr/packet'
require 'rfr/parser'
require 'rfr/reader'