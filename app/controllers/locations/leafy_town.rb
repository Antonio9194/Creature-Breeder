# frozen_string_literal: true

require_relative 'base_location'

# Leafy Town Map Area
class LeafyTown < BaseLocation
  def leafy_town_menu
    loop do
      @menu.current_location = 'Leafy Town'
      puts "\n#{@menu.current_location}"
      puts "\n | 1.Enter Laboratory | 2.Enter your home | 3.Look at the lake | 4.Go to Route | M.Open Menu |"
      key = $stdin.getch.downcase
      case key
      when '1' then break @menu.lab_menu
      when '2' then break @menu.home_menu
      when '3' then break lake_event
      when 'm' then break @menu.display_menu
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end
end
