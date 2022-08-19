# frozen_string_literal: true

require './lib/card'

# generates a text file with full deck of playing cards
class CardGenerator
  attr_reader :text_file, :cards

  def initialize(filename = 'cards.txt')
    @cards = []
    @card_file = filename
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

  # if no text file exists, call this
  def generate_new_card_file
    @text_file = File.new('cards.txt', 'w')
    deck_library
    text_file_builder
    @text_file.close
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

  def text_file_builder
    # 52-card pickup is not fun, 52-card writeup is less so
    @suits.each do |x|
      @value_and_rank.each do |k, v|
        @text_file.write("#{k}, #{x}, #{v}\n")
      end
    end
  end
end
