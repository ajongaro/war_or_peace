class Turn

  attr_reader :player1, :player2, :spoils_of_war
  # initializes a turn with two players
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  # determines which type of turn will occur
  def type
    p1_c1_rank = ranker(@player1, 0) # should these be class variables?
    p1_c3_rank = ranker(@player1, 2) # probably b/c they're repeated below
    p2_c1_rank = ranker(@player2, 0)
    p2_c3_rank = ranker(@player2, 2)

    return :basic if p1_c1_rank != p2_c1_rank
    # if they are the same, and [2] is also, and neither is nil
    return :mutually_assured_destruction if matched_not_nil(p1_c3_rank, p2_c3_rank)
    # if you've made it this far, then this means...
    return :war
  end

  def winner
    first_card = 0
    third_card = 2
    return who_wins(first_card) if type == :basic
    return who_wins(third_card) if type == :war
    'No Winner' # M.A.D.
  end

  def pile_cards
    if type == :basic
      pile_and_flatten(1)
    elsif type == :war
      pile_and_flatten(3)
    else
      @player1.deck.cards.slice!(0..2)
      @player2.deck.cards.slice!(0..2)
    end
  end

  private
  def pile_and_flatten(how_many)
    @spoils_of_war << @player1.deck.cards.slice!(0, how_many)
    @spoils_of_war << @player2.deck.cards.slice!(0, how_many)
    @spoils_of_war.flatten!
  end

  # for type & winner method; ignores cards that don't exist and returns rank of rest
  def ranker(player, index)
    card_to_check = player.deck.cards[index]
    return nil if card_to_check == nil
    card_to_check.rank
  end
  # for type method; determines if destruction will occur
  def matched_not_nil(p1_card, p2_card)
    p1_card == p2_card && p1_card.nil? == false
  end
  # for winner method; takes index position and returns winning player
  def who_wins(card)
    if ranker(@player1, card) > ranker(@player2, card)
      @player1
    else
      @player2
    end
  end

end
