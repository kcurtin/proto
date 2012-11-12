module Proto
  class Scraper
    attr_accessor :doc

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

    def fetch_and_create!(name='Type', args)
      attributes = scrape_attribute_data(args)
      create_return_objects(name, attributes)
    end

  private

    def scrape_attribute_data(attributes)
      attributes.each_with_object({}) do |(key, selector), attrs|
        attrs[key] = doc.css(selector).text
      end
    end

    def create_return_objects(name, attributes)
      new_class = Class.new(OpenStruct)
      Proto.const_set(name, new_class)
      Proto.const_get(name).new(attributes)      
    end
  end
end