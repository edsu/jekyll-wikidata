module Jekyll
  module Commands
    class Wikidata < Command

      def self.init_with_program(prog)
	prog.command(:wikidata) do |c|
	  c.syntax "wikidata"
	  c.description "Populate wikidata frontmatter"
	  c.action do |args, options|
	    Jekyll::Commands:Wikidata.process(args, options)
	  end
	end
      end

      def self.process(args=[], options={}) 
	puts 'hi'
      end

    end
  end
end
