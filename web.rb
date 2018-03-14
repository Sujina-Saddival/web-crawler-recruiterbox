require 'open-uri'
require 'hpricot'
require './url_utils'
require 'pry'

class Web
  include UrlUtils
  
  def initialize
    @visited_url = {}
  end

  def crawl_web(urls, depth=2, page_limit = 100)
    depth.times do
      visited_url = []
      urls.each do |url|
        url_object = open_url(url)
        next if url_object == nil
        url = update_url_if_redirected(url, url_object)
        parsed_url = parse_url(url_object)
        next if parsed_url == nil
        @visited_url[url]=true if @visited_url[url] == nil
        return if @visited_url.size == page_limit
        visited_url += (serach_href_on_page(parsed_url, url)-@visited_url.keys)
        visited_url.uniq!
      end
      urls = visited_url
    end
  end

  private

  def open_url(url)
    url_object = nil
    begin
      url_object = open(url)
    rescue
      puts "Unable to open url: " + url
    end
    return url_object
  end

  def update_url_if_redirected(url, url_object)
    if url != url_object.base_uri.to_s
      return url_object.base_uri.to_s
    end
    return url
  end

  def parse_url(url_object)
    doc = nil
    begin
      doc = Hpricot(url_object)
    rescue
      puts 'Could not parse url: ' + url_object.base_uri.to_s
    end
    puts 'Crawling url ' + url_object.base_uri.to_s
    return doc
  end

  def serach_href_on_page(parsed_url, current_url)
    urls_list = []
    parsed_url.search('a[@href]').map do |x|
      new_url = x['href'].split('#')[0]
      unless new_url == nil
        if new_url.match(/^http/) ? false : true
         new_url = create_absolute_path(current_url, new_url)
        end
        urls_list.push(new_url)
      end
    end
    return urls_list
  end

end


    

