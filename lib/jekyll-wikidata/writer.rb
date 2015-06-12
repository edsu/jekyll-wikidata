require 'cgi'
require 'open-uri'

module Jekyll
  module Wikidata
    class Writer
      def initialize(config)
        @config = config['wikidata'] || {}
        @lang = @config['lang'] || 'en'
        @claims = @config['claims'] || {}

        if @config['image'] and @claims['P18'] == nil
          @claims['P18'] = true
        end
      end

      def write(path, frontmatter, content)
        wikidata = frontmatter['wikidata']
        id = wikidata['id']
	return false if not id 

        item = ::Wikidata::Item.find(id)
        if not item
          puts "Unable to locate Wikidata Item for #{id}"
          return false
        end

        if item.labels[@lang]
          wikidata["label"] = item.labels[@lang]['value']
        else
          wikidata["label"] = ""
        end

        if item.descriptions and item.descriptions[@lang]
          wikidata["description"] = item.descriptions[@lang]['value']
        else
          wikidata["description"] = ""
        end

        @claims.each do |code, name|
          claim = item.property(code)
          if name == true
            name = code
          end
          if claim
            if claim.respond_to? 'title'
              wikidata[name] = claim.title
            elsif claim.respond_to? 'url'
              wikidata[name] = claim.url
            elsif claim.respond_to? 'date'
              wikidata[name] = claim.date.rfc3339
            end
          end
        end

        if @config['image']
          wikidata['image'] = download_image(path, item, @config['image'])
        end

        if @config['summary']
          wikidata['summary'] = get_summary(wikidata['label'], item)
        end

        File.open(path, 'w') { |f|
          f.puts(frontmatter.to_yaml)
          f.puts('---')
          f.puts(content)
        }

      end

      def download_image(path, item, size)
        img = item.property('P18')
        if not img
          return nil
        end

        url_ext = File.extname img.url
        img_path = path.gsub(/\..+?$/, url_ext)
        if File.exist? img_path
          puts "#{img_path} already exists"
          return nil
        end

	img_url = img.url
        open img_path, 'wb' do |file|
	  if size and size.respond_to? :to_i
	    img_url = img.url(size.to_i)
	  end
	  puts "fetching #{img_url}"
          file << open(URI::encode(img_url)).read
        end
        puts "downloaded #{img_url} to #{img_path}"

        return File.basename img_path
      end

      def get_summary(label, item)
        url = URI::encode("https://#{@lang}.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=#{label}")
        resp = JSON.parse(open(url).read)
        page_id = resp['query']['pages'].keys[0]
        return resp['query']['pages'][page_id]['extract']
      end
    end
  end
end
