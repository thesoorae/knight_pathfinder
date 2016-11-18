class KnightPathFinder
  def initialize(pos)
    @pos = pos
    @visited_positions = [pos]
    @start_pos = pos
    @possible_pos = []
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
  end

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
    x.between?(0,8) && y.between?(0,8)
  end


end
