require './lib/card'

# create a 52 card deck
class FullDeckMaker

  attr_reader :full_deck, :output

  def initialize
    @full_deck = []
    @first_deck = []
    @second_deck = []

    deck_builder
  end

  def deck_builder
    @suits = [:diamond, :heart, :club, :spade]
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
    # make the whole deck
    @suits.each do |x|
      @value_and_rank.each do |k,v|
        @full_deck << Card.new(x, k, v)
      end
    end

  end
end # FullDeckMaker Class End


# PROGRAM START



# print check (make test for this)
deck = FullDeckMaker.new.full_deck
@output = ""
deck.each do |x|
  @output.concat("[#{x.suit}, #{x.value}, #{x.rank}] ")
end
# how many cards
print @output







# randomize and split


# create two players

# start game method
