# models/player.rb
class Player
  attr_accessor :name, :money, :badges

  def initialize(attributes = {})
    @name = attributes[:name] || 'Trainer'
    @money = attributes[:money] || 5000
    @badges = attributes[:badges] || []
  end

  def self.from_h(hash)
    new(
      name: hash['name'],
      money: hash['money'],
      badges: hash['badges']
    )
  end

  def to_h
    {
      name: @name,
      money: @money,
      badges: @badges
    }
  end
end
