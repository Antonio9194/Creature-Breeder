# frozen_string_literal: true

require_relative 'base_location'

class Home < BaseLocation
  def initialize(menu)
    super(menu)
    @talked_to_mom = false
  end

  def mom_speach
    puts "\nMom:"
    if @talked_to_mom == false
      puts "\n'Good morning #{@menu.player}, did you go meet Prof. Kaku?'"
      puts "'He said he had something very special for you.'"
      puts "'Ah, #{@menu.team.first.name} is so cute! Make sure to take care of your friend!'"
      puts "'Here #{@menu.player}, you should take this, it will help you on your journey!'"
      money = Item::MONEY
      5000.times { @menu.bag.add_item_to_bag(money) }
      puts "\n5000 Trins were added to your bag."
      puts "\n"
      @talked_to_mom = true
    else
      puts "\n'Take kare of yourself out there and come back home once in a while!'"
    end
    home_menu
  end

  def tv_news
    news = []
    news << "\nBREAKING: Local fisherman reports sighting of a legendary electric dragon flying near Leafy Town's skies yesterday evening."
    news << "\nWEATHER ALERT: Mysterious snowstorm blankets Seraphim City coastline in mid-summer - meteorologists baffled by the phenomenon."
    news << "\nGEOLOGICAL CONCERNS: Masso City residents on edge as frequency of earthquakes triples normal levels this week."
    news << "\nPARANORMAL ACTIVITY: Multiple witnesses report strange lights and unexplained phenomena in Blissful Forest - investigations underway."
    news
  end

  def home_menu
    loop do
      @menu.current_location = 'Home'
      puts "\n🏠#{@menu.current_location}"
      puts "\n | 1.Exit your home | 2.Talk to your mom | 3.Listen to TV news | M.Open Menu |"
      key = $stdin.getch.downcase
      case key
      when '1' then break @menu.leafy_town_menu
      when '2' then break mom_speach
      when '3'
        puts tv_news.sample
        next
      when 'm' then break @menu.display_menu
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end
end
