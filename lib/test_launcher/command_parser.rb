require "optparse"
# This could use some love

class CommandParser
  BANNER = <<-DESC
Find tests and run them by trying to match an individual test or the name of a test file(s).

Usage: `test_launcher "search string" [--all]`

  DESC

  def initialize(args)
    @search_query = args
    @options = {}
    option_parser.parse!(args)
  end

  def search_query
    if @search_query.size == 0
      puts "Please enter a search string"
      exit
    elsif @search_query.size > 1
      puts "Currently test_launcher only supports one search string.  Wrap the search terms in quotes to run them as a single search"
      exit
    end

    @search_query.first
  end

  def options
    @options
  end

  private

  def option_parser
    OptionParser.new do |opts|
      opts.banner = BANNER

      opts.on("-A", "--all", "Run all matching tests") do
        options[:run_all] = true
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end
  end
end
