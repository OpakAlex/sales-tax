require_relative "../../../lib/sales_tax/calculator"
describe "Calculator" do
  before do
    @input = [
      {
        count: 1,
        imported: false,
        name: "book",
        price: 12.49,
        taxable: false,
        total: 12.49
      },
      {
        count: 1,
        imported: false,
        name: "music CD",
        price: 14.99,
        taxable: true,
        total: 14.99
      },
      {

        count: 1,
        imported: false,
        name: "chocolate bar",
        price: 0.85,
        taxable: false,
        total: 0.85
      }
    ]
  end

  it "calculates item taxes" do
    calculator = SalesTax::Calculator.new(@input)
    calculator.calculate
    expect(calculator.items).to eq([
      {
        total: 12.49,
        imported: false,
        taxable: false,
        name: "book",
        count: 1,
        price: 12.49,
        basic_tax: 0.0,
        import_tax: 0.0,
        sales_tax: 0.0
      },
      {
        total: 16.49,
        imported: false,
        taxable: true,
        name: "music CD",
        count: 1,
        price: 14.99,
        basic_tax: 1.5,
        import_tax: 0.0,
        sales_tax: 1.5
      },
      {
        total: 0.85,
        imported: false,
        taxable: false,
        name: "chocolate bar",
        count: 1,
        price: 0.85,
        basic_tax: 0.0,
        import_tax: 0.0,
        sales_tax: 0.0
      }
    ])
  end

  it "calculates totals" do
    calculator = SalesTax::Calculator.new(@input)
    calculator.calculate
    expect(calculator.total).to eq 29.83
    expect(calculator.sales_tax).to eq 1.5
  end
end
