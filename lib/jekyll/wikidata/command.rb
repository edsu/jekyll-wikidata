module Jekyll::Wikidata
  class Command < Jekyll::Command
  	class << self
  		def init_with_program(prog)
  			prog.command(:wikidata) do |c|
  				c.syntax "wikidata"
  				c.description "Populate wikidata frontmatter"
  				c.action do |args, options|
  					puts "hi"
  				end
  			end
  		end
  	end
  end
end