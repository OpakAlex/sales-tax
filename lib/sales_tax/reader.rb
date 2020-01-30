module SalesTax
  class Reader
    attr_reader :items, :filename

    def initialize(filename)
      @filename = filename
      @items = read_file!
    end

    private

    def read_file!
      File.open(Dir.pwd + "/inputs/" + filename).to_a
        .map(&:chomp)
    end
  end
end
