require_relative './lib/sales_tax/runner'

filename = ARGV.first

SalesTax::Runner.new(filename).execute
