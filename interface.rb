# frozen_string_literal: true

require 'io/console'
require_relative 'creapedia'
require_relative 'creature'

creapedia = Creapedia.new
starter = nil
player = nil

# Load game if save file exists
if File.exist?('savefile.json')
  file = File.read('savefile.json')
  save_data = JSON.parse(file)

  player = save_data['player']
  player_creapedia = save_data['player_creapedia']

  # Welcomes the player and prompts command to start the game
  puts "Welcome back, #{player}!"
  puts 'Press S to Start the adventure'

  loop do
    key = STDIN.getch.downcase
    if key == 's'
      puts "\n[ Game Started ]"
      break
    else
      puts "\n(Press S for start the game)"
    end
  end

  # World loop
  loop do
    # Menu loop logic
    loop do
      key = STDIN.getch.downcase
      case key
      when 'm'
        puts 'Menu: [ 1.Creapedia | 2.Team | 3.Boxes | 4.Save | 5.Exit Menu | 6.Exit Game ]'
      when '1'
        p player_creapedia
      when '2'
        p team
      when '3'
        p boxes
      when '4'
        # save logic doesnt work here, must fix
        savefile = creapedia.to_json_data(player)
        File.open('savefile.json', 'w') { |f| f.write(savefile.to_json) }
        puts 'Game saved!'
      when '5'
        break
      when '6'
        break
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end

else
  puts 'Welcome to Creature Breeder, collect, find and breed all of them!'
  puts 'What is your name?'
  player = gets.chomp
  puts "#{player}, Choose a starter and embark on this dangerous journey, adventure awaits!"

  loop do
    puts 'Choose: [Lavagor | Aqualis | Terronox | Fangor]'
    choice = gets.chomp

    case choice
    when 'Lavagor', 'Aqualis', 'Terronox', 'Fangor'
      creature = creapedia.find_by_name(choice)
      puts creature.info
      puts "Do you want to choose #{choice}? (Yes/No)"
      confirm = gets.chomp.downcase
      if confirm == 'yes'
        creature.discovered = true
        creature.owned = true
        starter = creature
        break
      end
    else
      puts 'Invalid choice. Please try again.'
    end
  end

  loop do
    puts "You chose #{starter.name} as your starter!"
    puts 'Open your Creapedia and check your first entry!'
    puts 'Open your Creapedia? (Yes/No)'
    choice = gets.chomp.downcase

    if choice == 'yes'
      if creapedia.discovered_entries_num == 1
        puts "You have #{creapedia.discovered_entries_num} entry."
        puts " Entries: #{creapedia.discovered_entries_list}"
      elsif creapedia.discovered_entries_num > 1
        puts "You have #{creapedia.discovered_entries_num} entries."
        puts " Entries: #{creapedia.discovered_entries_list}"
      end
      break
    elsif choice == 'no'
      puts 'Please open your Creapedia.'
    end
  end

  puts 'Press "M" to open the main menu'
  key = STDIN.getch.downcase
  if key == 'm'
    loop do
      puts '[ 1.Creapedia | 2.Save | 3.Exit ]'
      choice = STDIN.getch.downcase

      case choice
      when '1'
        if creapedia.discovered_entries_num == 1
          puts "You have #{creapedia.discovered_entries_num} entry."
          puts " Entries: #{creapedia.discovered_entries_list}"
        elsif creapedia.discovered_entries_num > 1
          puts "You have #{creapedia.discovered_entries_num} entries."
          puts " Entries: #{creapedia.discovered_entries_list}"
        end
      when '2'
        savefile = creapedia.to_json_data(player)
        File.open('savefile.json', 'w') { |f| f.write(savefile.to_json) }
        puts 'Game saved!'
      when '3'
        puts 'Goodbye, adventurer'
        break
      else
        puts 'Invalid choice, try again!'
      end
    end
  end
end
