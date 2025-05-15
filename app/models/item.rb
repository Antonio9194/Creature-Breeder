# frozen_string_literal: true

# Items Model
class Item
  def initialize(id:, name:, quantity:, description:, type:)
    @id = id
    @name = name
    @quantity = quantity
    @description = description
    @type = type # Key Items, Healing, Capture, Money, Badges
  end
end
