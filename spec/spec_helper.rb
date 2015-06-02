require 'rspec'
require 'jekyll'
require 'jekyll-wikidata'
require 'fileutils'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  FIXTURES_DIR = File.expand_path("../fixtures", __FILE__)
  SOURCE_DIR = File.expand_path("../source", __FILE__)
  DEST_DIR = File.expand_path("../dest", __FILE__)

  def create_source_dir
    FileUtils.rm_rf(source_dir)
    FileUtils.cp_r(FIXTURES_DIR, SOURCE_DIR)
  end

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end

  def dest_dir(*files)
    File.join(DEST_DIR, *files)
  end

  def capture_stdout
    $old_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.rewind
    return $stdout.string
  ensure
    $stdout = $old_stdout
  end
end
