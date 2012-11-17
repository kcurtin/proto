module Proto
  class Scraper
    attr_accessor :doc

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

    def fetch_and_create!(name='Type', args)
      attributes = scrape_attribute_data(args)
      protos     = create_return_objects(name, attributes)
      return protos
    end

  private
    def scrape_attribute_data(attributes)
      collection = Array.new(attributes.length, [])
      final_array = []
      keys = attributes.keys

      attributes.each_with_index do |(key, selector), index|
        collection[index] = doc.css(selector).slice(1..10).map { |el| el.text.strip }
      end

      collection.transpose.each do |data|
        hash = {}
        data.each_with_index do |value, index|
          hash[keys[index]] = value
        end
        final_array << hash
      end
      final_array
    end

    def create_return_objects(name, attributes)
      new_class = Class.new(OpenStruct)
      Proto.const_set(name, new_class)
      attributes.map { |hash| Proto.const_get(name).new(hash) }
    end
  end
end