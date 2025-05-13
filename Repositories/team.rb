# frozen_string_literal: true

# Team
class TeamRepo
  attr_reader :team

  def initialize(team = [])
    @team = team
  end

  def add_to_team(creature)
    @team << creature
  end

  def remove_from_team(index)
    if @team.size <= 1
      puts 'You must have at least one creature in your team!'
      return
    end
    @team.delete_at(index)
  end
end
