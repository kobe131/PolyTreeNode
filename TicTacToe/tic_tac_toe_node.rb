require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :children
  attr_accessor :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if self.is_a?(TicTacToeNode)
      debugger
      other_mark = evaluator == :x ? :o : :x
      return false if self.board.winner == other_mark
      return true
    end 
    children.each do |child|
      other_mark = evaluator == :x ? :o : :x
      return false if child.board.winner == other_mark
    end 
    
    true
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @children = []
    positions = empty_positions
    positions.each do |square|
      new_board = board.dup
      new_board[square] = next_mover_mark
      prev_move_pos = square
      new_move_mark = next_mover_mark == :x ? :o : :x
      @children << TicTacToeNode.new(new_board, new_move_mark, prev_move_pos)
    end 
    # debugger
    @children
  end
  
  def empty_positions
    empty_positions = []
    board.rows.each_index do |idx|
      board.rows[idx].each_index do |idx2|
        empty_positions << [idx, idx2] if board.empty?([idx, idx2])
      end 
    end 
    
    empty_positions
  end
  
  
end
