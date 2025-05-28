# frozen_string_literal: true

require_relative 'menu'

class Fight
  def initialize(menu, team, opponent)
    @menu = menu
    @team = team
    @opponent = opponent
  end

  def fight_loop
    loop do
      display_attack_menu
      choice = $stdin.getch.downcase

      case choice
      when '1' then attack(@opponent)
      when '2'
        puts "\nYou checked your bag. (Not implemented yet!)"
      when '3'
        puts "\nYou ran away safely!"
        @menu.map_cases
        break
      else
        puts "\nInvalid choice, try again."
      end

      break if @opponent.health <= 0
    end
  end

  def display_attack_menu
    puts "\n | 1.Attack | 2.Bag | 3.Run |"
  end

  def display_abilities(creature)
    puts "\nChoose an ability for #{creature.name}:"
    creature.abilities.each_with_index do |ability, index|
      puts "#{index + 1}. #{ability[:name]} (Power: #{ability[:power]})"
    end
  end

  def attack(opponent)
    puts "\nChoose your Creature:"

    @team.each_with_index do |creature, index|
      puts "#{index + 1}. #{creature.name} (Level #{creature.level})"
    end

    key = $stdin.getch.downcase
    chosen_index = key.to_i - 1

    if chosen_index.between?(0, @team.size - 1)
      chosen_creature = @team[chosen_index]
      display_abilities(chosen_creature)

      ability_key = $stdin.getch.downcase
      ability_index = ability_key.to_i - 1

      if ability_index.between?(0, chosen_creature.abilities.size - 1)
        chosen_ability = chosen_creature.abilities[ability_index]

        damage = calculate_damage(chosen_creature, chosen_ability)

        puts "\n#{chosen_creature.name} used #{chosen_ability[:name]} and dealt #{damage} damage!"

        apply_damage(opponent, damage)
      else
        puts "\nInvalid ability choice!"
      end
    else
      puts "\nInvalid creature choice!"
    end
  end

  def calculate_damage(creature, ability)
    damage = creature.level * ability[:power]
    damage = 1 if damage < 1 # At least 1 damage always
    damage
  end

  def apply_damage(creature, damage)
    creature.health -= damage
    creature.health = 0 if creature.health < 0

    puts "#{creature.name} has #{creature.health} HP left."

    if creature.health == 0
      puts "#{creature.name} fainted! 💔"
      # Additional fainting logic can go here
    end
  end
end
