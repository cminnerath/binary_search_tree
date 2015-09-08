require 'minitest/autorun'
require 'minitest/pride'
require './bin/node'

class NodeTest < Minitest::Test
  def test_it_can_create_a_node
    testnode = Node.new('test')
    assert_equal 'test', testnode.data
    assert_equal nil, testnode.left
    assert_equal nil, testnode.right
  end

  def test_it_can_create_a_fixnum_node
    testnode = Node.new(1)
    assert_equal 1, testnode.data
    assert_equal nil, testnode.left
    assert_equal nil, testnode.right
  end
end
