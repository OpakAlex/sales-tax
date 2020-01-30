require_relative "../../../lib/sales_tax/builder"
describe "Builder" do
  it "parses builds correct items from reader output" do
    input = ["1 book at 12.49", "1 music CD at 14.99", "1 chocolate bar at 0.85"]
    builder = SalesTax::Builder.new(input)
    expect(builder.build).to eq([
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
    ])
  end
end
