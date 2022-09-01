# frozen_string_literal: true

class Turn
  attr_accessor :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @players = [@player1, @player2]
    @spoils_of_war = []
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
    case type
    when :basic then winning_player_for(0)
    when :war then winning_player_for(2)
    when :mutually_assured_destruction then 'No Winner'
    end
  end

  def winning_player_for(num)
    return player1 if player2.deck.rank_of_card_at(num).nil?
    return player2 if player1.deck.rank_of_card_at(num).nil?
    
    result = player1.deck.rank_of_card_at(num) > player2.deck.rank_of_card_at(num)
    result ? player1 : player2
  end

  def pile_cards
    type == :basic ? process_cards(1) : process_cards(3)
  end

  def process_cards(num)
    if type != :mutually_assured_destruction
      @players.each { |x| @spoils_of_war << x.deck.cards.slice!(0, num) }
      @spoils_of_war.flatten!
    else
      @players.each { |x| x.deck.cards.slice!(0, num) }
    end
  end

  def award_spoils(winner)
    return if winner == 'No Winner'
    spoils_of_war.each { |x| winner.deck.cards << x }
    @spoils_of_war.clear
  end
end
