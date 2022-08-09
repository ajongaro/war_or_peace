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

  # returns array of card instances ranked above 11
  def high_ranking_cards
    @cards.select { |x| x.rank > 10 }
  end

  # returns percentage of cards ranked above 10 as float
  def percent_high_ranking
    high_card_count = high_ranking_cards.count.to_f
    total_card_count = @cards.count.to_f
    return (high_card_count / total_card_count * 100.00).round(2)
  end

  def remove_card
    @cards.shift
  end

  def add_card(card_to_add)
    @cards << card_to_add
  end


end
