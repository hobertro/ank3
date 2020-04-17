module Ank3
  class Cli < Thor
    desc "convert FILE", "Convert a YAML file to an Anki file format"
    def convert(file, file_name = "cards")
      Ank3::Collection.new(file).write_to_file(file_name)
    end

    desc "generate_boilerplate", "Generate a boilerplate YAML file"
    def generate_boilerplate(file_name = "ank3.yml", number = 1)
      Ank3::Collection.generate_boilerplate_file(file_name, number)
    end
  end
end