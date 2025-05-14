# frozen_string_literal: true

require 'io/console'
require_relative '../models/creapedia'
require_relative '../models/creature'
require_relative '../repositories/player_creapedia_repository'
require_relative '../repositories/boxes_repository'
require_relative '../repositories/team_repository'

# Menu logic
class Menu
  def initialize(game_data)
    @player = game_data[:player]
    @player_creapedia = game_data[:player_creapedia]
    @team = game_data[:team]
    @boxes = game_data[:boxes]
    @creapedia = game_data[:creapedia]
  end

  def run
    loop do
      key = $stdin.getch.downcase
      case key
      when 'm' then display_menu
      when '1' then handle_creapedia
      when '2' then handle_team
      when '3' then handle_boxes
      when '4' then save_game
      when '5' then break
      when '6' then exit_game
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end

  private

  def display_menu
    puts "\n[ 1.Creapedia | 2.Team | 3.Boxes | 4.Save | 5.Exit Menu | 6.Exit Game ]"
  end

  def handle_creapedia
    puts "\nYou have #{@player_creapedia.count} #{@player_creapedia.count == 1 ? 'entry.' : 'entries.'}"
    @player_creapedia.each do |creature|
      puts "\n#{creature.entry_info}."
    end
    puts "\nPress 'b' to go back to the menu."
    display_menu if $stdin.getch.downcase == 'b'
  end

  def move_to_boxes_from_team(creature)
    if @team.size <= 1
      puts 'You must keep at least one creature in your team!'
      return
    end
    @team.remove(creature)
    @boxes.add(creature)
    puts "#{creature.name} moved to boxes!"
  end

  def move_to_team_from_box(creature)
    @boxes.remove(creature)
    @team.add(creature)
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
                  p @boxes
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
      puts "\nYour Team:"
      @team.each_with_index do |creature, index|
        puts "#{index + 1} - #{creature.name}"
      end
      puts "\nPress a number to open the creature menu or 'b' to return to the main menu."
      input = $stdin.getch.downcase
      if input == 'b'
        display_menu
        break # This stops the loop and returns to the main menu
      elsif input =~ /\d/ && input.to_i.between?(1, @team.size)
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

  def save_game
    savefile = @creapedia.to_json_data(@player, @player_creapedia, @team, @boxes)
    File.open('savefile.json', 'w') { |f| f.write(savefile.to_json) }
    puts "\nGame saved!"
    display_menu
  end

  def exit_game
    puts "\nExiting game. Goodbye!"
    exit
  end
end
