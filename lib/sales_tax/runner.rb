require_relative './reader'
require_relative './builder'
require_relative './calculator'
require_relative './printer'

module SalesTax
  class Runner
    def initialize(filename)
      @filename = filename
    end

    def execute
      items = Reader.new(@filename).items
      builder = Builder.new(items)
      calculator = Calculator.new(builder.build).calculate
      Printer.new(calculator).print
    end
  end
end
