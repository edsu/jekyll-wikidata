module Jekyll
  module Commands
    class Wikidata < Command

      def self.init_with_program(prog)
	prog.command(:wikidata) do |c|
	  c.syntax "wikidata"
	  c.description "Populate wikidata frontmatter"
	  c.action do |args, options|
	    self.process(args, options)
	  end
	end
      end

      def self.process(args=[], options={}) 
	config = configuration_from_options(options)
	site = Jekyll::Site.new(config)
	#puts site.methods
	for posts in site.posts
	  puts posts
	end
      end

    end
  end
end
