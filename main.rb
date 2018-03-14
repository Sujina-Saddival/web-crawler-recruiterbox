require './web'
require './argument_parser'
require './url_store'
require 'pry'

# to access the argument passed
argument_parser = ArgumentParser.new
argument_parser.parse_arguments

# web crawles queue
web = Web.new
url_store = UrlStore.new(argument_parser.url_file)
web.crawl_web(url_store.urls, argument_parser.crawl_depth, argument_parser.page_limit)