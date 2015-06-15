module Jekyll
  module Commands
    class AddWikidata < Command

      def self.init_with_program(prog)
        prog.command(:add_wikidata) do |c|
          c.syntax "wikidata"
          c.description "Populate wikidata frontmatter"
          c.action do |args, options|
            self.process(args, options)
          end
        end
      end

      def self.process(args=[], options={})
        config = configuration_from_options(options)
        writer = Jekyll::Wikidata::Writer.new(config)

        site = Jekyll::Site.new(config)
        site.reset
        site.read

	# process pages
        for page in site.pages
	  if page['wikidata_id']
	    puts "processing #{page.path}"
	    path = File.join(site.source, page.path)
	    writer.write(path, page.data, page.content)
	  end
        end

	# process collections
	site.collections.each do |coll_name, coll| 
	  for doc in coll.docs
	    if doc.data['wikidata_id']
	      writer.write(doc.path, doc.data, doc.content)
	    end
	  end
	end
      end

    end
  end
end
