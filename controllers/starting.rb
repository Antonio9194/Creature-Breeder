# frozen_string_literal: true

require_relative '../models/creapedia'
require_relative '../models/creature'

# Logic to start game and choose starter first time
class Starting
  def initialize(creapedia:, player_creapedia:, team:)
    @creapedia = creapedia
    @player_creapedia = player_creapedia
    @team = team
  end

  def choose
    player = get_player_name
    creature = select_starter

    puts "\nYou chose #{creature.name} as your starter!"
    puts "\nPress 'M' to open the main menu and check your creapedia entry!"
    [player, creature]
  end

  private

  def get_player_name
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
      creature = @creapedia.find_by_name(choice)
      return confirm_starter(creature) if creature

      puts "\nInvalid choice. Please try again."
    end
  end

  def confirm_starter(creature)
    puts "\n #{creature.info}"
    puts "\nDo you want to choose #{creature.name}? (Yes/No)"
    confirm = gets.chomp.downcase
    if confirm == 'yes'
      creature.discovered = true
      creature.owned = true
      @player_creapedia << creature
      @team << creature
      return creature
    else
      puts "\nPlease choose again."
    end
  end
end
