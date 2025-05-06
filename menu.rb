# frozen_string_literal: true

require_relative 'interface'

class Menu

  def show_main_menu
    puts 'Main Menu:'
    puts '1. Creapedia'
    puts '2. Creatures'
    puts '3. Save'
    puts '4. Exit'

    choice = gets.chomp.to_i 

    case choice
    when 1 call creepedia
    when 2 call your creature list 
    when 3 Save
    when 4 exit
end
