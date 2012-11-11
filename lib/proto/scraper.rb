module Proto
  class Scraper
    require 'open-uri'
    require 'ostruct'

    attr_accessor :url

    def initialize(url)
      @url = url
    end

    def go!(name='Proto::Type', attributes)
      name = OpenStruct.new
    end
  end
end