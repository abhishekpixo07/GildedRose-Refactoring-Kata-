class GildedRose
  def initialize(items)
    @items = items
  end

  # Delegates the update responsibility to each item
  def update_quality
    @items.each do |item|
      item.update_quality
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update_quality
    if normal_item?
      if expired?
        decrease_quality(2)
      else
        decrease_quality
      end
    else
      increase_quality
      decrease_sell_in
    end
  end
  

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  private

  def normal_item?
    @name != "Aged Brie" && @name != "Backstage passes to a TAFKAL80ETC concert" && @name != "Sulfuras, Hand of Ragnaros"
  end
  

  def decrease_quality
    @quality -= 1 if @quality.positive?
  end

  def increase_quality
    @quality += 1 if @quality < 50
  end

  def decrease_sell_in
    @sell_in -= 1 unless legendary_item?
  
    @sell_in = 0 if @sell_in.negative?  # Ensure minimum value is 0
  
    if expired?
      normal_item? ? decrease_quality : increase_quality
    end
  end

  def legendary_item?
    @name == "Sulfuras, Hand of Ragnaros, Aged Brie"
  end

  def expired?
    @sell_in < 0
  end

  def decrease_quality(amount = 1)
    @quality -= amount if @quality.positive?
  end
end
