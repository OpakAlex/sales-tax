module SalesTax
  class Calculator

    BASIC_TAX = 0.10
    IMPORT_TAX = 0.05
    NEAREST_CENT = 1 / 0.05

    attr_reader :items, :total, :sales_tax

    def initialize(items)
      @items = items
      @total = 0.0
      @sales_tax = 0.0
    end

    def calculate
      calculate_taxes
      calculate_totals
      self
    end

    private

    def calculate_taxes
      items.each do |item|
        item[:basic_tax] = calculate_tax(item[:taxable], item[:total], BASIC_TAX)
        item[:import_tax] = calculate_tax(item[:imported], item[:total], IMPORT_TAX)
        item[:sales_tax] = add_taxes(item[:basic_tax], item[:import_tax])
        item[:total] = add_taxes(item[:basic_tax], item[:import_tax], item[:total])
      end
    end

    def calculate_totals
      @sales_tax = totals(:sales_tax)
      @total = totals(:total)
    end

    def calculate_tax(taxable, total, tax_value)
      return 0.0 unless taxable
      round_tax(total * tax_value)
    end

    def add_taxes(basic_tax, import_tax, total=0)
      total += basic_tax + import_tax
      total.round(2)
    end

    def round_tax(value)
      ((value * NEAREST_CENT).ceil / NEAREST_CENT)
    end

    def totals(type)
      items.map { |item| item[type] }
        .inject(:+).round(2)
    end
  end
end
