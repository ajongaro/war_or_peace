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
    @p1_c1 = card_ranker(@player1, 0)
    @p1_c3 = card_ranker(@player1, 2)
    @p2_c1 = card_ranker(@player2, 0)
    @p2_c3 = card_ranker(@player2, 2)
    return :basic if @p1_c1 != @p2_c1
    return :mutually_assured_destruction if matched_not_nil
    return :war
  end

  # determines if 3rd card is matched && not a nil value
  def matched_not_nil
    @p1_c3 == @p2_c3 && @p1_c3.nil? == false
  end

  # returns the winner of specified match based on type
  def winner
    first_card = 0
    third_card = 2
    return which_card_wins(first_card) if type == :basic
    return which_card_wins(third_card) if type == :war
    'No Winner' # M.A.D.
  end

  # returns which player has the winning card each round
  def which_card_wins(card)
    return @player2 if card_ranker(@player1, card) == nil
    return @player1 if card_ranker(@player2, card) == nil
    return @player1 if card_ranker(@player1, card) > card_ranker(@player2, card)
    @player2
  end

  # pulls rank of card or returns nil if no card exists
  def card_ranker(player, index)
    players_card_to_check = player.deck.cards[index]
    return nil if players_card_to_check == nil
    players_card_to_check.rank
  end

  # piles active cards into spoils of war or destroys them
  def pile_cards
    return pile_and_flatten(1) if type == :basic
    return pile_and_flatten(3) if type == :war
    remove_cards(@player1, 3)
    remove_cards(@player2, 3)
  end

  # access, delete, and return specified number of cards
  def remove_cards(player, how_many)
    player.deck.cards.slice!(0, how_many)
  end

  # adds specified cards to spoils of war and flattens
  def pile_and_flatten(how_many)
    @spoils_of_war << remove_cards(@player1, how_many)
    @spoils_of_war << remove_cards(@player2, how_many)
    @spoils_of_war.flatten!
  end

  # shovels spoils of war into winner's deck and flattens it
  def award_spoils(winner)
    unless winner == 'No Winner' || winner == nil
      winners_deck = winner.deck.cards
      winners_deck << @spoils_of_war.shift(@spoils_of_war.size)
      winners_deck.flatten!
    end
  end

end
