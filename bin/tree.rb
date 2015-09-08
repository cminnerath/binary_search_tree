require_relative 'node'                      # => true
class Tree
  attr_accessor :root, :data, :left, :right  # => nil

  def initialize
    @root = nil
    @sorted = []
  end             # => :initialize

  def new_node(data, left = nil, right = nil)
    Node.new(data, left, right)
  end                                          # => :new_node

  def insert(data)
    @current = @root
    if @current.nil?
      @root = new_node(data)
    else
      insert_node(data)
    end
  end                         # => :insert

  def insert_node(data)
    if data < @current.data
      insert_left(data)
    else
      insert_right(data)
    end
  end                        # => :insert_node

  def insert_left(data)
    while !@current.left.nil?
      @current = @current.left
      if @current.data < data
        insert_right(data)
      else
        insert_left(data)
      end
    end
    if data < @current.data
      @current.left = Node.new(data)
    elsif data > @current.data
      @current.right = Node.new(data)
    end
  end                                  # => :insert_left

  def insert_right(data)
    while !@current.right.nil?
      @current = @current.right
      if @current.data > data
        insert_left(data)
      else
        insert_right(data)
      end
    end
    if data < @current.data
      @current.left = Node.new(data)
    elsif data > @current.data
      @current.right = Node.new(data)
    end
  end                                  # => :insert_right

  def include?(data, current = @root)
    if current.nil?
      false
    elsif current.data == data
      true
    elsif current.data < data
      current = current.right
      include?(data, current)
    else
      current = current.left
      include?(data, current)
    end
  end                                  # => :include?

  def depth_of(data, current = @root, depth = 0)
    if current == nil
      depth = 'Error, data not present in tree'
    elsif current.data < data
      depth += 1
      current = current.right
      depth_of(data, current, depth)
    elsif current.data > data
      depth += 1
      current = current.left
      depth_of(data, current, depth)
    else
      depth
    end
  end                                             # => :depth_of

  def maximum(current = @root)
    until current.right.nil?
      current = current.right
    end
    current.data
  end                           # => :maximum

  def minimum(current = @root)
    until current.left.nil?
      current = current.left
    end
    current.data
  end                           # => :minimum

  def sort(current = @root)
    return @sorted if current.nil?
    sort(current.left)
      if !@sorted.include? current.data
        @sorted << current.data
      end
    sort(current.right)
  end                                    # => :sort

  def delete(data)
    current = @root
    if include?(data)
      sorted = sort(current)
      @root = nil
      sorted.delete(data)
      count = sorted.count
      sorted = rebalance(sorted)
      sorted.each do |data|
        insert(data)
      end
    else
    'Error, data not present in tree'
    end
  end

  def rebalance(sorted)
    sorted.delete(data)
    count = sorted.count
    sorted_first = sorted[0...count /2].reverse
    sorted_second = sorted[count /2..-1].reverse
    sorted = sorted_first.zip(sorted_second).flatten
    sorted = sorted.compact
  end                           # => :delete
end                                         # => :delete
