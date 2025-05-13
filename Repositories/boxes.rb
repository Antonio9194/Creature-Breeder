# frozen_string_literal: true

# Boxes
class BoxesRepo
  attr_reader :boxes

  def initialize(boxes = [])
    @boxes = boxes
  end

  def add_to_boxes(creature)
    @boxes << creature
  end

  def remove_from_boxes(index)
    @boxes.delete_at(index) if index.between?(0, @team.size - 1)
  end
end
