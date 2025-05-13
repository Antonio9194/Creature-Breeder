# frozen_string_literal: true

require_relative 'team'

# Boxes
class BoxesRepo
  attr_reader :boxes

  def initialize(boxes = [])
    @boxes = boxes
  end

  def add_to_boxes(creature)
    if @team.size <= 1
      puts 'You must have at least one creature in your team!'
      return
    end
    @boxes << creature
  end

  def remove_from_boxes(index)
    @boxes.delete_at(index) if index.between?(0, @team.size - 1)
  end
end
