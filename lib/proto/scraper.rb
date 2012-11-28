module Proto
  class Scraper
    attr_accessor :doc, :url_collection

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

    def collect_urls(selector)
      @url_collection = doc.css(selector).map(&:link['href'])
    end

    def fetch(name='Type', args)
      if url_collection
        visit_urls_and_fetch(args)
      else
        attributes = scrape_attribute_data(args)
        protos     = create_return_objects(name, attributes)
        return protos
      end
    end
    alias_method :fetch_and_create!, :fetch

  private
    def scrape_attribute_data(attributes)
      length_of_scrape = @doc.css(attributes.first[1]).count

      final_array = length_of_scrape.times.map do |index|
        attributes.inject(Hash.new) do |hash, (attr_name, selector)|
          hash.merge(attr_name => @doc.css(selector)[index].text.strip) if doc.css(selector)[index]
        end
      end

      final_array.compact
    end

    def visit_urls_and_fetch(attributes)
      url_collection.each do |url|
        page  = Nokogiri::HTML(open(url))

        hash = attributes.each_with_object({}) do |(key, selector), attrs|
          attrs[var_name] = page.css(selector).text.strip
        end
      end
    end

    def create_return_objects(name, attributes)
      new_class = Class.new(OpenStruct)
      Proto.const_set(name, new_class)
      attributes.map { |hash| Proto.const_get(name).new(hash) }
    end
  end
end
