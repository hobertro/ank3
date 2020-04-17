module Ank3
  class Collection
    attr_reader :cards, :data, :basename

    def initialize(file)
      @basename = File.basename(file, ".yml")
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

    def write_to_file(name = "")
      file_name = name != "" ? name : @basename
      File.open("#{file_name}.txt", "w") do |file|
        file.write(convert)
        file
      end
    end

    def self.generate_boilerplate_file(file_name = "ank3.yml", number = 1)
      array_of_hashes = []
      number.to_i.times do 
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
      new_file = convert_yaml_to_double_quotes!(file_name)
      File.open(file_name, "w") do |file|
        file.write(new_file)
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

    def self.convert_yaml_to_double_quotes!(file)
      # https://stackoverflow.com/questions/18316333/how-do-i-force-double-quotes-when-dumping-yaml
      File.read(file).gsub("'", "\"")
    end
  end
end