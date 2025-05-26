# frozen_string_literal: true

# models/player.rb
class Player
  attr_accessor :name, :money, :badges

  def initialize(attributes = {})
    @name = attributes[:name] || 'Trainer'
    @money = attributes[:money] || 5000
    @badges = attributes[:badges] || []
  end

  def to_h
    {
      name: @name,
      money: @money,
      badges: @badges
    }
  end
end
