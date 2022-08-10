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

    # logic for game type (shameless green)
    if p1_card_1 == p2_card_1 # confirms a :war, checks for :destruction
      if p1_card_3 == p2_card_3 && p1_card_3 != nil # checks if match and not nil
        :mutually_assured_destruction
      else
        :war
      end
    else
      :basic
    end

  end


  private
  # ignores cards that don't exist and returns rank of rest
  def card_ranker(player, index)
    if player.deck.cards[index] == nil
      nil
    else
      player.deck.cards[index].rank
    end
  end

end
