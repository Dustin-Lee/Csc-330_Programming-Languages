# Programming Languages, Homework 6, hw6runner.rb

require './hw6provided'
require './hw6assignment'

def runTetris
  Tetris.new 
  mainLoop
end

def runMyTetris
  MyTetris.new
  mainLoop
end

def runMyTetrisChallenge	#Challenge function
	MyTetrisChallenge.new
	mainLoop
end

if ARGV.count == 0
  runMyTetris
elsif ARGV.count != 1
  puts "usage: hw6runner.rb [enhanced | original]"
elsif ARGV[0] == "enhanced"
  runMyTetris
elsif ARGV[0] == "original"
  runTetris
elsif ARGV[0] == "challenge"	#Added for Challenge Problem
	runMyTetrisChallenge
else
  puts "usage: hw6runner.rb [enhanced | original]"
end

