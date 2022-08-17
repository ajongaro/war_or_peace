# frozen_string_literal: true

require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

# create a 52 card deck
class FullDeckMaker
  attr_reader :full_deck,
              :shuffled_deck,
              :output,
              :first_half_shuffled,
              :second_half_shuffled

  def initialize
    @full_deck = []
    @shuffled_deck = []
    @first_half_shuffled = []
    @second_half_shuffled = []

    build_shuffle_split
  end

  def build_shuffle_split
    deck_library
    deck_builder
    deck_shuffler
    deck_splitter
  end

  def deck_library
    @suits = [:diamond,
              :heart,
              :club,
              :spade]

    @value_and_rank = {
      'ace' => 14,
      '2' => 2,
      '3' => 3,
      '4' => 4,
      '5' => 5,
      '6' => 6,
      '7' => 7,
      '8' => 8,
      '9' => 9,
      '10' => 10,
      'Jack' => 11,
      'Queen' => 12,
      'King' => 13
    }
  end

  def deck_builder
    # iterates through each suit and each value/rank hash to make the deck
    @suits.each do |x|
      @value_and_rank.each do |k, v|
        @full_deck << Card.new(x, k, v)
      end
    end
  end

  # randomizes the deck
  def deck_shuffler
    @shuffled_deck = @full_deck.shuffle
  end

  # splits deck into two decks
  def deck_splitter
    @first_half_shuffled = @shuffled_deck.slice!(0, 26)
    @second_half_shuffled = @shuffled_deck.slice!(0, 26)
  end
end
