module Ank3
  class Card
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def front
      data["front"]
    end

    def back
      data["back"]
    end

    def tags
      data["tags"]
    end

    def convert
      "#{front}; #{back}\n" 
    end
  end
end