module Proto
  class Scraper
    require 'open-uri'
    require 'ostruct'
    require 'nokogiri'

    attr_accessor :doc

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

    def go!(name='Type', attributes)
      create_return_objects(name, attributes)
    end

  private

    def scrape_attribute_data(attributes)
      attribute_hash = attributes.each_with_object({}) do |(key, selector), attrs|
        var_name, option = key.to_s.split("_")
        attrs[var_name]  = doc.css(selector).send(option).strip
      end
    end

    def create_return_objects(name, attributes)
      new_class = Class.new(OpenStruct)
      Proto.const_set(name, new_class)
      Proto.const_get(name).new(attributes)      
    end
  end
end