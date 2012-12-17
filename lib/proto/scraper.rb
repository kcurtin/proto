module Proto
  class Scraper
    attr_accessor :url, :doc, :url_collection, :traverse, :page_count

    def initialize(url)
      @url = url.chomp '/' #remove trailing slash
      @doc = Nokogiri::HTML(open(url))
      @page_count     = 1
      @url_collection = []
    end

    def collect_urls(base_url=self.url, pagination_selector=nil, url_selector)
      number_of_pages = doc.css(pagination_selector).map.count if pagination_selector

      page_urls = doc.css(url_selector).map do |link|
        "#{base_url}#{link['href']}"
      end

      if pagination_selector && (@page_count < number_of_pages)
        next_url = base_url + doc.css(pagination_selector)[page_count]['href']
        doc = Nokogiri::HTML(open(next_url))
        @page_count += 1

        url_collection << page_urls
        collect_urls(base_url, pagination_selector, url_selector)
      else
        url_collection << page_urls
        url_collection.flatten!
      end
    end

    def fetch(name='Type', args)
      if url_collection.empty?
        attributes = scrape_single_page(args)
      else
        attributes = scrape_multiple_pages(args)
      end
      protos = create_return_objects(name, attributes)
      return protos
    end
    alias_method :fetch_and_create!, :fetch

  private

    def scrape_multiple_pages(attributes)
      url_collection.map do |url|
         gather_data(url, attributes)
      end
    end
    
    def gather_data(url, attributes)
      page = Nokogiri::HTML(open(url))
      attributes.each_with_object({}) do |(key, selector), attrs|
        attrs[key] = page.css(selector).text.strip
      end
    end

    def scrape_single_page(attributes)
      length_of_scrape = doc.css(attributes.first[1]).count
      
      length_of_scrape.times.map do |index|
        attributes.inject({}) do |hash, (attr_name, selector)|
          hash.merge(attr_name => doc.css(selector)[index].text.strip) if doc.css(selector)[index]
        end
      end.compact
    end

    def create_return_objects(name, attributes)
      new_class = Class.new(OpenStruct)
      Proto.const_set(name, new_class)
      attributes.map { |hash| Proto.const_get(name).new(hash) }
    end
  end
end
