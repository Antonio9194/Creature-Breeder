class Creapedia
  # Initialize an empty hash to store creatures
  def initialize
    @creapedia = {
      'Lavagor' => Creature.new('Lavagor', 'Drake', 'Fire'),
      'Blazurn' => Creature.new('Blazurn', 'Drake', 'Fire'),
      'Infernoir' => Creature.new('Infernoir', 'Drake', 'Fire'),
      'Pyronis' => Creature.new('Pyronis', 'Drake', 'Fire'),
      'Scorchil' => Creature.new('Scorchil', 'Drake', 'Fire'),

      'Aqualis' => Creature.new('Aqualis', 'Sylph', 'Water'),
      'Droplin' => Creature.new('Droplin', 'Sylph', 'Water'),
      'Tidalyn' => Creature.new('Tidalyn', 'Sylph', 'Water'),
      'Rivelle' => Creature.new('Rivelle', 'Sylph', 'Water'),
      'Nymbria' => Creature.new('Nymbria', 'Sylph', 'Water'),

      'Terronox' => Creature.new('Terronox', 'Golem', 'Earth'),
      'Craggit' => Creature.new('Craggit', 'Golem', 'Earth'),
      'Granitox' => Creature.new('Granitox', 'Golem', 'Earth'),
      'Stonelith' => Creature.new('Stonelith', 'Golem', 'Earth'),
      'Dirtlek' => Creature.new('Dirtlek', 'Golem', 'Earth'),

      'Fangor' => Creature.new('Fangor', 'Beast', 'Air'),
      'Howlit' => Creature.new('Howlit', 'Beast', 'Air'),
      'Gryvorn' => Creature.new('Gryvorn', 'Beast', 'Air'),
      'Talondo' => Creature.new('Talondo', 'Beast', 'Air'),
      'Whispark' => Creature.new('Whispark', 'Beast', 'Air'),

      'Voltrag' => Creature.new('Voltrag', 'Drake', 'Electric'),
      'Zephyla' => Creature.new('Zephyla', 'Sylph', 'Air'),
      'Glacira' => Creature.new('Glacira', 'Sylph', 'Ice'),
      'Obelisk' => Creature.new('Obelisk', 'Golem', 'Rock'),
      'Nightclaw' => Creature.new('Nightclaw', 'Beast', 'Dark'),

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

  # Access all creatures
  def all_creatures
    @creapedia.values
  end

  # Add a new creature
  def add_creature(creature)
    @creapedia[creature.name] = creature
  end
end
