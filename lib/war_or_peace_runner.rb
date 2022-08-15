require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/full_deck_maker'

class Starter

  attr_reader :player1, :player2
  attr_accessor :games_played

  def initialize
    @game_ready_deck = FullDeckMaker.new
    @deck1 = Deck.new(@game_ready_deck.first_half_shuffled)
    @deck2 = Deck.new(@game_ready_deck.second_half_shuffled)
    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)
    @games_played = 0
  end

  def pile_and_award
    @one_turn.pile_cards
    @one_turn.award_spoils(@one_turn.winner)
    deck_counter
  end

  def deck_counter
    p "#{@player1.name}: #{@player1.deck.cards.count},"\
    " #{@player2.name}: #{@player2.deck.cards.count}"
  end

  def basic_turn(games_played)
    p "Turn #{games_played}: #{@one_turn.winner.name} won 2 cards."
    pile_and_award
  end

  def war_turn(games_played)
    p "Turn #{games_played}: WAR - #{@one_turn.winner.name} won 6 cards."
    pile_and_award
  end

  def mad_turn(games_played)
    p "Turn #{games_played}: *mutually assured destruction*"\
    " 6 cards removed from play."
    pile_and_award
  end

  def start
    until @games_played == 1_000_000
      @games_played += 1
      @one_turn = Turn.new(@player1, @player2)

      basic_turn(@games_played) if @one_turn.type == :basic
      war_turn(@games_played) if @one_turn.type == :war
      mad_turn(@games_played) if @one_turn.type == :mutually_assured_destruction

      if @player1.has_lost?
        p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
        break
      elsif @player2.has_lost?
        p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
        break
      end

    end
    p "---- DRAW ----" if @games_played == 1_000_000
  end
end


# PROGRAM START
puts "Welcome to War! (or Peace) This game will be played with 52 cards."
puts "The players today are Megan and Aurora."
puts "Type 'GO' to start the game!"
puts "------------------------------------------------------------------"
input = gets.chomp

if input == 'GO'
  lets_go = Starter.new
  lets_go.start
end
