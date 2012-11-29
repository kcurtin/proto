module Proto
  class Scraper
    attr_accessor :url, :doc, :url_collection

    def initialize(url)
      @url = url.chomp '/'
      @doc = Nokogiri::HTML(open(url))
    end

    def collect_urls(selector)
      @url_collection = doc.css(selector).map do |link|
        "#{url}#{link['href']}"
      end
    end

    def fetch(name='Type', args)
      if url_collection
        puts 'fetching the collection...'
        visit_urls_and_fetch(args)
      else
        attributes = scrape_attribute_data(args)
        protos     = create_return_objects(name, attributes)
        return protos
      end
    end
    alias_method :fetch_and_create!, :fetch

  private

    def visit_urls_and_fetch(attributes)
      final_array = url_collection.map do |url|
        page  = Nokogiri::HTML(open(url))
        attrs_hash = scrape_attribute_data(page, attributes)
      end
      create_return_objects('Bee',final_array)
    end
    
    def gather_data
      job_hash = args.each_with_object({}) do |(key, selector), attrs|
        attrs[var_name] = job_doc.css(selector).text.strip
      end

      job_hash
    end

    def scrape_attribute_data(document=self.doc, attributes)
      length_of_scrape = document.css(attributes.first[1]).count
      final_array = length_of_scrape.times.map do |index|
        attributes.inject(Hash.new) do |hash, (attr_name, selector)|
          hash.merge(attr_name => document.css(selector)[index].text.strip) if document.css(selector)[index]
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
