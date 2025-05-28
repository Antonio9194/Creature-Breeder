# frozen_string_literal: true

require 'io/console'
require_relative '../models/creapedia'
require_relative '../models/creature'

require_relative '../controllers/locations/prof_kakus_lab'
require_relative '../controllers/locations/leafy_town'
require_relative '../controllers/locations/home'
require_relative '../controllers/locations/player_room'
require_relative '../controllers/locations/route_1'

require_relative '../repositories/player_creapedia_repository'
require_relative '../repositories/boxes_repository'
require_relative '../repositories/team_repository'
require_relative '../repositories/bag_repository'

# Menu logic
class Menu
  attr_reader :player, :team, :bag
  attr_accessor :current_location, :flags

  def initialize(game_data)
    @player = game_data[:player]
    @player_creapedia = game_data[:player_creapedia]
    @team = game_data[:team]
    @boxes = game_data[:boxes]
    @creapedia = game_data[:creapedia]
    @bag = game_data[:bag]
    @current_location = game_data[:current_location]

    default_flags = {
      menu_opened: false,
      creapedia_opened: false,
      talked_to_the_prof: false,
      visited_home: false,
      talked_to_mom: false,
      received_money: false,
      watched_tv_news_voltrag_event: false,
      watched_tv_news_glacira_event: false,
      watched_tv_news_obelisk_event: false,
      watched_tv_news_nightclaw_event: false,
      voltrag_lake_event: false,
      have_fishing_road: false,
      have_swim_skill: false
    }

    @flags = game_data[:flags] || default_flags

    @lab_menu = KakusLab.new(self)
    @leafy_town_menu = LeafyTown.new(self)
    @home_menu = Home.new(self)
    @player_room_menu = PlayerRoom.new(self)
    @fight = Fight.new(self, @team, @opponent)
    @route_1_menu = RouteOne.new(self, @creapedia, @player_creapedia, @fight, @team)
  end

  def run
    loop do
      if @flags[:menu_opened] == false
        puts "\nPress 'M' to open menu"
        key = $stdin.getch.downcase
        next unless key == 'm' # Ignore all other key

        display_menu
        @flags[:menu_opened] = true
      end

      if @flags[:creapedia_opened] == false
        puts "\nOpen your Creapedia"
        key = $stdin.getch.downcase
        next unless key == '1' # Ignore all other key

        handle_creapedia
        @flags[:creapedia_opened] = true
      end

      key = $stdin.getch.downcase
      case key
      when '1' then handle_creapedia
      when '2' then handle_team
      when '3' then handle_boxes
      when '4' then open_bag
      when '5' then save_game
      when '6' then map_cases
      when '7' then exit_game
      else
        puts "\nInvalid option."
      end
    end
  end

  def map_cases
    case @current_location
    when "Prof. Kaku's Lab" then @lab_menu.lab_menu
    when 'Leafy Town' then @leafy_town_menu.leafy_town_menu
    when 'Home' then @home_menu.home_menu
    when 'Player Room' then @player_room_menu.player_room_menu
    when 'Route No.1' then @route_1_menu.route_1_menu
    end
  end

  def route_1_menu
    @route_1_menu.route_1_menu
  end

  def player_room_menu
    @player_room_menu.player_room_menu
  end

  def home_menu
    @home_menu.home_menu
  end

  def leafy_town_menu
    @leafy_town_menu.leafy_town_menu
  end

  def lab_menu
    @lab_menu.lab_menu
  end

  def display_menu
    puts "\nMain Menu"
    puts "\n | 1. 📖Creapedia | 2. 👾Team | 3. 📦Boxes | 4. 🎒Bag | 5. ✅Save | 6. ⍈Exit Menu | 7. ⍈Exit Game  |"
  end

  def handle_creapedia
    puts "\n📖Creapedia"
    puts "\nYour Creapedia has #{@player_creapedia.count} #{@player_creapedia.count == 1 ? 'entry.' : 'entries.'}"
    @player_creapedia.each do |creature|
      puts "\n#{creature.entry_info}."
    end
    puts "\nPress 'b' to go back to the menu."
    display_menu if $stdin.getch.downcase == 'b'
  end

  def move_to_boxes_from_team(creature)
    if @team.count <= 1
      puts "\nYou must keep at least one creature in your team!"
    else
      @team.remove_from_team(creature)
      @boxes.add_to_box(creature)
      puts "#{creature.name} moved to boxes!"
    end
  end

  def move_to_team_from_box(creature)
    @boxes.remove_from_box(creature)
    @team.add_to_team(creature)
    puts "#{creature.name} moved to team"
  end

  def creature_menu(creature)
    puts '1. Check Details'
    puts '2. Move to Boxes'
    puts '3. Back to previous Menu'
    input = $stdin.getch.downcase
    case input
    when '1' then details(creature)
                  puts "\nPress b to go back"
                  input = $stdin.getch.downcase
                  if input == 'b'
                    puts "\n"
                    creature_menu(creature)
                  else
                    puts "\nWrong input, try again."
                  end
    when '2' then move_to_boxes_from_team(creature)
                  puts "\nPress b to go back"
                  input = $stdin.getch.downcase
                  if input == 'b'
                    puts "\n"
                    creature_menu(creature)
                  else
                    puts "\nWrong input, try again."
                  end
    when '3' then handle_team
    else puts "\nWrong input, try again."
    end
  end

  def details(creature)
    puts "\nDetails for #{creature.name}:"
    puts creature.info # or whatever method shows all info
  end

  def handle_team
    loop do
      puts "\n👾Team"
      @team.each_with_index do |creature, index|
        puts "\n#{index + 1} - #{creature.name} 👾"
      end
      puts "\nPress a number to open the creature menu or 'b' to return to the main menu."
      input = $stdin.getch.downcase
      if input == 'b'
        display_menu
        break # This stops the loop and returns to the main menu
      elsif input =~ /\d/ && input.to_i.between?(1, @team.count)
        creature = @team[input.to_i - 1]
        puts "\n#{creature.name}'s Menu"
        puts "\n"
        creature_menu(creature)
        break
      else
        puts 'Invalid input. Please try again.'
      end
    end
  end

  def handle_boxes
    loop do
      puts "\n 📦Boxes"
      if @boxes.count >= 1
        puts "\n#{@boxes.map(&:to_s).join("\n")}"
      else
        puts "\nBox is empty."
      end
      puts "\nPress 'b' to return to the menu."
      break if $stdin.getch.downcase == 'b'
    end
    display_menu
  end

  def open_bag
    loop do
      puts "\n🎒Bag"
      if @bag.count >= 1
        puts "\n#{@bag.map(&:to_s).join("\n")}"
      else
        puts "\nBag is empty."
      end
      puts "\nPress 'b' to return to the menu."
      break if $stdin.getch.downcase == 'b'
    end
    display_menu
  end

  def save_game
    data = {
      player: @player,
      player_creapedia: @player_creapedia,
      team: @team,
      boxes: [@boxes], # make sure this matches your structure
      bag: @bag,
      current_location: @current_location,
      flags: @flags
    }

    json_data = to_json_data(data)
    File.write('savefile.json', JSON.pretty_generate(json_data))
    puts '💾 Game saved successfully!'
  end

  def to_json_data(data)
    {
      player: data[:player],
      player_creapedia: data[:player_creapedia].map(&:to_h),
      team: data[:team].map(&:to_h),
      boxes: (data[:boxes].respond_to?(:boxes) ? data[:boxes].boxes : data[:boxes]).map { |box| box.map(&:to_h) },
      bag: data[:bag].map(&:to_h),
      current_location: data[:current_location].to_s,
      flags: data[:flags]
    }
  end

  def exit_game
    puts "\nExiting game. Goodbye!"
    exit
  end
end
