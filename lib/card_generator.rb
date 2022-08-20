# frozen_string_literal: true

require './lib/card'

# creates cards from text file or generates text file if needed
class CardGenerator
  attr_reader :card_file, :cards, :half_deck_one, :half_deck_two

  SUITS = [:diamond, :heart, :club, :spade].freeze

  VALUE_AND_RANK = {
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
  }.freeze

  def initialize(filename = 'cards.txt')
    @cards = []
    @card_file = filename
    @half_deck_one = []
    @half_deck_two = []
    text_to_card_deck
  end

  def text_to_card_deck
    File.foreach(@card_file) do |line|
      arr = line.split(',').map(&:strip)
      suit = arr[1].to_sym
      value = arr[0].to_s
      rank = arr[2].to_i
      @cards << Card.new(suit, value, rank)
    end
  end

  def shuffle_cards
    @cards.shuffle!
  end

  def deal_cards
    # .select(x.odd?/.even?) would be more efficient, but this is fun
    until @cards.empty? do
      @half_deck_one << @cards.shift
      @half_deck_two << @cards.shift
    end
  end

  # if no text file exists, call this to make one
  def generate_new_card_file
    @text_file = File.new('cards.txt', 'w')
    text_file_builder
    @text_file.close
  end

  # 52-card pickup is not fun, 52-card writeup is even less so
  def text_file_builder
    SUITS.each do |x|
      VALUE_AND_RANK.each do |k, v|
        @text_file.write("#{k}, #{x}, #{v}")
      end
    end
  end
end
