# Dustin Chang
# Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  # your enhancements here
  @cheat = false

  Cheat_Piece = [[0, 0]]

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

	def self.next_piece (board)
		if @cheat
			puts 'In next_piece2.1.cheat'
			MyPiece.new(Cheat_Piece.sample, board)
			@cheat = false
		else
			puts 'In next_piece2.1'
			MyPiece.new(All_My_Pieces.sample, board)
		end
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

  def remove_delay	#To remove repeatable code within store_current
  	remove_filled
	  @delay = [@delay - 2, 80].max
	end

  #modify store_current HERE
  def store_current
  	puts 'In store_current2'
  	locations = @current_block.current_rotation
  	block_cells_size = locations.size
  	puts block_cells_size
  	#puts locations
  	#abort("Ending")
  	if locations[1] == nil
  		puts 'In 1'
  		displacement = @current_block.position
  		current = locations[0]
  		@grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[0]
  		remove_delay
  	elsif locations[3] == nil
  		puts 'In 3'
  		displacement = @current_block.position
  		(0..2).each{|index| current = locations[index];
  		@grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[index]}
  		remove_delay
  	elsif locations[4] == nil
  		puts 'In 4'
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
  	@game.update_score
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
  			puts 'AFTER'
  			@board.update_cheat_score
  			#@score = 155
  			puts 'AFTER2'  			
  			#update_score
  			puts 'AFTER3'

  		end
  	end
  end
end #End of MyTetris


