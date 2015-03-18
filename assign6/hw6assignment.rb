# Dustin Chang
# Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  # your enhancements here

=begin	#MIGHT NOT NEED
  def initialize (point_array, board)
    @all_rotations = point_array
    @rotation_index = (0..(@all_rotations.size-1)).to_a.sample
    @color = All_Colors.sample
    @base_position = [5, 0] # [column, row]
    @board = board
    @moved = true
  end
=end
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
	               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
	               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
	               [[0, 0], [0, -1], [0, 1], [0, 2]]],
	               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
	               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
	               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
	               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
	               #Added 3 more
	               [[[0, 0], [-1, 0], [1, 0], [-2, 0], [2, 0]], #2 for --
	               [[0, 0], [0, -1], [0, 1], [0, 2], [0, -2]]], # |
	               rotations([[0, 0], [0, 1], [1, 0]]), # Short L
	               rotations([[0, 0], [1, 0], [-1, 0], [0, 1], [-1, 1]]), # sq with extra 1
	               rotations([[0, 0], [1, 0], [-1, 0], [0, 1], [1, 1]])] # inverted sq with extra 1

 	#Might need it's own next_piece method
=begin
 	def next_piece(board)
 		MyPiece.new(All_My_Pieces.sample, board)
 	end
=end
	#puts @all_rotations.to_s
	def self.next_piece (board)
		puts 'In next_piece2.1'
		MyPiece.new(All_My_Pieces.sample, board)
  end

end	#End of MyPiece



class MyBoard < Board
  # your enhancements here
  def initialize(game)
  	@grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    puts 'In MyBoard'
  end
  
  def next_piece
  	@current_block = MyPiece.next_piece(self)
  	@current_pos = nil
  	puts 'In next_piece2.2'
  end

=begin
  def run
  	puts 'in run2'
    ran = @current_block.drop_by_one
    if !ran
      store_current
      if !game_over?
        next_piece
      end
    end
    @game.update_score
    draw
  end
=end

  #modify store_current HERE
  def store_current
  	puts 'In store_current2'
  	locations = @current_block.current_rotation
  	block_cells_size = locations.size
  	puts block_cells_size
  	#puts locations


  	#abort("Ending")

  	if locations[4] == nil
  		displacement = @current_block.position
	    (0..3).each{|index| 
	      current = locations[index];
	      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
	      @current_pos[index]
	    }
	    remove_filled
	    @delay = [@delay - 2, 80].max
	  elsif locations[3] == nil
	  	displacement = @current_block.position
	    (0..2).each{|index| 
	      current = locations[index];
	      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
	      @current_pos[index]
	    }
	    remove_filled
	    @delay = [@delay - 2, 80].max
	  elsif locations[1] == nil
	  	displacement = @current_block.position
	    	current = locations[0]
	      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
	      @current_pos[0]
	    remove_filled
	    @delay = [@delay - 2, 80].max
	  else
	  	displacement = @current_block.position
	    (0..4).each{|index| 
	      current = locations[index];
	      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
	      @current_pos[index]
	    }
	    remove_filled
	    @delay = [@delay - 2, 80].max
	  end

  end #End of store_current

end #End of MyBoard




class MyTetris < Tetris
  # your enhancements here
  def key_bindings
  	super
  	@root.bind('u', lambda {@board.rotate_clockwise	#Binds 'u' to rotate 180 deg
  							@board.rotate_clockwise})
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

end #End of MyTetris


