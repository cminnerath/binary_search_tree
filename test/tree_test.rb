require 'minitest/autorun'
require 'minitest/pride'
require './bin/tree'

class TreeTest < Minitest::Test
  def test_it_initializes_with_nil_node
    testtree = Tree.new
    assert_equal nil, testtree.root
  end

  def test_it_can_create_a_new_node
    testnode = Tree.new.new_node('test')
    assert_equal 'test', testnode.data
  end

  def test_it_sets_right_to_nil
    testnode = Tree.new.new_node('test')
    assert_equal nil, testnode.left
  end

  def test_it_sets_left_to_nil
    testnode = Tree.new.new_node('test')
    assert_equal nil, testnode.left
  end

  def test_it_can_insert_a_new_node_with_nil_root
    testtree = Tree.new.insert('test')
    assert_equal 'test', testtree.data
    assert_equal nil, testtree.left
    assert_equal nil, testtree.right
  end

  def test_it_can_insert_a_node_with_existing_root
    testtree = Tree.new
    testnode = testtree.insert(1)
    testtree.insert(2)
    assert_equal 1, testtree.root.data
    assert_equal 2, testtree.root.right.data
  end

  def test_it_can_insert_a_node_to_the_right
    testtree = Tree.new
    testnode = testtree.insert(1)
    testtree.insert(3)
    assert_equal 1, testtree.root.data
    assert_equal 3, testtree.root.right.data
  end

  def test_it_can_insert_a_node_to_the_left
    testtree = Tree.new
    testtree.insert(2)
    testtree.insert(1)
    assert_equal 2, testtree.root.data
    assert_equal 1, testtree.root.left.data
  end

  def test_it_can_make_a_fixnum_tree_in_an_ordered_fashion
    testtree = Tree.new
    testtree.insert(3)
    testtree.insert(4)
    testtree.insert(5)
    testtree.insert(2)
    testtree.insert(1)
    assert_equal 3, testtree.root.data
    assert_equal 4, testtree.root.right.data
    assert_equal 5, testtree.root.right.right.data
    assert_equal 1, testtree.root.left.left.data
    assert_equal 2, testtree.root.left.data
  end

  def test_it_can_make_a_string_tree_in_an_ordered_fashion
    testtree = Tree.new
    testtree.insert('c')
    testtree.insert('d')
    testtree.insert('e')
    testtree.insert('b')
    testtree.insert('a')
    assert_equal 'c', testtree.root.data
    assert_equal 'd', testtree.root.right.data
    assert_equal 'e', testtree.root.right.right.data
    assert_equal 'a', testtree.root.left.left.data
    assert_equal 'b', testtree.root.left.data
  end

  def test_it_can_make_a_tree_in_an_unordered_fashion
    testtree = Tree.new
    testtree.insert(2)
    testtree.insert(4)
    testtree.insert(1)
    testtree.insert(0)
    testtree.insert(7)
    testtree.insert(3)
    testtree.insert(1.8)
    assert_equal 2, testtree.root.data
    assert_equal 1, testtree.root.left.data
    assert_equal 4, testtree.root.right.data
    assert_equal 0, testtree.root.left.left.data
    assert_equal 7, testtree.root.right.right.data
    assert_equal 3, testtree.root.right.left.data
    assert_equal 1.8, testtree.root.left.left.right.data
  end

  def test_it_can_verify_a_value_exists
    testtree = Tree.new
    testtree.insert(2)
    assert_equal 2, testtree.root.data
    assert testtree.include?(2)
  end

  def test_it_can_verify_a_value_does_not_exist
    testtree = Tree.new
    testtree.insert(2)
    assert_equal 2, testtree.root.data
    refute testtree.include?(1)
  end

  def test_it_can_find_depth_of_root_node
    testtree = Tree.new
    testtree.insert(2)
    assert_equal 0, testtree.depth_of(2)
  end

  def test_it_gives_error_message_on_nil_node
    testtree = Tree.new
    testtree.insert(2)
    assert_equal 'Error, data not present in tree', testtree.depth_of(0)
  end

  def test_it_can_find_depth_of_branch_nodes
    testtree = Tree.new
    testtree.insert(2)
    testtree.insert(4)
    testtree.insert(1)
    testtree.insert(0)
    testtree.insert(7)
    testtree.insert(3)
    testtree.insert(8)
    assert_equal 0, testtree.depth_of(2)
    assert_equal 1, testtree.depth_of(4)
    assert_equal 1, testtree.depth_of(1)
    assert_equal 2, testtree.depth_of(0)
    assert_equal 2, testtree.depth_of(7)
    assert_equal 2, testtree.depth_of(3)
    assert_equal 3, testtree.depth_of(8)
    assert_equal 'Error, data not present in tree', testtree.depth_of(17)
  end

  def test_it_can_sort_fixnum_tree_into_an_array
    testtree = Tree.new
    testtree.insert(2)
    testtree.insert(8)
    testtree.insert(4)
    testtree.insert(5)
    testtree.insert(1)
    testtree.insert(6)
    testtree.insert(0)
    testtree.insert(7)
    testtree.insert(-1)
    testtree.insert(3)
    assert_equal [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8], testtree.sort
  end

  def test_it_can_sort_string_tree_into_array
    testtree = Tree.new
    testtree.insert('a')
    testtree.insert('b')
    testtree.insert('c')
    testtree.insert('d')
    testtree.insert('e')
    testtree.insert('f')
    testtree.insert('g')
    testtree.insert('h')
    testtree.insert('i')
    testtree.insert('k')
    assert_equal ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'k'], testtree.sort
  end

  def test_it_can_find_maximum_value
    testtree = Tree.new
    testtree.insert(4)
    assert_equal 4, testtree.maximum
    testtree.insert(2)
    testtree.insert(8)
    assert_equal 4, testtree.root.data
    assert_equal 8, testtree.maximum
    testtree.insert(5)
    testtree.insert(18)
    assert_equal 18, testtree.maximum
  end

  def test_it_can_find_minimum_value
    testtree = Tree.new
    testtree.insert(4)
    assert_equal 4, testtree.minimum
    testtree.insert(2)
    testtree.insert(8)
    assert_equal 4, testtree.root.data
    assert_equal 2, testtree.minimum
    testtree.insert(5)
    testtree.insert(1)
    assert_equal 1, testtree.minimum
  end

  def test_it_can_delete_a_node_from_the_tree
    testtree = Tree.new
    testtree.insert(4)
    testtree.insert(2)
    testtree.insert(3)
    testtree.insert(1)
    testtree.insert(6)
    assert_equal 4, testtree.root.data
    assert_equal 2, testtree.root.left.data
    testtree.delete(2)
    assert_equal 6, testtree.root.data
    assert_equal 3, testtree.root.left.data
  end

  def test_it_errors_when_attempting_to_delete_non_existant_node
    testtree = Tree.new
    testtree.insert(4)
    testtree.insert(2)
    assert_equal 'Error, data not present in tree', testtree.delete(6)
  end
end

