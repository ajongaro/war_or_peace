# frozen_string_literal: true

# a player of the game
class Player
  attr_reader :name, :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def has_lost?
    return true if @deck.cards == []

    false
  end
end
