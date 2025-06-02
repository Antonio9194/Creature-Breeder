# frozen_string_literal: true

require_relative 'menu'

class Fight
  def initialize(menu, team, opponent)
    @menu = menu
    @team = team
    @opponent = opponent
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

  def calculate_damage(creature, ability)
    damage = creature.level * ability[:power]
    damage = 1 if damage < 1
    damage
  end

  def calculate_gained_xp(opponent, damage)
    opponent.level * damage
  end

  def apply_damage(target, damage, attacker)
    target.health -= damage
    target.health = 0 if target.health < 0
    puts "\n#{target.name} has #{target.health} HP left."

    return false unless target.health.zero?

    puts "#{target.name} fainted! 💔"

    # Only give XP if the attacker is one of the player's creatures
    if @team.include?(attacker)
      gained_xp = calculate_gained_xp(target, damage)
      attacker.gain_xp(gained_xp)
      puts "\n#{attacker.name} gained #{gained_xp} XP!"
      puts "\n#{attacker.name} needs #{attacker.xp_to_next_level} more XP to level up."
    end

    true
  end

  def fight_loop
    puts "\nChoose your Creature:"
    @team.each_with_index do |creature, index|
      puts "\n#{index + 1}. #{creature.name} (Level #{creature.level})"
    end

    creature_key = $stdin.getch
    creature_index = creature_key.to_i - 1

    if creature_index.between?(0, @team.size - 1)
      chosen_creature = @team[creature_index]
      turn_loop(chosen_creature)
    else
      puts "\nInvalid creature choice!"
    end
  end

  def turn_loop(chosen_creature)
    loop do
      display_attack_menu
      choice = $stdin.getch.downcase

      case choice
      when '1'
        display_abilities(chosen_creature)
        ability_key = $stdin.getch
        ability_index = ability_key.to_i - 1

        if ability_index.between?(0, chosen_creature.abilities.size - 1)
          chosen_ability = chosen_creature.abilities[ability_index]
          damage = calculate_damage(chosen_creature, chosen_ability)
          puts "\n#{chosen_creature.name} used #{chosen_ability[:name]} and dealt #{damage} damage!"

          defeated = apply_damage(@opponent, damage, chosen_creature)
          break if defeated

          # Opponent's turn to attack
          sleep(1)
          enemy_ability = @opponent.abilities.sample
          enemy_damage = calculate_damage(@opponent, enemy_ability)
          puts "\n#{@opponent.name} retaliates with #{enemy_ability[:name]} and deals #{enemy_damage} damage!"
          defeated = apply_damage(chosen_creature, enemy_damage, @opponent)
          break if defeated
        else
          puts "\nInvalid ability choice!"
        end

      when '2' then @menu.open_bag
      when '3'
        puts "\nYou ran away safely!"
        @menu.map_cases
        break
      else
        puts "\nInvalid choice, try again."
      end
    end
  end
end
