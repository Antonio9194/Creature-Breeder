# frozen_string_literal: true

# Boxes
class BoxesRepo
  attr_reader :boxes

  def initialize(boxes = [])
    @boxes = boxes
  end

  def add(creature)
    @boxes << creature
  end

  def remove(index)
    @boxes.delete_at(index)
  end
end
