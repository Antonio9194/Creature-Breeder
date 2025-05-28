# frozen_string_literal: true

require_relative '../models/creapedia'
require_relative '../models/creature'
require_relative '../models/bag'
require_relative '../models/item'

# Logic to start game and choose starter first time
class Starting
  def initialize(game_data)
    @player = game_data[:player]
    @player_creapedia = game_data[:player_creapedia]
    @team = game_data[:team]
    @boxes = game_data[:boxes]
    @creapedia = game_data[:creapedia]
    @bag = game_data[:bag]
    @current_location = game_data[:current_location]
  end

  def choose
    player = player_name
    creature = select_starter
    current_location = "Prof. Kaku's Lab"
    puts "\nYou chose #{creature.name} as your starter!"
    adding_first_item
    puts "\nOpen the main menu and check your first creapedia entry!"
    [player, creature, current_location]
  end

  private

  def player_name
    puts 'Welcome to Creature Breeder, collect, find and breed all of them!'
    puts "\nWhat is your name?"
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
      creature = creature.dup
      creature.abilities = creature.abilities.sample(2)
      creature.discovered = true
      creature.owned = true
      @player_creapedia.add_to_creapedia(creature)
      @team.add_to_team(creature)
      creature
    else
      puts "\nPlease choose again."
    end
  end

  def adding_first_item
    creaflop = Item::CREAFLOP
    potion = Item::POTION
    10.times { @bag.add_item_to_bag(creaflop) }
    5.times { @bag.add_item_to_bag(potion) }
    puts "\nHere are 10 #{creaflop.name} to help you start your adventure!"
  end
end
