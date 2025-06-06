# frozen_string_literal: true

require_relative 'base_location'
require_relative '../wild_encounter'
require_relative '../fight'
require_relative '../../models/creapedia'

class RouteOne < BaseLocation
  def initialize(menu, creapedia, player_creapedia, team)
    super(menu)
    @creapedia = creapedia
    @player_creapedia = player_creapedia
    @team = team
  end

  def route_1_menu
    loop do
      @menu.current_location = 'Route No.1'
      puts "\n🏠#{@menu.current_location}"
      puts "\n | 1.Leafy Town | 2.Route No.2 | 3.Enter Grass | M.Open Menu |"
      key = $stdin.getch.downcase
      case key
      when '1' then break @menu.leafy_town_menu
      when '2' then break @menu.route_2_menu
      when '3'
        if @team.all? { |c| c.health <= 0 }
          puts "\nYou don't have available Creatures, visit a Creature Center to heal!"
        else
          wild_creature = WildEncounter.encounter('Route 1', @creapedia, @player_creapedia)
          fight = Fight.new(@menu, @team, wild_creature)
          fight.fight_loop
        end
      when 'm' then break @menu.display_menu
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end
end
