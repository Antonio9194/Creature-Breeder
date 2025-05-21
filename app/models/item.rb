# frozen_string_literal: true

# Items Model
class Item
  attr_reader :id, :name, :quantity, :description

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @quantity = attributes[:quantity]
    @description = attributes[:description]
    # Key Items, Healing, Capture, Money, Badges
  end

  def to_s
    "#{@quantity}x #{@name}"
  end

  CREAFLOP = Item.new(
    id: 1,
    name: 'Creaflop',
    quantity: 10,
    description: 'Item used to capture Creatures'
  )
end
