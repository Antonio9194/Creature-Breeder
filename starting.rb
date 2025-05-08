# frozen_string_literal: true

require_relative 'creature'
require_relative 'creapedia'

# Logic to start game and choose starter first time
class Starting
  def initialize(creapedia:, player_creapedia:, team:)
    @creapedia = creapedia
    @player_creapedia = player_creapedia
    @team = team
  end

  def choose
    starter = nil
    player = nil

    loop do
      puts 'Welcome to Creature Breeder, collect, find and breed all of them!'
      puts 'What is your name?'
      player = gets.chomp
      puts "#{player}, choose a starter and embark on this dangerous journey. Adventure awaits!"

      puts 'Choose: [Lavagor | Aqualis | Terronox | Fangor]'
      choice = gets.chomp

      case choice
      when 'Lavagor', 'Aqualis', 'Terronox', 'Fangor'
        creature = @creapedia.find_by_name(choice)

        if creature
          puts creature.info
          puts "Do you want to choose #{creature.name}? (Yes/No)"
          confirm = gets.chomp.downcase

          if confirm == 'yes'
            creature.discovered = true
            creature.owned = true
            starter = creature
            @player_creapedia << starter
            @team << starter.name
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
        count = @creapedia.discovered_entries_num
        if count.zero?
          puts 'You have no discovered entries.'
        else
          puts "You have #{count} #{count == 1 ? 'entry' : 'entries'}:"
          puts @creapedia.discovered_entries_list
        end
        break
      elsif input == 'no'
        puts 'Please open your Creapedia before proceeding.'
      else
        puts 'Invalid input. Please enter Yes or No.'
      end
    end
    puts 'Press "M" to open the main menu'
    [player, starter]
  end
end
