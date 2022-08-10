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
    p1_card_1 = card_ranker(@player1, 0)
    p1_card_3 = card_ranker(@player1, 2)
    p2_card_1 = card_ranker(@player2, 0)
    p2_card_3 = card_ranker(@player2, 2)

    # immediate eject to basic if first cards don't match
    return :basic if p1_card_1 != p2_card_1
    # if they are the same, and [2] is also, and neither is nil
    return :mutually_assured_destruction if match_not_nil(p1_card_3, p2_card_3)
    # if you've made it this far, then this means...
    return :war
  end


  private
  # for type method; ignores cards that don't exist and returns rank of rest
  def card_ranker(player, index)
    card_to_check = player.deck.cards[index]
    return nil if card_to_check == nil
    card_to_check.rank
  end
  # for type method; determines if destruction will occur
  def match_not_nil(p1_card, p2_card)
    return false if p1_card.nil? || p2_card.nil?
    p1_card == p2_card # true if match, false if no match
  end


end
