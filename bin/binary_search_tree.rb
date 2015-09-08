require_relative 'tree'
require_relative 'node'

class BinarySearchTree
  def initialize
    @file = ARGV[0]
    @output = ARGV[1]
    @tree = Tree.new
    collect_input
    write_output
  end

  def collect_input
    input = File.readlines("#{@file}", "r").map do |line|
      line.split.map(&:to_i)
    end
    input = input.flatten
    @results = input.each do |value|
      @tree.insert(value)
    end
    @results
  end

  def write_output
    results = @tree.sort.flatten
    output = File.new("#{@output}", "w")
    results.each do |value|
      output.write(value.to_s + "\n")
    end
  end
end
BinarySearchTree.new