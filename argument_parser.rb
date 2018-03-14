require 'getoptlong'

class ArgumentParser
  attr_reader :crawl_depth, :page_limit, :url_file

  def initialize
    unless ARGV.length >= 1
      information
      exit
    end
    # to fetch the command line argument
    @opts = GetoptLong.new(
      ["--crawl-depth", "-d", GetoptLong::OPTIONAL_ARGUMENT],
      ["--page-limit", "-l", GetoptLong::OPTIONAL_ARGUMENT]
    )
    @crawl_depth = 2
    @url_file = 'urls.txt'
  end

  def information
    # if the input is wrong
    puts 'Run this command where -d stands for crawl depth and -l stands for page limit'
    puts "ruby main.rb -d 3 -l 100"
  end

  def parse_arguments
    # to assign the value
    @opts.each do |opt, arg|
      case opt
      when '--crawl-depth'
        @crawl_depth = arg.to_i
      when '--page-limit'
        @page_limit = arg.to_i
      end
    end
  end

end
