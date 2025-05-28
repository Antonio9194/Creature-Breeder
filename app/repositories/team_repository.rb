# frozen_string_literal: true

require_relative '../models/creature'

# Team
class TeamRepo
  include Enumerable
  attr_reader :team

  def initialize(team = [])
    @team = team
  end

  def each(&block)
    @team.each(&block)
  end

  def self.from_h(array_of_hashes)
    creatures = array_of_hashes.map { |creature_hash| Creature.from_h(creature_hash) }
    new(creatures)
  end

  def name
    @team.first.name
  end

  def size
    @team.count
  end

  def [](index)
    @team[index]
  end

  def add_to_team(creature)
    @team << creature
  end

  def remove_from_team(creature)
    @team.delete(creature)
  end
end
