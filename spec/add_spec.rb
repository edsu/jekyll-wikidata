require 'spec_helper'

RSpec.describe(Jekyll::Commands::AddWikidata) do

  before :each do
    create_source_dir
  end


  it "can populate page front matter with wikidata" do
    overrides = {
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
    config = Jekyll.configuration(overrides)
    site = Jekyll::Site.new(config)
    described_class.process(args=[], options=overrides)

    # create new site object and see that frontmatter was populated
    new_site = Jekyll::Site.new(config)
    new_site.read

    page = new_site.pages.select {|p| p.path == "authors/joyce.md"}[0]
    expect(page).to be_truthy
    expect(page['wikidata']['id']).to eq("Q6882")
    expect(page['wikidata']['label']).to eq("James Joyce")
  end

end