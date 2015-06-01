require 'rspec'
require 'jekyll'
require 'jekyll/wikidata'

RSpec.configure do |config|
	config.run_all_when_everything_filtered = true
	config.filter_run :focus
	config.order = 'random'

	SOURCE_DIR = File.expand_path("../fixtures", __FILE__)
	DEST_DIR = File.expand_path("../dest", __FILE__)

	def source_dir(*files)
		File.join(SOURCE_DIR, *files)
	end

	def dest_dir(*files)
		File.join(DEST_DIR, *files)
	end
end