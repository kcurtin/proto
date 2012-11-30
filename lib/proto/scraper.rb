module Proto
  class Scraper
    attr_accessor :url, :doc, :url_collection

    def initialize(url)
      @url = url.chomp '/' #remove trailing slash
      @doc = Nokogiri::HTML(open(url))
    end

    def collect_urls(selector)
      @url_collection = doc.css(selector).map do |link|
        "#{url}#{link['href']}"
      end
    end

    def fetch(name='Type', args)
      if url_collection
        attributes = scrape_multiple_pages(args)
      else
        attributes = scrape_single_page(args)
      end
      protos = create_return_objects(name, attributes)
      return protos
    end
    alias_method :fetch_and_create!, :fetch

  private

    def scrape_multiple_pages(attributes)
      url_collection.map do |url, hash_array|
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