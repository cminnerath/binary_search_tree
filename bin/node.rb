class Node
  attr_accessor :data, :left, :right
  def initialize(data, left = nil, right = nil)
    @data  = data
    @left  = left
    @right = right
  end

  def sort(sorted)
    left.sort(sorted) if left
    sorted << data
    right.sort(sorted) if right
    sorted
  end
end
