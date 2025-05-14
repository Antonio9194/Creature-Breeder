# frozen_string_literal: true

# Player Creapedia Repository
class PlayerCreapediaRepo
  attr_reader :creatures

  def initialize(creatures = [])
    @creatures = creatures
  end

  def add_to_creapedia(creature)
    @creatures << creature
  end

  def all_entries
    @creatures
  end
end
