require 'spec_helper'

RSpec.describe Jekyll::Wikidata::Writer do

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
  end

end

