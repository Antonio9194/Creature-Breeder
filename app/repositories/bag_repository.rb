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

  def [](index)
    @bag[index]
  end

  def show_bag_items
    @bag
  end

  def add_item_to_bag(item)
    @bag << item
  end

  def items_count
    @bag.count
  end
end
