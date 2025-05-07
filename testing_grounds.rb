# frozen_string_literal: true

require_relative 'creapedia'

creapedia = Creapedia.new
player = nil
player_creapedia = []

# Load game if save file exists
if File.exist?('savefile.json')
  file = File.read('savefile.json')
  save_data = JSON.parse(file)

  player = save_data['player']
  player_creapedia = save_data['player_creapedia']
end

p player_creapedia
