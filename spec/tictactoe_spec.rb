require "spec_helper"

describe "Board" do

	before :each do
		@board = Board.new 
		Board.clear
	end

	describe "#new" do
		it "creates a new Board object" do
			@board.should be_an_instance_of Board
		end
	end
	describe "#display" do
		context "empty board" do
			it "displays an empty board" do 
			STDOUT.expect(:puts).with("   1  2  3")
			STDOUT.expect(:print).with("A")
			STDOUT.expect(:puts).with("   |   |  ")
			STDOUT.expect(:puts).with("  --+---+--")
			STDOUT.expect(:print).with("B")
			STDOUT.expect(:puts).with("   |   |  ")
			STDOUT.expect(:puts).with("  --+---+--")
			STDOUT.expect(:print).with("C")
			STDOUT.expect(:puts).with("   |   |  ")
			end
		end
		context "pieces placed on board" do
			it "displays a full board" do
			Board.place "A",1,"X"
			Board.place "C",1,"O"
			Board.place "B",2,"X"
			STDOUT.expect(:puts).with("   1  2  3")
			STDOUT.expect(:print).with("A")
			STDOUT.expect(:puts).with("  X|   |  ")
			STDOUT.expect(:puts).with("  --+---+--")
			STDOUT.expect(:print).with("B")
			STDOUT.expect(:puts).with("   | O |  ")
			STDOUT.expect(:puts).with("  --+---+--")
			STDOUT.expect(:print).with("C")
			STDOUT.expect(:puts).with("  X|   |  ")
			Board.clear
			end
		end 
	end
	describe "#check" do
		it "checks the board" do
			Board.check("A",1).should == true
			Board.place "A",1,"X"
			Board.check("A",1).should == false
			Board.clear
		end
	end
	describe "#clear" do
		it "clears the board" do
			Board.place "A",1,"X"
			Board.place "B",3,"0" 
			Board.clear
			STDOUT.expect(:puts).with("   1  2  3")
			STDOUT.expect(:print).with("A")
			STDOUT.expect(:puts).with("   |   |  ")
			STDOUT.expect(:puts).with("  --+---+--")
			STDOUT.expect(:print).with("B")
			STDOUT.expect(:puts).with("   |   |  ")
			STDOUT.expect(:puts).with("  --+---+--")
			STDOUT.expect(:print).with("C")
			STDOUT.expect(:puts).with("   |   |  ")
		end
	end
	describe "#game_finished?" do

		context "horizontal winning combination" do
			it "sees if there is a horizontal winning combination" do
				Board.place "A",1,"X"
				Board.place "A",2,"X"
				Board.place "A",3,"X"
				Board.game_finished?.should == true
			end
		end
		context "vertical winning combination" do
			it "sees if there is a vertical winning combination" do
				Board.place "A",1,"X"
				Board.place "B",1,"X"
				Board.place "C",1,"X"
				Board.game_finished?.should == true
			end
		end
		context "diagonal winning combination" do
			it "sees if there is a diagonal winning combination" do
				Board.place "A",1,"X"
				Board.place "B",2,"X"
				Board.place "C",3,"X"
				Board.game_finished?.should == true
			end
		end
		context "no winning combination" do
			it "returns false if there is no winning combination" do
				Board.game_finished?.should == false
			end
		end
	end

end
describe "Player" do

	before :each do 
		@player = Player.new
	end

	describe "#new" do
		it "creates a new Player object" do
			@player.should be_an_instance_of Player
		end 
		it "increments the number of players" do
		 	Player.number_of_players.should > 0
		end
	end
end
describe "User" do

	before :each do
		@user = User.new true 
	end

	describe "#new" do

		context "first player" do
			it "sets X to the player's symbol" do
				@user.symbol.should == "X"
			end
		end
		context "second player" do
			it "sets X to the player's symbol" do
				user2 = User.new false
				user2.symbol.should == "O" 
			end
		end

	end

end