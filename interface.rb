# frozen_string_literal: true

require 'io/console'
require_relative 'creature'
require_relative 'creapedia'

creapedia = Creapedia.new
starter = nil

puts 'Welcome to Creature Breeder, collect, find and breed all of them!'
puts 'What is your name?'
answer = gets.chomp
player = answer
puts "#{player}, Choose a starter and embark on this dangerous journey, adventure awaits!"

loop do
  puts 'Choose: [Lavagor | Aqualis | Terronox | Fangor]'
  choice = gets.chomp

  case choice
  when 'Lavagor', 'Aqualis', 'Terronox', 'Fangor'
    creature = creapedia.find_by_name(choice)
    puts creature.info
    puts "Do you want to choose #{choice}? (Yes/No)"
    confirm = gets.chomp.downcase
    if confirm == 'yes'
      creature.discovered = true
      creature.owned = true
      starter = creature
      break
    end
  else
    puts 'Invalid choice. Please try again.'
  end
end

puts "You chose #{starter.name} as your starter!"
puts 'Open your Creapedia and check your first entry!'
puts 'Open your Creapedia? (Yes/No)'
gets.chomp
if creapedia.discovered_entries_num == 1
  puts "You have #{creapedia.discovered_entries_num} entry."
  puts " Entries: #{creapedia.discovered_entries_list}"
elsif creapedia.discovered_entries > 1
  puts "You have #{creapedia.discovered_entries_num} entries."
  puts " Entries: #{creapedia.discovered_entries_list}"
end
puts 'Type "esc" to exit'
gets.chomp
