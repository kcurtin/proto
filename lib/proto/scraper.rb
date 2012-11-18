module Proto
  class Scraper
    attr_accessor :doc

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

    def fetch(name='Type', args)
      attributes = scrape_attribute_data(args)
      protos     = create_return_objects(name, attributes)
      return protos
    end

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

    def create_return_objects(name, attributes)
      new_class = Class.new(OpenStruct)
      Proto.const_set(name, new_class)
      attributes.map { |hash| Proto.const_get(name).new(hash) }
    end
  end
end
