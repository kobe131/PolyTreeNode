require_relative '00_tree_node.rb'

class KnightPathFinder
  attr_reader :start_pos, :visited_positions, :tree
  
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    build_move_tree
  end
  
  def build_move_tree
    start = PolyTreeNode.new(start_pos)
    que = [start]
    @tree = [start]
    
    until que.empty?
      node = (que.shift)
      psmoves = new_move_positions(node.value)
      
      psmoves.each do |move|
        child = PolyTreeNode.new(move, node)
        que.push(child)
        node.add_child(child)
        @tree.push(child)
      end 
    end 
    
    @tree
  end
  
  def find_path(pos)
    ending_position = @tree.first.bfs(pos)
    trace_path_back(ending_position)
  end
  
  def trace_path_back(ending_position)
    path = [ending_position.value]
    node = ending_position
    until node.parent.nil?
      path.unshift(node.parent.value)
      node = node.parent
    end 
    
    path
  end
  
  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos)
    new_moves.reject! {|move| @visited_positions.include?(move)}
    @visited_positions.concat(new_moves)
    new_moves
  end
  
  def self.valid_moves(pos)
    valid_moves = []
    pos_changes = [[2,1],[1,2],[2,-1],[-1,2],[-2,1],[-2,-1],[1,-2],[-1,-2]]
    
    pos_changes.each do |change|
      new_x = change[0]+pos[0]
      new_y = change[1]+pos[1]
      if new_x.between?(0,7) && new_y.between?(0,7)
        valid_moves << [new_x, new_y]
      end 
    end 
    
    valid_moves
  end
  
end 