# frozen_string_literal: true

# Bag Reepository
class BagRepo
  include Enumerable
  attr_reader :bag

  def initialize(bag = [])
    @bag = bag
  end

  def each(&block)
    @bag.each(&block)
  end

  def self.from_h(array_of_hashes)
    items = array_of_hashes.map { |item_hash| Item.new(item_hash.transform_keys(&:to_sym)) }
    new(items)
  end

  def [](index)
    @bag[index]
  end

  def show_bag_items
    @bag
  end

  def add_item_to_bag(item, amount = 1)
    if @bag.include?(item)
      item.increase_quantity(amount)
    else
      @bag << item
    end
  end

  def items_count
    @bag.count
  end
end
