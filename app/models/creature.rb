# frozen_string_literal: true

# Creature class, mold for creatures
class Creature
  attr_reader :name, :species, :element, :level, :rarity, :health, :abilities
  attr_accessor :discovered, :owned, :xp, :xp_needed

  def initialize(name, species, element, attributes = {})
    @name = name
    @species = species
    @element = element
    @level = attributes[:level] || 1
    @xp = attributes[:xp] || 0
    @xp_needed = attributes[:xp_needed] || 100
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
      xp: xp,
      xp_needed: xp_needed,
      rarity: @rarity,
      health: @health,
      abilities: @abilities,
      discovered: @discovered,
      owned: @owned
    }
  end

  # Methods to toggle discovery and ownership
  def discover
    @discovered = true
  end

  def own
    @owned = true
  end

  # Defining marks for player creapedia
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

  def gain_xp(amount)
    @xp += amount
    level_up while @xp >= @xp_needed
  end

  def level_up
    @xp -= @xp_needed
    @level += 1
    @xp_needed = (@level**1.5 * 100).to_i
    puts "#{@name} leveled up to level #{@level}!"
  end

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
end
