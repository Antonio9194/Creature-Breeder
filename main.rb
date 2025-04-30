# frozen_string_literal: true

require_relative 'breeder'
require_relative 'creature'
require_relative 'creapedia'

@starter_creatures = [
  Creature.new('Lavagor', 'Drake', 'Fire', { level: 1, abilities: ['Flame Roar'] }),
  Creature.new('Aqualis', 'Sylph', 'Water', { level: 1, abilities: ['Water Blast'] }),
  Creature.new('Terronox', 'Golem', 'Earth', { level: 1, abilities: ['Stone Punch'] }),
  Creature.new('Fangor', 'Beast', 'Air', { level: 1, abilities: ['Wind Slash'] })
]

creapedia = Creapedia.new
breeder = Breeder.new(creapedia)

# Example usage
breeder.breed('Lavagor', 'Aqualis')
