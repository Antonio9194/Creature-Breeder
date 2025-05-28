# frozen_string_literal: true

require 'io/console'
require_relative '../models/creapedia'
require_relative '../models/creature'

require_relative '../repositories/player_creapedia_repository'

# Wild Encounters Logic
class WildEncounter
  def self.encounter(current_location, creapedia, player_creapedia)
    creature_pool = {
      'Route 1' => {
        creatures: %w[Howlit Craggit],
        level_range: (1..3)
      },
      'Route 2' => {
        creatures: %w[Granitox Gryvorn],
        level_range: (3..5)
      }
    }

    area_data = creature_pool[current_location]
    return puts 'No wild creatures found here.' unless area_data

    chosen_name = area_data[:creatures].sample
    base_creature = creapedia.find_by_name(chosen_name)
    return puts "Creature #{chosen_name} not found in Creapedia!" unless base_creature

    wild_creature = base_creature.dup
    wild_creature.level = rand(area_data[:level_range])
    wild_creature.health = wild_creature.level * 10
    wild_creature.xp = 0
    wild_creature.xp_needed = 100
    wild_creature.abilities = wild_creature.abilities.sample(2)
    wild_creature.discovered = true

    player_creapedia.add_to_creapedia(wild_creature)

    puts "\n🌿 A wild #{wild_creature.name} appeared at level #{wild_creature.level}!"
    wild_creature
  end
end
