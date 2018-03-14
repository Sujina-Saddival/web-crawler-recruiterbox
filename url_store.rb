class UrlStore

  def initialize(url_file)
    @urls = extract_urls(url_file)
  end

  def urls
    return @urls 
  end

  private

  def extract_urls(url_file)
    urls = []
    File.readlines(url_file).each do |url|
      urls << url.chomp
    end
    return urls
  end

end
