require 'nokogiri'
require 'uri'
require 'set'
require 'open-uri'

class Sitemaped

  def initialize(url)
    @url = URI.parse(URI.encode(url))
    raise URI::InvalidURIError.new('scheme or host missing') unless @url.scheme and @url.host
    @sitemap = Set.new
  end

  def sitemap
    sitemaps.to_a
  end

  def include?(path)
    sitemaps.include?(path)
  end

  private

  def sitemaps
    return @sitemap.empty? ? @sitemap.merge(robots_sitemap || default_sitemap) : @sitemap
  end

  def robots_sitemap
    @robots_sitemap_urls ||= open("#{@url.scheme}://#{@url.host}/robots.txt").read.scan(/\s*sitemap:\s*([^\r\n]+)\s*$/i).flatten!
  rescue
    @robots_sitemap_urls = []
  ensure
    unless @robots_sitemap_urls.empty?
      return @robots_sitemap_data ||= handle_nested_sitemaps(@robots_sitemap_urls)
    end
  end

  def default_sitemap
    @default_sitemap_data ||= parse_sitemap(load_sitemap("#{@url.scheme}://#{@url.host}/sitemap.xml") || load_sitemap("#{@url.scheme}://#{@url.host}/sitemap.xml.gz"))
  end

  def handle_nested_sitemaps(sitemap_list=[])
    return sitemap_list.map do |sitemap_url|
      load_sitemap(sitemap_url)
    end.compact.map do |sitemap_io|
      parse_sitemap(sitemap_io)
    end.compact.flatten
  end

  def load_sitemap(url=nil)
    sitemap_io = open(url)
  rescue
    return nil
  else
    begin
      return Zlib::GzipReader.new(sitemap_io)
    rescue
      sitemap_io.rewind
      return sitemap_io
    end
  end

  def parse_sitemap(sitemap_io)
    sitemap_data = Nokogiri::HTML(sitemap_io)
    if nested_sitemaps = sitemap_data.xpath("//sitemapindex/sitemap/loc") and !nested_sitemaps.empty?
      return handle_nested_sitemaps(nested_sitemaps.map(&:text).flatten)
    end

    return sitemap_data.xpath("//urlset/url/loc").map(&:text).flatten
  rescue
    nil
  end

end
