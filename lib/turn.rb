class Turn

  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    player1_card_rank = @player1.deck.cards[0].rank
    player2_card_rank = @player2.deck.cards[0].rank
    return :basic if player1_card_rank != player2_card_rank
    
  end
end
