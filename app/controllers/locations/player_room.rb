# frozen_string_literal: true

require_relative 'base_location'

class PlayerRoom < BaseLocation
  def player_room_menu
    loop do
      @menu.current_location = 'Player Room'
      puts "\n🏠#{@menu.current_location}"
      puts "\n | 1.Exit Room | 2.Play PC | M.Open Menu |"
      key = $stdin.getch.downcase
      case key
      when '1' then break @menu.home_menu
      when '2'
        puts "\n*click* *clackclack* *WHIRRRRR* *tap-tap-tap* *clickclickclick* *FWOOSH* \"ugh!\" *BOOM!* *beep* *click* *SPACEBAR SMASH*"
        next
      when 'm' then break @menu.display_menu
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end
end
