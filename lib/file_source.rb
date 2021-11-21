require 'mechanize'

class FileSource
  def initialize
    @agent             = Mechanize.new
    @agent.redirect_ok = false
    @last_fetch        = nil
    @uri               = nil
    @site              = nil
    @page              = nil
  end

  def download_content(url)
    @page       = @agent.get(url.to_s)

    while %w(301 302).include?(@page.code)
      @page = @agent.get(@page.header['location'])
    end

    @uri        = @page.uri
    @site       = @uri.host
    @last_fetch = Time.now.utc

    @page.body
  end

  def fname
    @page.nil? ? '' : "#{@uri.host}.html"
  end

  def metadata
    return {} unless @last_fetch

    metadata = {
      site:       @site,
      num_links:  @page.links.size,
      images:     @page.images.size,
      last_fetch: @last_fetch.strftime("%a %b %d %Y %H:%M %Z"),
    }
  end
end
