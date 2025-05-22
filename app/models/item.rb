# frozen_string_literal: true

# Items Model
class Item
  attr_reader :name, :emoji, :description
  attr_accessor :quantity

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @emoji = attributes[:emoji]
    @quantity = attributes[:quantity]
    @description = attributes[:description]
  end

  def to_s
    puts "\n#{@emoji}#{@name}        x #{@quantity}"
    puts "#{@description}"
  end

  def to_h
    {
      name: @name,
      quantity: @quantity,
      description: @description
    }
  end

  def increase_quantity(amount)
    @quantity += amount
  end

  CREAFLOP = Item.new(
    name: 'Creaflop',
    emoji: '💾',
    quantity: 1,
    description: 'Item used to capture Creatures'
  )

  POTION = Item.new(
    name: 'Potion',
    emoji: '🧪',
    quantity: 1,
    description: 'Item used to heal 10hp'
  )
end
