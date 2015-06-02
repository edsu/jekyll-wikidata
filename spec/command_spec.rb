require 'spec_helper'

RSpec.describe(Jekyll::Commands::Wikidata) do

  let(:overrides) do 
    {
      "source" => source_dir,
      "destination" => dest_dir,
      "url" => "http://example.org",
      "wikidata" => {
	"lang" => "eng",
	"claims" => {
	  "P18" => "image",
	  "P569" => "birth",
	  "P570" => "death",
	  "P19" => "birthplace"
	}
      }
    }
  end

  let(:config) do
    Jekyll.configuration(overrides)
  end

  let(:site) { Jekyll::Site.new(config) }

  before(:each) do
    puts "hi"
    #described_class.process
  end

  it "can " do
  end

end
