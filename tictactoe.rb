#Board object, creates default board
class Board
	@@Board = { "A" => [" "," "," "] , "B" => [" "," "," "] , "C" => [" "," "," "]}
	def intialize
	end
	def self.display
		puts  "   1  2  3"
		@@Board.each_key do |i|
			print i 
			puts "  #{@@Board[i][0]}| #{@@Board[i][1]} |#{@@Board[i][2]} "
			puts "  --+---+--" unless i == "C"
		end
	end
	def self.check(row,column)
		if (@@Board.fetch(row)[column-1] == "X" || @@Board.fetch(row)[column-1] == "O")
			false 
		else
			true
		end

	end
	def self.place(row,column,symbol)
		@@Board.fetch(row)[column - 1] = symbol
		
	end
	def self.clear
		@@Board = { "A" => [" "," "," "] , "B" => [" "," "," "] , "C" => [" "," "," "]}
	end
	def self.game_finished?
		#check horizontals
		return true if @@Board.has_value?(['X','X','X']) || @@Board.has_value?(['O','O','O'])
		#check verticals  
		@@Board.each_value do |i|
			3.times do |p|
				count = 0
				count += 1 if i[p] == 'X' 
				return true if count == 3
			end
			3.times do |p|
				count = 0
				count += 1 if i[p] == 'O' 
				return true if count == 3
			end
		end
		#check diagonals
		@@Board.each_value do |i|
			return false unless @@Board["B"][1] == 'X' || @@Board["B"][1] == 'O' 
			if @@Board["B"][1] == 'X' 
				return true if (@@Board["A"][0] == 'X' && @@Board["C"][2] == 'X') || (@@Board["A"][2] == 'X' && @@Board["C"][0] == 'X')
			else
				return true if (@@Board["A"][0] == 'O' && @@Board["C"][2] == 'O') || (@@Board["A"][2] == 'O' && @@Board["C"][0] == 'O')
			end
			return false
		end

	end
end
class Player
	attr_accessor :number_of_players
	@@number_of_players = 0
	def initialize
		@@number_of_players += 1
		
	end
end
class User < Player
	attr_accessor :symbol
	def initialize(first)

		first == true ? @symbol = 'X' : @symbol = 'O'
	end
	public
	def play
		puts "----------------------------------------"
		puts "-              YOUR TURN!              -"
		puts "----------------------------------------"
		puts "What row? (A to C)"
		input = gets.chomp.upcase
		until (input.include?("A") || input.include?("B") || input.include?("C"))
			x = input.to_s
		end
		puts "What column? (1 to 3)"
		input = gets.chomp.to_i
		if (1..3).include?(input) 
			y = input.to_i 
		else
			puts "Please enter a number from 1 to 3"
			play
		end
		if Board.check(x,y) != true
			puts "You can't play there"
			play 
		else
			puts "User plays at position #{x},#{y}"
			Board.place(x,y,@symbol)
		end 
		
		

	end 

end
class Opponent < Player
	def initialize(first)
		first == true ? @symbol = "O" : @symbol = "X"
	end
	public
	def play
		puts "----------------------------------------"
		puts "-            COMPUTER TURN!            -"
		puts "----------------------------------------"
		x = rand(1..3).floor
		y = rand(1..3).floor
		case y
		when 1
			y = "A"
		when 2
			y = "B"
		when 3
			y = "C"
		end
		if Board.check(y,x) != true
			puts "You can't play there"
			play 
		else
			puts "Computer plays at position #{y},#{x}"
			Board.place(y,x,@symbol)
		end 
	end

end

#sees if the user would like to go first , assigns first to true or false
def game
puts "----------------------------------------"
puts "-             TIC TAC TOE              -"
puts "----------------------------------------"

first = nil
until first.is_a?(TrueClass) || first.is_a?(FalseClass)
	puts "Would you like to go first? (y/n)"
	first = gets.chomp.downcase
	(first.start_with?("y") == true ? first = true : first = false) if (first.include?("y") || first.include?("n"))  


end
	
	
	
	

#creates a board, a player and opponent instance

player = User.new(first)
opponent = Opponent.new(first)
	while Board.game_finished? == false
		Board.display
		user_played = false
		if first == true
			player.play
			user_played = true
		else 
			opponent.play
		end	
		Board.display
		break if Board.game_finished? == true
		if user_played == true
			opponent.play
		else 
			player.play
			user_played = true 
		end



	end
	if user_played == true
		Board.display
		puts "----------------------------------------"
		puts "-      CONGRATULATIONS, YOU WIN!       -"
		puts "----------------------------------------"
	else
		Board.display
		puts "----------------------------------------"
		puts "-           SORRY, YOU LOSE...         -"
		puts "----------------------------------------"
	end

end
