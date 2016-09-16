require 'byebug'

class PolyTreeNode

  attr_accessor :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent= (node)
    @parent.children.delete(self) unless @parent.nil?

    @parent = node
    return @parent if node.nil?

    node.children << self
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "error" unless @children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    return nil if @children.empty?

    @children.each do |child|
      answer = child.dfs(target_value)
      return answer if answer
    end

    nil
  end
end
