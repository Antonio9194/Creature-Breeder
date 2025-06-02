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
    puts "\n#{@name}        #{@emoji}x #{@quantity}"
    puts "#{@description}"
  end

  def to_h
    {
      name: @name,
      emoji: @emoji,
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
    description: 'is an item used to heal up to 100 HP'
  )

  def use_potion
    healed = [@creature.max_health - @creature.health, 100].min
    @creature.health += healed
    puts "\n#{@creature.name} was healed for #{healed} HP! Now at #{@creature.health}/#{@creature.max_health} HP."
  end

  MONEY = Item.new(
    name: 'Trins',
    emoji: '💰',
    quantity: 1,
    description: 'is the currency used to purchase items.'
  )
end
