module Jekyll
  module Wikidata
    class Writer
      def initialize(config)
        @config = config
      end

      def write(path, data, content)
        #TODO: do the wikidata lookups here!
        data["wikidata"]["label"] = "James Joyce"
        File.open(path, 'w') { |f|
          f.puts(data.to_yaml)
          f.puts('---')
          f.puts(content)
        }
      end
    end
  end
end