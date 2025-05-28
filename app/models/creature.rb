# frozen_string_literal: true

# Creature class, mold for creatures
class Creature
  attr_reader :name, :species, :element, :rarity, :abilities
  attr_accessor :discovered, :owned, :xp, :xp_needed, :level, :health

  def initialize(name, species, element, attributes = {})
    @name = name
    @species = species
    @element = element
    @level = attributes[:level] || 1
    @xp = attributes[:xp] || 0
    @xp_needed = attributes[:xp_needed] || 100
    @rarity = attributes[:rarity]
    @health = attributes[:health] || @level * 10
    self.abilities = attributes[:abilities] || generate_abilities
    @discovered = attributes.fetch(:discovered, false)
    @owned = attributes.fetch(:owned, false)
  end

  def abilities=(abilities_array)
    @abilities = abilities_array.map do |a|
      if a.is_a?(Hash)
        a.transform_keys(&:to_sym) # Convert string keys to symbols for consistency
      else
        { name: a.to_s, power: 0, type: 'Normal' } # fallback if just strings
      end
    end
  end

  def self.from_h(hash)
    Creature.new(
      hash['name'],
      hash['species'],
      hash['element'],
      {
        level: hash['level'],
        xp: hash['xp'],
        xp_needed: hash['xp_needed'],
        rarity: hash['rarity'],
        health: hash['health'],
        abilities: hash['abilities'],
        discovered: hash['discovered'],
        owned: hash['owned']
      }
    )
  end

  def to_h
    {
      name: @name,
      species: @species,
      element: @element,
      level: @level,
      xp: @xp,
      xp_needed: @xp_needed,
      rarity: @rarity,
      health: @health,
      abilities: @abilities,
      discovered: @discovered,
      owned: @owned
    }
  end

  def discover
    @discovered = true
  end

  def own
    @owned = true
  end

  def marks
    discovered_mark = @discovered ? '✅' : '❌'
    owned_mark = @owned ? '✅' : '❌'
    [discovered_mark, owned_mark]
  end

  def info
    ability_names = @abilities.map { |a| a[:name] }.join(', ')
    "Name: #{@name}, Species: #{@species}, Element: #{@element}, " \
    "Level: #{@level}, Rarity: #{@rarity}, Health: #{@health}, " \
    "Abilities: #{ability_names}"
  end

  def entry_info
    discovered_mark, owned_mark = marks
    "👾 #{@name} is a #{@rarity} #{@element} #{@species}! Discovered: #{discovered_mark} Owned: #{owned_mark}"
  end

  def gain_xp(amount)
    @xp += amount
    level_up while @xp >= @xp_needed
  end

  def level_up
    @xp -= @xp_needed
    @level += 1
    @xp_needed = (@level**1.5 * 100).to_i
    @health = @level * 10  # Optionally increase health on level up
    puts "#{@name} leveled up to level #{@level}!"
  end

  def generate_abilities
    case @element
    when 'Fire'
      [
        { name: 'Flame Roar', power: 5, type: 'Fire' },
        { name: 'Ignite', power: 4, type: 'Fire' },
        { name: 'Firestorm', power: 6, type: 'Fire' },
        { name: 'Ember Swipe', power: 3, type: 'Fire' },
        { name: 'Spark', power: 2, type: 'Fire' }
      ]
    when 'Water'
      [
        { name: 'Water Blast', power: 5, type: 'Water' },
        { name: 'Bubble Jet', power: 3, type: 'Water' },
        { name: 'Tsunami', power: 7, type: 'Water' },
        { name: 'Aqua Whip', power: 4, type: 'Water' },
        { name: 'Soak', power: 2, type: 'Water' }
      ]
    when 'Earth'
      [
        { name: 'Stone Punch', power: 4, type: 'Earth' },
        { name: 'Pebble Toss', power: 3, type: 'Earth' },
        { name: 'Quake Slam', power: 6, type: 'Earth' },
        { name: 'Mud Shield', power: 2, type: 'Earth' },
        { name: 'Dust Cloud', power: 1, type: 'Earth' }
      ]
    when 'Air'
      [
        { name: 'Wind Slash', power: 4, type: 'Air' },
        { name: 'Screech', power: 3, type: 'Air' },
        { name: 'Sky Dive', power: 6, type: 'Air' },
        { name: 'Feather Storm', power: 5, type: 'Air' },
        { name: 'Gust', power: 2, type: 'Air' }
      ]
    when 'Electric'
      [
        { name: 'Thunder Fang', power: 5, type: 'Electric' },
        { name: 'Spark Surge', power: 4, type: 'Electric' },
        { name: 'Volt Tackle', power: 6, type: 'Electric' }
      ]
    when 'Ice'
      [
        { name: 'Blizzard Beam', power: 6, type: 'Ice' },
        { name: 'Frostbite', power: 4, type: 'Ice' },
        { name: 'Ice Shard', power: 3, type: 'Ice' }
      ]
    when 'Rock'
      [
        { name: 'Stonewall', power: 4, type: 'Rock' },
        { name: 'Boulder Crush', power: 6, type: 'Rock' },
        { name: 'Pebble Shot', power: 3, type: 'Rock' }
      ]
    when 'Dark'
      [
        { name: 'Shadow Lunge', power: 5, type: 'Dark' },
        { name: 'Night Slash', power: 6, type: 'Dark' },
        { name: 'Phantom Claw', power: 4, type: 'Dark' }
      ]
    else
      [
        { name: 'Basic Attack', power: 3, type: 'Normal' }
      ]
    end
  end

  # Damage scales with level * power of ability
  def calculate_damage(ability)
    damage = (@level * ability[:power])  # simple scaling
    damage = 1 if damage < 1 # always at least 1 damage
    damage
  end
end
