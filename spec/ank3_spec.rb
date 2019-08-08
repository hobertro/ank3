require 'rspec'
require 'json'
require 'yaml'
require 'pry'
require 'ank3'

RSpec.describe Ank3 do
  let(:data) do
    {
      "front" => "What is 1+1?",
      "back" => "Two",
      "tags" => ["test1", "test2"]
    }
  end

  describe "Card" do
    context "convert" do
      it "converts data to a string" do
        expect(Ank3::Card.new(data).convert).to eq "What is 1+1?; Two\n"
      end
    end
  end
  
  describe "Collection" do
    let(:card) { Ank3::Card.new(data) }
    let(:collection) { Ank3::Collection.new("./spec/example.yml") }

    context "#add_card" do
      it "adds a card to the card collection" do
        expect { collection.add_card(card) }.to change { collection.cards.count }.by(1)
      end
    end
    context "#convert" do
      it "converts data to a string" do
        3.times { collection.add_card(card) }
        expect(collection.convert).to eq "What is 1+1?; Two\nWhat is H2O?; Water\nWhat is 1+1?; Two\nWhat is 1+1?; Two\nWhat is 1+1?; Two\n"
      end
    end
    context "convert_data_to_cards" do
      it "converts YAML data to cards do" do
        expect { collection.send(:convert_data_to_cards) }.to change { collection.cards.count }.by(2)
      end
    end
    context "#write_to_file" do
      it "writes the strings to a file" do
        response = collection.write_to_file
        expect(File.read(response)).to eq "What is 1+1?; Two\nWhat is H2O?; Water\n"
      end
      context "front or back is empty" do
        it "does not create the card" do
          collection.add_card(Ank3::Card.new({"front" => "", "back" => ""}))
          response = collection.write_to_file
          expect(File.read(response)).to eq "What is 1+1?; Two\nWhat is H2O?; Water\n"
        end
      end
    end
    context "#generate_boilerplate_file" do
      context "YAML" do
        it "generates a boilerplate YAML file" do
          response = Ank3::Collection.generate_boilerplate_file
          expect(YAML.load(File.read(response))).to eq [{ "front" => "", "back" => "", "tags" => []}]
        end
      end
    end
  end
end