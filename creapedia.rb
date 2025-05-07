# frozen_string_literal: true

require 'JSON'

require_relative 'creature'

# Creaapedia stores all creatues
class Creapedia
  # Initialize an empty hash to store creatures
  def initialize
    @creapedia = {
      'Lavagor' => Creature.new('Lavagor', 'Drake', 'Fire', { rarity: 'Rare' }),
      'Blazurn' => Creature.new('Blazurn', 'Drake', 'Fire', { rarity: 'Common' }),
      'Infernoir' => Creature.new('Infernoir', 'Drake', 'Fire', { rarity: 'Common' }),
      'Pyronis' => Creature.new('Pyronis', 'Drake', 'Fire', { rarity: 'Common' }),
      'Scorchil' => Creature.new('Scorchil', 'Drake', 'Fire', { rarity: 'Common' }),

      'Aqualis' => Creature.new('Aqualis', 'Sylph', 'Water', { rarity: 'Rare' }),
      'Droplin' => Creature.new('Droplin', 'Sylph', 'Water', { rarity: 'Common' }),
      'Tidalyn' => Creature.new('Tidalyn', 'Sylph', 'Water', { rarity: 'Common' }),
      'Rivelle' => Creature.new('Rivelle', 'Sylph', 'Water', { rarity: 'Common' }),
      'Nymbria' => Creature.new('Nymbria', 'Sylph', 'Water', { rarity: 'Common' }),

      'Terronox' => Creature.new('Terronox', 'Golem', 'Earth', { rarity: 'Rare' }),
      'Craggit' => Creature.new('Craggit', 'Golem', 'Earth', { rarity: 'Common' }),
      'Granitox' => Creature.new('Granitox', 'Golem', 'Earth', { rarity: 'Common' }),
      'Stonelith' => Creature.new('Stonelith', 'Golem', 'Earth', { rarity: 'Common' }),
      'Dirtlek' => Creature.new('Dirtlek', 'Golem', 'Earth', { rarity: 'Common' }),

      'Fangor' => Creature.new('Fangor', 'Beast', 'Air', { rarity: 'Rare' }),
      'Howlit' => Creature.new('Howlit', 'Beast', 'Air', { rarity: 'Common' }),
      'Gryvorn' => Creature.new('Gryvorn', 'Beast', 'Air', { rarity: 'Common' }),
      'Talondo' => Creature.new('Talondo', 'Beast', 'Air', { rarity: 'Common' }),
      'Whispark' => Creature.new('Whispark', 'Beast', 'Air', { rarity: 'Common' }),

      'Voltrag' => Creature.new('Voltrag', 'Drake', 'Electric', { rarity: 'Legendary' }),
      'Zephyla' => Creature.new('Zephyla', 'Sylph', 'Air', { rarity: 'Legendary' }),
      'Glacira' => Creature.new('Glacira', 'Sylph', 'Ice', { rarity: 'Legendary' }),
      'Obelisk' => Creature.new('Obelisk', 'Golem', 'Rock', { rarity: 'Legendary' }),
      'Nightclaw' => Creature.new('Nightclaw', 'Beast', 'Dark', { rarity: 'Legendary' }),

      'Drakorin' => Creature.new('Drakorin', 'Drake', 'Fire'),
      'Flamora' => Creature.new('Flamora', 'Drake', 'Fire'),
      'Inferlith' => Creature.new('Inferlith', 'Drake', 'Fire'),
      'Pyroscorch' => Creature.new('Pyroscorch', 'Drake', 'Fire'),
      'Scorcharis' => Creature.new('Scorcharis', 'Drake', 'Fire'),

      'Aqualyn' => Creature.new('Aqualyn', 'Sylph', 'Water'),
      'Droplira' => Creature.new('Droplira', 'Sylph', 'Water'),
      'Tidalora' => Creature.new('Tidalora', 'Sylph', 'Water'),
      'Rivelith' => Creature.new('Rivelith', 'Sylph', 'Water'),
      'Nybrilla' => Creature.new('Nybrilla', 'Sylph', 'Water'),

      'Terrorock' => Creature.new('Terrorock', 'Golem', 'Earth'),
      'Craggira' => Creature.new('Craggira', 'Golem', 'Earth'),
      'Granith' => Creature.new('Granith', 'Golem', 'Earth'),
      'Stonemaw' => Creature.new('Stonemaw', 'Golem', 'Earth'),
      'Dirtstone' => Creature.new('Dirtstone', 'Golem', 'Earth'),

      'Fangflare' => Creature.new('Fangflare', 'Beast', 'Air'),
      'Howlwind' => Creature.new('Howlwind', 'Beast', 'Air'),
      'Gryvanth' => Creature.new('Gryvanth', 'Beast', 'Air'),
      'Talondro' => Creature.new('Talondro', 'Beast', 'Air'),
      'Whispraze' => Creature.new('Whispraze', 'Beast', 'Air'),

      'Voltira' => Creature.new('Voltira', 'Drake', 'Electric'),
      'Zephyros' => Creature.new('Zephyros', 'Sylph', 'Air'),
      'Glacilith' => Creature.new('Glacilith', 'Sylph', 'Ice'),
      'Obelith' => Creature.new('Obelith', 'Golem', 'Rock'),
      'Nightfury' => Creature.new('Nightfury', 'Beast', 'Dark'),

      'Flamewhirl' => Creature.new('Flamewhirl', 'Drake', 'Fire'),
      'Aquablade' => Creature.new('Aquablade', 'Sylph', 'Water'),
      'Terroblast' => Creature.new('Terroblast', 'Golem', 'Earth'),
      'Whirlstorm' => Creature.new('Whirlstorm', 'Beast', 'Air'),
      'Voltrise' => Creature.new('Voltrise', 'Drake', 'Electric'),
      'Zephylaura' => Creature.new('Zephylaura', 'Sylph', 'Air'),
      'Glacialite' => Creature.new('Glacialite', 'Sylph', 'Ice'),
      'Oblitrack' => Creature.new('Oblitrack', 'Golem', 'Rock'),
      'Nightclawra' => Creature.new('Nightclawra', 'Beast', 'Dark')
    }
  end

  # Access creatures by name
  def find_by_name(name)
    @creapedia[name]
  end

  # Discovered creatures number
  def discovered_entries_num
    @creapedia.values.select(&:discovered).size
  end

  def discovered_entries_list
    @creapedia.values
              .select(&:discovered)
              .map do |creature|
                discovered_mark = creature.discovered ? '✅' : '❌'
                owned_mark = creature.owned ? '✅' : '❌'
                "#{creature.name} - Discovered: #{discovered_mark}, Owned: #{owned_mark}"
              end
              .join("\n")
  end

  def to_json_data(player)
    {
      player: player,
      player_creapedia: discovered_entries_list
    }
  end

  def add_entry(entry)
    @discovered_entries_list << entry unless @discovered_entries_list.include?(entry)
  end
end
