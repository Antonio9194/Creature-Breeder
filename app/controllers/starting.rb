# frozen_string_literal: true

require_relative '../models/creapedia'
require_relative '../models/creature'

# Logic to start game and choose starter first time
class Starting
  def initialize(game_data)
    @player = game_data[:player]
    @player_creapedia = game_data[:player_creapedia]
    @team = game_data[:team]
    @boxes = game_data[:boxes]
    @creapedia = game_data[:creapedia]
  end

  def choose
    player = player_name
    creature = select_starter
    puts "\nYou chose #{creature.name} as your starter!"
    puts "\nPress 'M' to open the main menu and check your creapedia entry!"
    [player, creature]
  end

  private

  def player_name
    puts 'Welcome to Creature Breeder, collect, find and breed all of them!'
    puts 'What is your name?'
    gets.chomp.tap do |player|
      puts "\n#{player}, choose a starter and embark on this dangerous journey. Adventure awaits!"
    end
  end

  def select_starter
    loop do
      puts "\nChoose: [Lavagor | Aqualis | Terronox | Fangor]"
      choice = gets.chomp
      creature = @creapedia.find_by_name(choice) if choice
      if creature
        confirmed_creature = confirm_starter(creature)
        return confirmed_creature if confirmed_creature
      else
        puts "\nInvalid choice. Please try again."
      end
    end
  end

  def confirm_starter(creature)
    puts "\n #{creature.info}"
    puts "\nDo you want to choose #{creature.name}? (Yes/No)"
    confirm = gets.chomp.downcase
    if confirm == 'yes'
      creature.discovered = true
      creature.owned = true
      @player_creapedia.add_to_creapedia(creature)
      @team.add_to_team(creature)
      creature
    else
      puts "\nPlease choose again."
    end
  end
end
