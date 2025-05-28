# frozen_string_literal: true

require_relative 'base_location'

# Leafy Town Map Area
class LeafyTown < BaseLocation
  def leafy_town_menu
    loop do
      @menu.current_location = 'Leafy Town'
      puts "\n#{@menu.current_location}"
      puts "\n | 1.Enter Laboratory | 2.Enter Home | 3.Lake | 4.Route No.1 | M.Open Menu |"
      key = $stdin.getch.downcase
      case key
      when '1' then break @menu.lab_menu
      when '2' then break @menu.home_menu
      when '3' then break voltrag_lake_event
      when '4' then break @menu.route_1_menu
      when 'm' then break @menu.display_menu
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end

  def voltrag_lake_event
    loop do
      if @menu.flags[:voltrag_lake_event] == false
        puts "\n#{@menu.player} stares at the lake thinking of all the beautiful memories he had in #{@menu.current_location}."
        puts 'Feeling excited for his journey, as he readies himself for the new adventures he is suddenly shook by a wooshing sound.'
        puts 'A terrifying roar followed by thunders shakes the thought out of him.'
        puts "\n#{@menu.player}:"
        if @menu.flags[:watched_tv_news_voltrag_event] == true
          puts "\nCould it be related to the news?"
        else
          puts "\nWhat the hell was that?!"
        end
        @menu.flags[:voltrag_lake_event] = true
      else
        puts "\n | 1.Fish | 2.Swim | 3.Leafy Town |"
        key = $stdin.getch.downcase
        case key
        when '1'
          if @menu.flags[:have_fishing_road]
            fish
          else
            puts "\nNo Fishing Road."
          end
        when '2'
          if @menu.flags[:have_swim_skill]
            sweim
          else
            puts "\nNo Swim Skill."
          end
        when '3' then break @menu.leafy_town_menu
        else
          puts '(Invalid option. Try again.)'
        end
      end
    end
  end
end
