require 'yaml'
require 'ank3/card'

module Ank3
  class Collection
    attr_reader :cards, :data

    def initialize(file)
      @data  = YAML.load(File.read(file))
      @cards = []
      convert_data_to_cards
    end

    def add_card(card)
      @cards << card
    end 

    def convert
      @cards.map { |card| card.convert if front_and_back_present?(card) }.join("")
    end

    def write_to_file(name = "cards")
      File.open("#{name}.txt", "w") do |file|
        file.write(convert)
        file
      end
    end

    def self.generate_boilerplate_file(number = 1, file_name = "Ank3.yml")
      array_of_hashes = []
      number.times do 
        array_of_hashes << {
          "front" => "",
          "back"  => "",
          "tags"  => []
        }
      end
      File.open(file_name, "w") do |file|
        file.write(array_of_hashes.to_yaml)
        file
      end
    end

    private 

    def convert_data_to_cards
      data.each do |hash|
        add_card(Ank3::Card.new(hash))
      end
    end

    def front_and_back_present?(card)
      !card.front.empty? && !card.back.empty?
    end
  end
end