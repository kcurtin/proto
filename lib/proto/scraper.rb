module Proto
  class Scraper
    require 'open-uri'
    require 'ostruct'

    attr_accessor :url

    def initialize(url)
      @url = url
    end

    def go!(name='Type', attributes)
      new_class = Class.new(OpenStruct)
      Proto.const_set(name, new_class)
      Proto.const_get(name).new(attributes)
    end
  end
end