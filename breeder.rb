# frozen_string_literal: true

require_relative 'creature'
require_relative 'creapedia'

# Mold for bred creatures
class Breeder
  def initialize(creapedia)
    @creapedia = creapedia
  end

  def breed(creature_name1, creature_name2)
    creature1 = @creapedia.find_by_name(creature_name1)
    creature2 = @creapedia.find_by_name(creature_name2)

    if creature1 && creature2
      breed_name = (creature1.name[0..3] + creature2.name[0..3]).chars.shuffle.join.capitalize
      breed_species = [creature1.species, creature2.species].sample
      breed_element = [creature1.element, creature2.element].sample
      breed_level = rand(1..5)
      breed_rarity = [creature1.rarity, creature2.rarity].sample
      breed_health = breed_level * 10
      breed_abilities = [creature1.abilities[0], creature2.abilities[0]].sample

      new_creature = Creature.new(
        breed_name,
        breed_species,
        breed_element,
        {
          level: breed_level,
          rarity: breed_rarity,
          health: breed_health,
          abilities: [breed_abilities],
          discovered: true,
          owned: true
        }
      )
      @creapedia.add_creature(new_creature)
      p new_creature.info

      puts "Successfully bred a new creature: #{new_creature.name}!"
    else
      puts 'Error: One or both creatures not found in Creapedia!'
    end
  end
end
