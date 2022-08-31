# frozen_string_literal: true

class Turn
  attr_accessor :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = Array.new
  end

  def type
    if player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      :basic
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
      player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
      :war
    end
  end

  def winner
    if self.type == :basic
      if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
        player1
      else
        player2
      end
    elsif self.type == :war
      if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
        player1
      else
        player2
      end
    elsif self.type == :mutually_assured_destruction
      'No Winner'
    end
  end

  def pile_cards
    if self.type == :basic
      spoils_of_war << player1.deck.cards.slice!(0)
      spoils_of_war << player2.deck.cards.slice!(0)
    elsif self.type == :war
      spoils_of_war << player1.deck.cards.slice!(0, 3)
      spoils_of_war << player2.deck.cards.slice!(0, 3)
      spoils_of_war.flatten!
    elsif self.type == :mutually_assured_destruction
      player1.deck.cards.slice!(0, 3)
      player2.deck.cards.slice!(0, 3)
    end
  end

  def award_spoils(winner)
    unless winner == 'No Winner'
      @spoils_of_war.each { |x| winner.deck.cards << x }
      @spoils_of_war = []
    end
  end

end
