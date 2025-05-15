# frozen_string_literal: true

# Boxes
class BoxesRepo
  include Enumerable
  attr_reader :boxes

  def initialize(boxes = [])
    @boxes = boxes
  end

  def each(&block)
    @boxes.each(&block)
  end

  def [](index)
    @boxes[index]
  end

  def add_to_box(creature)
    @boxes << creature
  end

  def remove_from_box(index)
    @boxes.delete_at(index)
  end
end
