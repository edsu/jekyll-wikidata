require 'uri'
require 'json'
require 'jekyll'
require 'net/http'

module Wikidata

  class Generator < Jekyll::Generator

    def generate(site)
      for page in site.pages
        if page['wikidata_id']
	  id = page['wikidata_id']
	  e = Entity.new(id)
	  puts e.commons_image

	  #puts page.methods
	  #puts page.data

	  #puts page['content']
	  #puts page['path']
        end
      end
    end

  end

  class Entity

    def initialize(id)
      @id = id
      @data = get_wikidata
    end

    def label(lang='en')
      @data['labels'][lang]['value']
    end

    def wiki_title(lang='en')
      site = "#{lang}wiki"
      @data['sitelinks'][site]['title']
    end

    def get_wikidata
      url = "http://www.wikidata.org/wiki/Special:EntityData/#{@id}.json"
      JSON.parse(get(url))['entities'][@id]
    end

    def save_commons_image(path)
    end

    def commons_image
      if @data['claims']['P18']
	return @data['claims']['P18'][0]['mainsnak']['datavalue']['value']
      end
    end

    def get(url)
      Net::HTTP.get(URI.parse(url))
    end

  end

end
