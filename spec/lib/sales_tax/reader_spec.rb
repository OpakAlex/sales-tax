require_relative "../../../lib/sales_tax/reader"
describe "Reader" do
  it "reads file correct" do
    reader = SalesTax::Reader.new("input-1.txt")
    expect(reader.items).to eq ["1 book at 12.49", "1 music CD at 14.99", "1 chocolate bar at 0.85"]
    expect(reader.filename).to eq "input-1.txt"
  end
end
