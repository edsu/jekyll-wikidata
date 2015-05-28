require "jekyll/wikidata/version"
require 'wikidata'

module Jekyll::Wikidata

  class Generator < Jekyll::Generator
    
    def generate(site)
      for page in site.pages
	if page['wikidata_id']
	  process(page)
	end
      end
    end

    def process(page)
      id = page['wikidata_id']
      e = Wikidata::Item.find(id)
      puts e.property 'P18'
    end

  end
end
