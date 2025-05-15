# frozen_string_literal: true

# Player Creapedia Repository
class PlayerCreapediaRepo
  include Enumerable
  attr_reader :creatures

  def initialize(creatures = [])
    @creatures = creatures
  end

  def add_to_creapedia(creature)
    @creatures << creature
  end

  def [](index)
    @team[index]
  end

  def each(&block)
    @creatures.each(&block)
  end

  def entries_count
    @creatures.count
  end

  def all_entries
    @creatures
  end
end
