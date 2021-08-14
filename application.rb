require "rainbow"
require_relative "rainbow_title"
require_relative "board"

class Application #Classe principale che contiene il nostro programma, perchè è brutto avere le cose nello scope globale.
  def initialize
    @board = Board.new
  end

  def run
    puts RainbowTitle.new("Tic Tac Toe!")
    @board.setup
    puts @board.to_s
    player = :p1

    loop do
      @board.ask_move(player)
      puts @board.to_s
      player = player == :p1 ? :p2 : :p1
      winner = @board.winner

      if winner
        puts "#{winner} wins!"
        break
      end

      if @board.tie?
        puts "It's a tie!"
        break
      end
    end
  end
end
