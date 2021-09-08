require 'terminal-table'

class Product
  UNIT_PRICE = {'bread'=>60, 'egg'=>40, 'milk'=>60, 'tea'=>150 }
  SALE_PRICE = {'bread'=> { quantity: 3, price: 150}, 'egg'=> { quantity: 2, price: 70} }
end

class LineItem
  attr_accessor :item_name, :unit_price, :quantity, :discounted_total, :gross_total

  def initialize(item_name, unit_price, quantity, gross_total, discounted_total, invoice)
    @item_name = item_name
    @unit_price = unit_price
    @quantity = quantity
    @discounted_total = discounted_total
    @gross_total = gross_total
    @invoice = invoice
  end

  def discounted_price
    self.discounted_total = case self.item_name
                            when 'bread'
                              calculate_dicounted_price(self.quantity, self.unit_price, Product::SALE_PRICE['bread'][:quantity], Product::SALE_PRICE['bread'][:price])
                            when 'egg'
                              calculate_dicounted_price(self.quantity, self.unit_price, Product::SALE_PRICE['egg'][:quantity], Product::SALE_PRICE['egg'][:price])
                            when 'milk'
                              calculate_dicounted_price(self.quantity, self.unit_price)
                            else
                              calculate_dicounted_price(self.quantity, self.unit_price)
                            end
  end

  private

    def calculate_dicounted_price(item_qtty, item_unit_price, discounted_qtty=nil, discount_amt=0)
      if discounted_qtty && item_qtty >= discounted_qtty
        sale_qtty = item_qtty / discounted_qtty
        sale_price = sale_qtty * discount_amt
        excluded_qtty = item_qtty % discounted_qtty
        excluded_price = excluded_qtty * item_unit_price
        sale_price + excluded_price
      else
        item_qtty * item_unit_price
      end
    end

end

class Invoice
  attr_accessor :line_items, :gross_total, :discounted_total

  def initialize
    @gross_total = 0
    @discounted_total = 0
    @line_items = []
  end

  def add_line_items(item_name, unit_price, quantity, gross_total)
    line_item = LineItem.new(item_name, unit_price, quantity, gross_total, 0, self.object_id)
    @line_items << line_item
    line_item
  end

  def total_gross_price
    self.line_items.inject(0) {|sum, hash| sum + hash.gross_total}
  end

  def total_sale_price
    self.line_items.inject(0) {|sum, hash| sum + hash.discounted_total}
  end

  def print_items
    puts "################ INVOICE #######################"
    rows = []
    rows << ["Item", "Qauntity", "Price"]
    rows << :separator
    
    self.line_items.collect{|item| rows << [item.item_name, item.quantity, "Rs.#{item.discounted_total}"] }
    table = Terminal::Table.new :rows => rows
    puts table
    puts "Total price: Rs.#{self.total_sale_price.round(2)}"    
    puts "You saved: Rs.#{(self.total_gross_price - self.total_sale_price).round(2)} today"
  end

end

p "bread, egg, milk, tea" 
puts 
puts "Enter items: choose from above list"
entered_items = []
9.times do 
  entered_items << gets.chomp()
end

puts "Entered item: #{entered_items.join(', ')}"
invoice = Invoice.new

item_with_quantity = entered_items.uniq.inject({}) { |items, ele| items[ele] = entered_items.count(ele); items }

entered_items.uniq.each do |item|
  if Product::UNIT_PRICE.keys.include?(item)
    item_name = item
    unit_price = Product::UNIT_PRICE[item]
    quantity = item_with_quantity[item]
    gross_total = (unit_price * quantity).round(2)
    line_item = invoice.add_line_items(item_name, unit_price, quantity, gross_total)
    discounted_total = line_item.discounted_price
  end
end

invoice.print_items
