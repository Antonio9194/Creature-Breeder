# frozen_string_literal: true

# Team
class TeamRepo
  attr_reader :team

  def initialize(team = [])
    @team = team
  end

  def add(creature)
    @team << creature
  end

  def remove(creature)
    @team.delete(creature)
  end
end
