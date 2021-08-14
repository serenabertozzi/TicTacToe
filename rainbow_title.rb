require "artii"
require "rainbow"

class RainbowTitle
    def initialize(str, font = "slant")
      @str = str
      @font = font
    end
  
    def to_s
      ascii = Artii::Base.new :font => @font
      title = ascii.asciify(@str).split("\n")
      result = title.map.with_index do |line, i|
        case i
        when 0
          Rainbow(line).red
        when 1
          Rainbow(line).yellow
        when 2
          Rainbow(line).green
        when 3
          Rainbow(line).cyan
        when 4
          Rainbow(line).purple
        end
      end
      result << ""
      result.join("\n")
    end
  end
