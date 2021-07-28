require 'pry'
require 'terminal-table'
require './price_calculator'

class Main
  include PriceCalculator

  def initialize(items)
    @items = items
  end

  def print_items
    puts "################ INVOICE #######################"
    @items_hash = @items.uniq.inject({}) { |items, ele| items[ele] = @items.count(ele); items }
    print_table
  end

  def print_table
    rows = []
    rows << ["Item", "Qauntity", "Unit Price", "Item Total"]
    rows << :separator
    
    @items_hash.to_a.collect{|line_item| rows << item_row(line_item) }
    total_of_all = total(rows)
    rows << :separator
    rows << ["Total", nil, nil, total_of_all]
    table = Terminal::Table.new :rows => rows
    puts table
  end

end

puts "Enter items"
t = []
5.times do 
  t << gets.chomp()
end
main = Main.new(t)
main.print_items
