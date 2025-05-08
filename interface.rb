# frozen_string_literal: true

require 'io/console'
require_relative 'creapedia'
require_relative 'creature'
require_relative 'menu'
require_relative 'starting'

creapedia = Creapedia.new
starter = nil
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

  starting = Starting.new(
    creapedia: creapedia,
    player_creapedia: player_creapedia,
    team: team
  )
  starting.choose

  puts 'Press "M" to open the main menu'
  game_data = {
    player: player,
    starter: starter,
    player_creapedia: player_creapedia,
    team: team,
    boxes: boxes,
    creapedia: creapedia
  }
  menu = Menu.new(game_data)
  loop do
    menu.run
  end
end
