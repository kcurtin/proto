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
      attributes.each_with_object([]) do |(key, selector), obj_data|
        doc.css(selector).each do |el|
          obj_data << { key => el.text.strip }
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