module SalesTax
  class Builder
    def initialize(raw_items)
      @raw_items = raw_items
    end

    def build
      transform(parsed_list)
    end

    private

    def parse_regex
      /(\d+)\s+(.*)at\s+(\S+)/
    end

    def parsed_list
      @raw_items.map do |item|
        if item =~ parse_regex
          {
            name: $2.strip,
            count: $1.to_i,
            price: $3.to_f
          }
        end.compact
      end
    end

    def transform(list)
      list.map do |item|
        {
          total: calculate_total(item),
          imported: imported?(item),
          taxable: taxable?(item)
        }.merge(item)
      end
    end

    def imported?(item)
      !(item[:name] =~ /(imported)\s/).nil?
    end

    def calculate_total(item)
      item[:count] * item[:price]
    end

    def taxable?(item)
      (item[:name] =~ excluded_tax_regex).nil?
    end

    def excluded_tax_regex
      # todo maybe good idea to create a classifier, but this is out of scope task
      /(book|chocolate|pill)/
    end
  end
end
