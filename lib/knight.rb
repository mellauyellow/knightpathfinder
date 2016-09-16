require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :node

  def self.valid_moves(pos)
    x, y = pos
    delta_coords = KnightPathFinder.generate_coords

    possible_moves = delta_coords.map do |coord|
      d_x, d_y = coord
      [x + d_x, y + d_y]
    end

    valid_poss_moves = possible_moves.select do |move|
      x, y = move
      (0..7).include?(x) && (0..7).include?(y)
    end
  end

  def self.generate_coords
    array = [-2, -1, 1, 2]

    coords = []

    array.each_with_index do |el1, idx1|
	    array.each_with_index do |el2, idx2|
		    coords << [array[idx1], array[idx2]] unless array[idx2].abs == array[idx1].abs
	    end
    end
    coords
  end

  def initialize(pos)
    @node = PolyTreeNode.new(pos)
    @board = Array.new(8) {Array.new(8)}
    @visited_positions = [pos]
    build_move_tree(@node)
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos).select do |move|
      !@visited_positions.include?(move)
    end
    @visited_positions += possible_moves
    possible_moves
  end

  def build_move_tree(node)
    # possible_moves = [node]
    #
    # until possible_moves.empty?
    #   current_node = possible_moves.shift
    #   next_moves = KnightPathFinder.valid_moves(current_node.value).select do |move|
    #     !@visited_positions.include?(move)
    #   end
    #
    #   next_moves.each do |move|
    #     new_node = PolyTreeNode.new(move)
    #     new_node.parent = current_node
    #     possible_moves << new_node
    #   end
    #
    #   new_move_positions(current_node.value)
    #
    # end
    possible_moves = [node]

    until possible_moves.empty?
      current_node = possible_moves.shift
      next_moves = new_move_positions(current_node.value)

      next_moves.each do |move|
        new_node = PolyTreeNode.new(move)
        new_node.parent = current_node
        possible_moves << new_node
      end
    end

  end

  def find_path(end_pos)
    target_node = @node.bfs(end_pos)

    trace_path_back(target_node)
  end

  def trace_path_back(node)
    path = [node.value]

    until node == @node
      path.unshift(node.parent.value)
      node = node.parent
    end

    path
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

end
