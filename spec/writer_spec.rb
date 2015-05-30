require 'spec_helper'

RSpec.describe Jekyll::Wikidata::Writer do

  it "can have a map" do
    p = Jekyll::Wikidata::Writer.new({
      "P18": "image"
    })

    expect(p.map[:P18]).to eq("image")
  end

end

