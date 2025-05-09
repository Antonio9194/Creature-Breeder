# frozen_string_literal: true

# Creature class, mold for creatures
class Creature
  attr_reader :name, :species, :element, :level, :rarity, :health, :abilities
  attr_accessor :discovered, :owned

  def initialize(name, species, element, attributes = {})
    @name = name
    @species = species
    @element = element
    @level = attributes[:level] || 1
    @rarity = attributes[:rarity]
    @health = attributes[:health] || level * 10
    @abilities = attributes[:abilities] || [generate_abilities]
    @discovered = attributes.fetch(:discovered, false)
    @owned = attributes.fetch(:owned, false)
  end

  def self.from_h(hash)
    Creature.new(
      hash['name'],
      hash['species'],
      hash['element'],
      {
        level: hash['level'],
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
      rarity: @rarity,
      health: @health,
      abilities: @abilities,
      discovered: @discovered,
      owned: @owned
    }
  end

  def marks
    discovered_mark = @discovered ? '✅' : '❌'
    owned_mark = @owned ? '✅' : '❌'
    [discovered_mark, owned_mark]
  end

  def info
    "Name: #{@name}, Species: #{@species}, Element: #{@element}, " \
    "Level: #{@level}, Rarity: #{@rarity}, Health: #{@health}, " \
    "Abilities: #{@abilities.join(', ')}"
  end

  def entry_info
    discovered_mark, owned_mark = marks
    "#{@name} is a #{@rarity} #{@element} #{@species}! Discovered: #{discovered_mark} Owned: #{owned_mark}"
  end

  # def to_s
  #   "#{@name} - Discovered: #{@discovered ? '✅' : '❌'}, Owned: #{@owned ? '✅' : '❌'}"
  # end

  def generate_abilities
    case @element
    when 'Fire'
      ['Flame Roar', 'Ignite', 'Firestorm', 'Ember Swipe', 'Spark']
    when 'Water'
      ['Water Blast', 'Bubble Jet', 'Tsunami', 'Aqua Whip', 'Soak']
    when 'Earth'
      ['Stone Punch', 'Pebble Toss', 'Quake Slam', 'Mud Shield', 'Dust Cloud']
    when 'Air'
      ['Wind Slash', 'Screech', 'Sky Dive', 'Feather Storm', 'Gust']
    when 'Electric'
      ['Thunder Fang']
    when 'Ice'
      ['Blizzard Beam']
    when 'Rock'
      ['Stonewall']
    when 'Dark'
      ['Shadow Lunge']
    else
      ['Basic Attack']
    end.sample
  end

  def generate_rarity
    case @level
    when 1..3
      'Common'
    when 4..7
      'Uncommon'
    when 8..9
      'Rare'
    when 10
      'Epic'
    else
      'Legendary'
    end
  end

  # Methods to toggle discovery and ownership
  def discover
    @discovered = true
  end

  def own
    @owned = true
  end
end
