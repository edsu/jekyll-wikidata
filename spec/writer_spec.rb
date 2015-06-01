require 'spec_helper'

RSpec.describe Jekyll::Wikidata::Writer do

  let(:overrides) do 
    {
      "source"        => source_dir,
      "destination"   => dest_dir,
      "url"           => "http://example.org"
    }
  end

  let(:config) do
    Jekyll.configuration(overrides)
  end

  let(:site) { Jekyll::Site.new(config) }
  before(:each) do
    site.process
  end

  it "can be configured" do
    w = Jekyll::Wikidata::Writer.new(
      lang = "eng",
      claims = {
        "P18"  => "image",
      	"P569" => "birth",
      	"P570" => "death",
      	"P19"  => "birthplace"
      }
    )
    expect(w.lang).to eq("eng")
    expect(w.claims["P18"]).to eq("image")
  end

  it "defaults to English" do 
    w = Jekyll::Wikidata::Writer.new()
    expect(w.lang).to eq("eng")
  end

  it "can write a file" do
    w = Jekyll::Wikidata::Writer.new()
  end

end