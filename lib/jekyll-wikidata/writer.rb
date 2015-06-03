module Jekyll
  module Wikidata
    class Writer
      def initialize(config)
        @config = config['wikidata']
        @lang = @config['lang'] || 'en'
        @claims = @config['claims'] || {}
      end

      def write(path, data, content)
        id = data['wikidata']['id']

        w = ::Wikidata::Item.find(id)
        if not w
          puts "Unable to locate Wikidata Item for #{id}"
          return false
        end

        if w.labels[@lang]
          data["wikidata"]["label"] = w.labels[@lang]['value']
        else
          data["wikidata"]["label"] = ""
        end

        if w.descriptions[@lang]
          data["wikidata"]["description"] = w.descriptions[@lang]['value']
        else
          data["wikidata"]["description"] = ""
        end

        @claims.each do |code, name|
          claim = w.property(code)
          if name == true
            name = code
          end
          if claim
            if claim.respond_to? 'title'
              data["wikidata"][name] = claim.title
            elsif claim.respond_to? 'url'
              data["wikidata"][name] = claim.url
            elsif claim.respond_to? 'date'
              data["wikidata"][name] = claim.date.rfc3339
            end
          end
        end

        File.open(path, 'w') { |f|
          f.puts(data.to_yaml)
          f.puts('---')
          f.puts(content)
        }
      end
    end
  end
end