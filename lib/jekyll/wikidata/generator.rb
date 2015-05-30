module Jekyll::Wikidata

  class Generator < Jekyll::Generator
    
    def generate(site)
      for page in site.pages
	if page['wikidata_id']
	  puts(page)
	end
      end
    end

  end
end
