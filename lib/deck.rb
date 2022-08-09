class Deck

  attr_reader :cards

  # initializes deck with array of cards, empty by default
  def initialize(cards=[])
    @cards = cards
  end

  # returns rank of card at indicated position
  def rank_of_card_at(index)
    @cards[index].rank
  end













end
