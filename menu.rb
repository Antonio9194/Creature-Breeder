# frozen_string_literal: true

require 'io/console'
require_relative 'creapedia'
require_relative 'creature'

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
      when 'm'
        display_menu
      when '1'
        handle_creapedia
      when '2'
        handle_team
      when '3'
        handle_boxes
      when '4'
        save_game
      when '5'
        break
      when '6'
        exit_game
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end

  private

  def display_menu
    puts "\n[ 1.Creapedia | 2.Team | 3.Boxes | 4.Save | 5.Exit Menu | 6.Exit Game ]"
  end

  def details(creature)
    puts "\nDetails for #{creature.name}:"
    puts creature.info # or whatever method shows all info
  end

  def handle_creapedia
    loop do
      puts "\nYou have #{@player_creapedia.count} #{@player_creapedia.count == 1 ? 'entry.' : 'entries.'}"
      @player_creapedia.each do |creature|
        puts "\n#{creature.entry_info}."
      end
      puts "\nPress 'b' to go back to the menu."
      display_menu if $stdin.getch.downcase == 'b'
      break
    end
  end

  def handle_team
    loop do
      @team.each_with_index do |creature, index|
        puts "\n#{index + 1} - #{creature.name}"
      end
      puts "\nPress a number to view details or 'b' to return to the main menu."
      input = $stdin.getch.downcase
      if input == 'b'
        display_menu
        break
      elsif input =~ /\d/ && input.to_i.between?(1, @player_creapedia.size)
        details(@team[input.to_i - 1])
      else
        puts 'Invalid input. Please try again.'
      end
      puts "\nPress 'b' to return to your team."
      handle_team if $stdin.getch.downcase == 'b'
      break
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
