module PriceCalculator

  UNIT_PRICE = {'milk'=>5, 'egg'=>10, 'bread'=>15, 'tea'=>20 }

  def item_row(item)
    item.push(UNIT_PRICE.dig(item[0]))
    item.push(gross_price_line_item(item))
  end

  def gross_price_line_item(item)
    item[1] * item[2]
  end

  def total(rows)
    rows.drop(2).inject(0){|sum,x| sum + x.last}
  end

end
