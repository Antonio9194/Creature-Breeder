# frozen_string_literal: true

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
  starter_name = save_data['starter']['name']
  starter = creapedia.find_by_name(starter_name)

  puts "Welcome back, #{player}!"

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

  puts 'Type "Exit" to exit or "M" to open the main menu'
  menu_choice = gets.chomp

  if menu_choice.downcase == 'm'

    loop do
      puts '[ Creapedia | Save | Exit ]'
      choice = gets.chomp.capitalize

      case choice
      when 'Save'
        savefile = creapedia.to_json_data(player, starter)
        File.open('savefile.json', 'w') { |f| f.write(savefile.to_json) }
        puts 'Game saved!'

      when 'Creapedia'
        if creapedia.discovered_entries_num == 1
          puts "You have #{creapedia.discovered_entries_num} entry."
          puts " Entries: #{creapedia.discovered_entries_list}"
        elsif creapedia.discovered_entries_num > 1
          puts "You have #{creapedia.discovered_entries_num} entries."
          puts " Entries: #{creapedia.discovered_entries_list}"
        end

      when 'Exit'
        puts 'Goodbye, adventurer'
        break

      else
        puts 'Invalid choice, try again!'
      end
    end
  end
end
