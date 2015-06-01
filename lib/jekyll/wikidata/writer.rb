module Jekyll::Wikidata

  class Writer

    attr_reader :claims, :lang

    def initialize(lang="eng", claims={})
      @lang = lang
      @claims = claims 
    end
    
    def write(page)
      id = page['wikidata_id']
      e = Wikidata::Item.find(id)
      puts e.property 'P18'
    end

  end
end
