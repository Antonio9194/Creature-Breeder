# frozen_string_literal: true

require_relative 'base_location'

# Kaku's Lab Map Area
class KakusLab < BaseLocation
  def prof_kaku_first_speach
    puts "\nProf. Kaku:"
    puts "\n'The time has come, #{@menu.player}. Beyond these walls lies a world " \
    "teeming with untamed creatures and legends waiting to be uncovered!'"
    puts "'Venture forth—but stay sharp!Protect your #{@menu.team.name} at all costs, and may your Creapedia grow!"
    puts "\n"
    lab_menu
  end

  def lab_menu
    loop do
      @menu.current_location = "Prof. Kaku's Lab"
      puts "\n#{@menu.current_location}"
      puts "\n | 1.Exit Laboratory | 2.Talk to Prof. Kaku | M.Open Menu |"
      key = $stdin.getch.downcase
      case key
      when '1' then break @menu.leafy_town_menu
      when '2' then break prof_kaku_first_speach
      when 'm' then break @menu.display_menu
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end
end
