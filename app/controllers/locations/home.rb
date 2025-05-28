# frozen_string_literal: true

require_relative 'base_location'

class Home < BaseLocation
  def home_menu
    loop do
      @menu.current_location = 'Home'
      puts "\n🏠#{@menu.current_location}"
      puts "\n | 1.Exit Home | 2.Talk to Mom | 3.Check TV news | 4.Enter Room | M.Open Menu |"
      key = $stdin.getch.downcase
      case key
      when '1' then break @menu.leafy_town_menu
      when '2' then break mom_speach
      when '3'
        news = tv_news
        sampled_news = news[:list].sample
        puts sampled_news
        case sampled_news
        when news[:voltrag] then @menu.flags[:watched_tv_news_voltrag_event] = true
        when news[:glacira] then @menu.flags[:watched_tv_news_glacira_event] = true
        when news[:obelisk] then @menu.flags[:watched_tv_news_obelisk_event] = true
        when news[:nightclaw] then @menu.flags[:watched_tv_news_nightclaw_event] = true
        end
        next
      when '4' then break @menu.player_room_menu
      when 'm' then break @menu.display_menu
      else
        puts '(Invalid option. Try again.)'
      end
    end
  end

  def mom_speach
    puts "\nMom:"
    if @menu.flags[:talked_to_mom] == false
      puts "\n'Good morning #{@menu.player}, did you go meet Prof. Kaku?'"
      puts "'He said he had something very special for you.'"
      puts "'Ah, #{@menu.team.first.name} is so cute! Make sure to take care of your friend!'"
      puts "'Here #{@menu.player}, you should take this, it will help you on your journey!'"
      money = Item::MONEY
      5000.times { @menu.bag.add_item_to_bag(money) }
      puts "\n5000 Trins were added to your bag."
      puts "\n"
      @menu.flags[:talked_to_mom] = true
      @menu.flags[:received_money] = true
    else
      puts "\n'Take kare of yourself out there and come back home once in a while!'"
    end
    home_menu
  end

  def tv_news
    voltrag_news = "\nBREAKING: Local fisherman reports sighting of a legendary electric dragon flying near Leafy Town's skies yesterday evening."
    glacira_news = "\nWEATHER ALERT: Mysterious snowstorm blankets Seraphim City coastline in mid-summer - meteorologists baffled by the phenomenon."
    obelisk_news = "\nGEOLOGICAL CONCERNS: Masso City residents on edge as frequency of earthquakes triples normal levels this week."
    nightclaw_news = "\nPARANORMAL ACTIVITY: Multiple witnesses report strange lights and unexplained phenomena in Blissful Forest - investigations underway."

    news = [voltrag_news, glacira_news, obelisk_news, nightclaw_news]

    { list: news, voltrag: voltrag_news, glacira: glacira_news, obelisk: obelisk_news, nightclaw: nightclaw_news }
  end
end
