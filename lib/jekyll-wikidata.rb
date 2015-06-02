require 'yaml'
require 'jekyll'
require 'wikidata'

require 'jekyll-wikidata/version'
require 'jekyll/commands/wikidata'

module Jekyll
  module Wikidata
    class Writer
      def initialize(config)
        @config = config
      end

      def write(path, data, content)
        File.open(path, 'w') { |f|
          f.puts(data.to_yaml)
          f.puts('---')
          f.puts(content)
        }
      end
    end
  end
end
