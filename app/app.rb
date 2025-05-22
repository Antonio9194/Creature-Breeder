# frozen_string_literal: true

require 'io/console'
require_relative 'controllers/menu'
require_relative 'controllers/starting'

require_relative 'models/creapedia'
require_relative 'models/creature'
require_relative 'models/bag'
require_relative 'models/item'

require_relative 'repositories/player_creapedia_repository'
require_relative 'repositories/team_repository'
require_relative 'repositories/boxes_repository'
require_relative 'repositories/bag_repository'

creapedia = Creapedia.new
player_creapedia = PlayerCreapediaRepo.new
team = TeamRepo.new
boxes = BoxesRepo.new
bag = BagRepo.new

# Load game if save file exists
if File.exist?('savefile.json')
  file = File.read('savefile.json')
  save_data = JSON.parse(file)

  game_data = {
    player: save_data['player'],
    player_creapedia: save_data['player_creapedia'].map { |data| Creature.from_h(data) },
    team: save_data['team'].map { |data| Creature.from_h(data) },
    boxes: save_data['boxes'].map { |box| box.map { |data| Creature.from_h(data) } },
    bag: save_data['bag'],
    creapedia: creapedia,
    current_location: save_data['current_location']
  }

  menu = Menu.new(game_data)

  # Welcomes the player and prompts command to start the game
  puts "Welcome back, #{game_data[:player]}!"
  puts 'Press S to Start the adventure'

  loop do
    key = $stdin.getch.downcase
    if key == 's'
      puts "\n[ Game Started ]"
      menu.map_cases
      break
    else
      puts "\n(Press S for start the game)"
    end
  end

  menu = Menu.new(game_data)
  # World loop
  loop do
    # Menu loop
    menu.run
  end

  # Start the game first time if no save file to load
else
  starting = Starting.new(
    creapedia: creapedia,
    player_creapedia: player_creapedia,
    team: team,
    bag: bag
  )
  player, starter, current_location = starting.choose

  game_data = {
    player: player,
    starter: starter,
    player_creapedia: player_creapedia,
    team: team,
    boxes: boxes,
    bag: bag,
    creapedia: creapedia,
    current_location: current_location
  }
  menu = Menu.new(game_data)
  loop do
    menu.run
  end
end
