# frozen_string_literal: true

require 'io/console'
require_relative 'creapedia'
require_relative 'creature'
require_relative 'menu'

creapedia = Creapedia.new
starter = nil
player = nil
player_creapedia = []
team = []
boxes = []

# Load game if save file exists
if File.exist?('savefile.json')
  file = File.read('savefile.json')
  save_data = JSON.parse(file)

  player = save_data['player']
  starter = save_data['starter']
  player_creapedia = save_data['player_creapedia']
  team = save_data['team']
  boxes = save_data['boxes']

  # Welcomes the player and prompts command to start the game
  puts "Welcome back, #{player}!"
  puts 'Press S to Start the adventure'

  loop do
    key = $stdin.getch.downcase
    if key == 's'
      puts "\n[ Game Started ]"
      break
    else
      puts "\n(Press S for start the game)"
    end
  end

  game_data = {
    player: player,
    starter: starter,
    player_creapedia: player_creapedia,
    team: team,
    boxes: boxes,
    creapedia: creapedia
  }
  menu = Menu.new(game_data)
  # World loop
  loop do
    # Menu loop
    menu.run
  end

else
  puts 'Welcome to Creature Breeder, collect, find and breed all of them!'
  puts 'What is your name?'
  player = gets.chomp

  puts "#{player}, choose a starter and embark on this dangerous journey. Adventure awaits!"

  loop do
    puts 'Choose: [Lavagor | Aqualis | Terronox | Fangor]'
    choice = gets.chomp

    case choice
    when 'Lavagor', 'Aqualis', 'Terronox', 'Fangor'
      creature = creapedia.find_by_name(choice)

      if creature
        puts creature.info
        puts "Do you want to choose #{creature.name}? (Yes/No)"
        confirm = gets.chomp.downcase

        if confirm == 'yes'
          creature.discovered = true
          creature.owned = true
          starter = creature
          player_creapedia << starter
          team << starter.name
          break
        end
      else
        puts 'Something went wrong—creature not found in Creapedia.'
      end
    else
      puts 'Invalid choice. Please try again.'
    end
  end

  loop do
    puts "\nYou chose #{starter.name} as your starter!"
    puts 'Open your Creapedia and check your first entry? (Yes/No)'
    input = gets.chomp.downcase

    if input == 'yes'
      count = creapedia.discovered_entries_num
      if count.zero?
        puts 'You have no discovered entries.'
      else
        puts "You have #{creapedia.discovered_entries_num} #{creapedia.discovered_entries_num == 1 ? 'entry' : 'entries'}:"
        puts creapedia.discovered_entries_list
      end
      break
    elsif input == 'no'
      puts 'Please open your Creapedia before proceeding.'
    else
      puts 'Invalid input. Please enter Yes or No.'
    end
  end
end

puts 'Press "M" to open the main menu'
loop do
  key = STDIN.getch.downcase
  if key == 'm'
    loop do
      puts '[ 1.Creapedia | 2.Save | 3.Exit ]'
      choice = $stdin.getch.downcase
      case choice
      when '1'
        count = creapedia.discovered_entries_num
        if count.zero?
          puts 'You have no discovered entries.'
        else
          puts "You have #{count} #{count == 1 ? 'entry' : 'entries'}:"
          puts creapedia.discovered_entries_list
        end
      when '2'
        savefile = creapedia.to_json_data(player, starter, player_creapedia, team, boxes)
        File.open('savefile.json', 'w') { |f| f.write(savefile.to_json) }
        puts 'Game saved!'
      when '3'
        puts 'Goodbye, adventurer 💫'
        break
      else
        puts 'Invalid choice, try again!'
      end
    end
    break
  else
    puts "\n(Press 'M' to open the menu)"
  end
end
