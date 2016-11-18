require 'byebug'
class PolyTreeNode

  attr_accessor :value, :parent, :children

  def initialize(value=nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    #debugger
    if @parent
      old_parent = @parent
      old_parent.children.delete(self)
    end
    @parent = node
    unless @parent.nil? || @parent.children.include?(self)
      @parent.children << self
    end
  end

  def add_child(node)
    @children << node
    node.parent = self
  end

  def remove_child(node)
    if @children.include?(node)
      node.parent = nil

      @children.delete(node)
    else
      raise "error"
    end
  end

  def dfs(target)
    return self if self.value == target
    children.each do |child|
      current_node = child.dfs(target)
      return current_node if current_node
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      queue += current_node.children
    end
  end
end
