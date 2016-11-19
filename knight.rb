require 'byebug'
require_relative '00_tree_node.rb'
class Knight

attr_accessor :position, :visited_positions, :possible_pos, :parent, :root_node, :visited_nodes

  def initialize(pos, size=8)
    @position = pos
    @visited_positions = []
    @size = size
    @visited_nodes = []
    @root_node = PolyTreeNode.new(position)
  end


  def new_move_positions(pos)
    new_moves = valid_moves(pos)
    new_moves.each do |move|
      if @visited_positions.include?(move)
        new_moves.delete(move)
      else
        @visited_positions << move
      end
    end
    new_moves
  end


  def build_move_tree
    #debugger
    current_node =  root_node
    current_moves = [position]
    until current_moves.empty?
      new_current_moves = []
      current_moves.each do |current_move|
        current_node = PolyTreeNode.new(current_move)
        valid_moves(current_move).each do |possible_move|
          next if @visited_positions.include?(possible_move)
          new_current_moves << possible_move
          @visited_positions << possible_move
          new_node = PolyTreeNode.new(possible_move)
          @visited_nodes << new_node
          current_node.add_child(new_node)
        #  p "#{new_node.value} parent:#{new_node.parent}"#{}" kids: #{new_no.children}"
#        p visited_nodes
        end
      end
      current_moves = new_current_moves
    end
  end

  
  #
  # def find_path(end_pos, node=root_node)
  #   queue = [position]
  #   path = []
  #   return [end_pos] if node.value == end_pos
  #   visited_nodes.each do |node|
  #     node.children.each do |child|
  #       current_result = find_path(end_pos, child)
  #       return current_result if current_result
  #     end
  #     nil
  #     end
  #
  # end

def find_path(target)
   queue = [root_node]
  until queue.empty?
    p current_node = queue.shift
    p queue
    return current_node if current_node.value == target
    current_node.children.each do |child|
      queue << child
    end
  end
  nil
end



  def frownyface
   #debugger

    queue = [PolyTreeNode.new(position)]
    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      new_move_positions(current_pos).each do |move_pos|
        new_node = PolyTreeNode.new(move_pos)
        new_node.parent = current_node
        queue << new_node unless queue.include?(new_node)
        p "pos: #{new_node.value} parent: #{new_node.parent.value}"
      end
    end
  end


  # def build_move_tree
  #  #debugger
  #
  #   queue = [self]
  #   until queue.empty?
  #
  #     current_node = queue.shift
  #     current_pos = current_node.position
  #     new_move_positions(current_pos).each do |move_pos|
  #       new_node = Knight.new(move_pos,@size)
  #       current_node.add_pos(new_node) unless @visited_positions.include?(move_pos)
  #       queue << new_node unless queue.include?(new_node)
  #       p new_node
  #     end
  #   end
  # end

  def valid_moves(pos)
    valid_moves = []
    long = [-2,2]
    short = [1,-1]
    valid_moves += valid_moves_helper(pos, long, short)
    valid_moves += valid_moves_helper(pos, short, long)
  end

  def valid_moves_helper(pos, arr1, arr2)
    x,y = pos
    valid_moves = []
    arr1.each do |move|
      arr2.each do |move2|
        new_pos = [x + move, y + move2]
        valid_moves << new_pos if inbounds?(new_pos)
      end
    end
    valid_moves
  end

  def inbounds?(pos)
    x,y = pos
    x.between?(0,@size) && y.between?(0,@size)
  end

  # def parent=(node)
  #   if @parent
  #     old_parent = @parent
  #     old_parent.possible_pos.delete(self)
  #   end
  #   @parent = node
  #   unless @parent.nil? || @parent.possible_pos.include?(self)
  #     @parent.possible_pos << self
  #   end
  # end

  # def add_pos(node)
  #   @possible_pos << node
  #   node.parent = self
  #   node.visited_positions += @visited_positions
  # end
end
