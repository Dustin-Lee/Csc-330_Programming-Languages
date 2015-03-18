# Dustin Chang
# Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  # your enhancements here
=begin
  def move (delta_x, delta_y, delta_rotation)
  	moved = true
  	potential = @all_rotations[(@rotation_index + delta_rotation) % @all_rotations.size]
    if potential != 0
      potential.each{|posns| 
        if !(@board.empty_at([posns[0] + delta_x + @base_position[0],
          posns[1] + delta_y + @base_position[1]]));
          moved = false;
        end
      }
    else
=end



  Cheat_Piece = [[[[0, 0]]]]

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

	def self.next_piece_cheat (board)
		puts 'In next_piece2.1.cheat'
		MyPiece.new(Cheat_Piece.sample, board)
	end

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
    @board_cheat_status = false
    puts 'In MyBoard'
  end
  
  def next_piece
  	if @board_cheat_status
  		puts 'In next_piece2.cheat'
  		@current_block = MyPiece.next_piece_cheat(self)
  		puts 'AFTER In next_piece2.cheat1'
  		@current_pos = nil
  		puts 'AFTER In next_piece2.cheat2'
  		@board_cheat_status = false
  		puts 'AFTER In next_piece2.cheat3'
  	else
  		@current_block = MyPiece.next_piece(self)
  		@current_pos = nil
  		puts 'In next_piece2.2'
  	end
  end

  def remove_delay	#To remove repeatable code within store_current
  	#@grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[index]}
  	remove_filled
	  @delay = [@delay - 2, 80].max
	end

  def store_current
  	puts 'In store_current2'
  	locations = @current_block.current_rotation
  	block_cells_size = locations.size
  	puts block_cells_size
  	if locations[1] == nil
  		displacement = @current_block.position
  		current = locations[0]
  		@grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[0]
  		remove_filled
  		@delay = [@delay - 2, 80].max
  	elsif locations[3] == nil
  		displacement = @current_block.position
  		(0..2).each{|index| current = locations[index];
  		@grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[index]}
  		remove_delay
  	elsif locations[4] == nil
  		displacement = @current_block.position
  		(0..3).each{|index| current = locations[index];
  		@grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[index]}
  		remove_delay
	  else
      puts 'In 5'
	  	displacement = @current_block.position
	  	(0..4).each{|index| current = locations[index];
	  	@grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[index]}
	  	remove_delay
	  end
  end #End of store_current

  def update_cheat_score
  	@score = @score - 100
  	@board_cheat_status = true
  	@game.update_score
    #@current_block = MyPiece.next_piece_cheat(self)
    #@current_pos = nil
  end

end #End of MyBoard



class MyTetris < Tetris
  # your enhancements here
  @@cheat_status = false
  attr_accessor :board
  def key_bindings
  	super
  	@root.bind('u', lambda {@board.rotate_clockwise	#Binds 'u' to rotate 180 deg
  													@board.rotate_clockwise})
  	@root.bind('c', lambda {self.cheat})
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def cheat
  	puts 'In cheat def'
  	if @@cheat_status == false
  		puts 'Passed FALSE'
  		puts @board.score
  		if @board.score >= 100
  			puts 'In >= 100'
  			@@cheat_status = true	#To make sure it can't be called multiple times per block
  			@board.update_cheat_score

  			
  			puts 'AFTER2'
  		end
  	end
  end
end #End of MyTetris


