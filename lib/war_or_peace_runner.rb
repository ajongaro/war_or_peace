# frozen_string_literal: true

require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/card_generator'

# starts the game engine
class Starter
  attr_reader :player1, :player2
  attr_accessor :games_played

  def initialize
    @game_deck = CardGenerator.new('cards.txt')
    @game_deck.shuffle_cards
    @game_deck.deal_cards
    @deck1 = Deck.new(@game_deck.half_deck_one)
    @deck2 = Deck.new(@game_deck.half_deck_two)
    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)
    @games_played = 0
  end

  def pile_and_award
    @one_turn.pile_cards
    @one_turn.award_spoils(@one_turn.winner)
    deck_tracker
  end

  def deck_tracker
    puts "#{@player1.name}: #{@player1.deck.cards.count},"\
    " #{@player2.name}: #{@player2.deck.cards.count}"
  end

  def basic_turn
    puts "Turn #{@games_played}: #{@one_turn.winner.name} won 2 cards. "
    pile_and_award
  end

  def war_turn
    puts "Turn #{@games_played}: WAR - #{@one_turn.winner.name} won 6 cards."
    pile_and_award
  end

  def mad_turn
    puts "Turn #{@games_played}: *mutually assured destruction*"\
    ' 6 cards removed from play.'
    pile_and_award
  end

  def start
    until @games_played == 1_000_000
      @games_played += 1
      @one_turn = Turn.new(@player1, @player2)
      game = @one_turn.type

      case game
      when :basic then basic_turn
      when :war then war_turn
      when :mutually_assured_destruction then mad_turn
      end

      break if anyone_lost
    end
    p '---- DRAW ----' if @games_played == 1_000_000
  end

  def anyone_lost
    if @player1.has_lost?
      p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
      true
    elsif @player2.has_lost?
      p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
      true
    end
  end
end

# PROGRAM START
line = '*' * 67
puts ''
puts line
puts '  _       __                            ____'
puts ' | |     / /___  _____   ____  _____   / __ \\___  ____  ________ '
puts ' | | /| / / __ `/ ___/  / __ \\/ ___/  / /_/ / _ \\/ __ `/ ___/ _ \\'
puts ' | |/ |/ / /_/ / /     / /_/ / /     / ____/  __/ /_/ / /__/  __/'
puts ' |__/|__/\\__,_/_/      \\____/_/     /_/    \\___/\\__,_/\\___/\\___/'
puts ''
puts line
puts ''
puts 'Welcome to War! (or Peace) This game will be played with 52 cards.'
puts 'The players today are Megan and Aurora.'
puts "Type 'GO' to start the game!"
puts '------------------------------------------------------------------'
input = gets.chomp.upcase

if input == 'GO'
  lets_go = Starter.new
  lets_go.start
end
