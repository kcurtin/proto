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
    #[{:title => "the title", :name => "the name"}, {:title => 'something', :name => 'name2'}]
    def scrape_attribute_data(attributes)
      array_content = []
      array_name    = []
      array_date    = []

      attributes.each_with_index do |(key, selector), index|
        doc.css(selector).slice(1..10).each do |el|
          array_content << el.text.strip if key == :content
          array_name << el.text.strip if key == :name
          array_date << el.text.strip if key == :created_at
        end
      end
      master_array = []
      0.upto(array_name.length - 1) do |n|
        master_array << {attributes.keys[0] => array_name[n], attributes.keys[1] => array_content[n], attributes.keys[2] => array_date[n]}
      end
      master_array
    end

    def create_return_objects(name, attributes)
      new_class = Class.new(OpenStruct)
      Proto.const_set(name, new_class)
      attributes.map { |hash| Proto.const_get(name).new(hash) }
    end
  end
end