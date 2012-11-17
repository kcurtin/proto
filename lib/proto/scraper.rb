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
      length_of_scrape = @doc.css(attributes.first[1]).count

      final_array = length_of_scrape.times.map do |i|
        attributes.inject(Hash.new) do |hash, (k, v)|
          hash.merge(k => @doc.css(v)[i].text.strip) if doc.css(v)[i]
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
