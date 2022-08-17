# frozen_string_literal: true

# generates a text file with full deck of playing cards
class CardGenerator
  attr_reader :text_file, :suits, :value_and_rank

  def initialize
    @text_file = File.new("cards.txt", 'w')
    deck_library
    deck_builder
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
        @text_file.syswrite("#{k}, #{x}, #{v}")
      end
    end
  end
end
