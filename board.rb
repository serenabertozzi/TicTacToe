require "rainbow"
require_relative "player"

class Board
  def initialize
    @state = (0..8).map { :empty }
  end

  def setup
    puts "Welcome! Who is player #1?"
    @p1 = Player.new(:p1, gets.chomp)
    puts Rainbow("#{@p1} you play as 'x'!").cyan
    puts ""
    puts "Welcome! Who is player #2?"
    @p2 = Player.new(:p2, gets.chomp)
    puts Rainbow("#{@p2} you play as 'o'!").red
    puts ""
  end

  def cell(i)
    case @state[i]
    when :empty then i
    when :p1 then Rainbow("x").cyan
    when :p2 then Rainbow("o").red
    end
  end

  def to_s
    puts ""
    puts " #{cell(0)} | #{cell(1)} | #{cell(2)} "
    puts "---|---|---"
    puts " #{cell(3)} | #{cell(4)} | #{cell(5)} "
    puts "---|---|---"
    puts " #{cell(6)} | #{cell(7)} | #{cell(8)} "
    puts ""
  end

  def ask_move(player_id)
    player = player_id == :p1 ? @p1 : @p2

    loop do
      puts "Insert your move #{player} (0 - 8):"
      move = gets.chomp.to_i

      if @state[move] == :empty
        @state[move] = player_id
        break
      elsif @state[move].nil?
        puts Rainbow("Which board are you playing on?").orange
      else
        puts Rainbow("Sorry! This tile is already set!").orange
      end
    end
  end

  def winner
    return @p1 if is_winner?(:p1)
    return @p2 if is_winner?(:p2)
    nil
  end

  def tie?
    winner.nil? && @state.all? { |cell| cell != :empty }
  end

  private

  def is_winner?(player)
    (0..2).each do |i|
      start = i * 3
      
      if @state[start] == player && @state[start + 1] == player && @state[start + 2] == player
        return true
      end
    end

    (0..2).each do |i|
      start = i

      if @state[start] == player && @state[start + 3] == player && @state[start + 6] == player
        return true
      end
    end

    if @state[0] == player && @state[4] == player && @state[8] == player
      return true
    end

    if @state[2] == player && @state[4] == player && @state[6] == player
      return true
    end
    false
  end
end
