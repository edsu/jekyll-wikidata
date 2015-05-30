module Jekyll::Wikidata

  class Writer

    attr_reader :map

    def initialize(map)
      @map = map
    end
    
    def write(page)
      id = page['wikidata_id']
      e = Wikidata::Item.find(id)
      puts e.property 'P18'
    end

  end
end
