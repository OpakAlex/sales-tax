module SalesTax
  class Printer

    # TODO create a factory for different devices, make one class absrtract as base
    # out of task scope

    attr_reader :output, :type, :calculator

    def initialize(calculator, type = :console)
      @output = []
      @calculator = calculator
      @type = type
    end

    def print
      generate_output
      display_to_devise
    end

    def generate_output
      generate_items(calculator.items, output)
      generate_totals(calculator.sales_tax, calculator.total, output)
    end

    def generate_items(items, list)
      items.each do |item|
        list << "#{item[:count]} #{item[:name]}: #{"%.2f" % item[:total]}"
      end
    end

    def generate_totals(sales_tax, total, list)
      list << "Sales Total: #{"%.2f" % sales_tax}"
      list << "Total: #{"%.2f" % total}"
    end

    def display_to_devise
      case type
      when :console
        console
      else
        raise 'not recognized devise'
      end
    end

    def console
      puts output
      true
    end
  end
end
