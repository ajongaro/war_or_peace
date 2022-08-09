require 'rspec'
require './lib/deck'
require './lib/card'

RSpec.describe Deck do
  it "exists" do
    deck = Deck.new
    expect(deck).to be_an_instance_of(Deck)
  end

  it "takes an array of cards as arg" do
    deck = Deck.new(["card", "card", "card"])
    expect(deck.cards).to eq(["card","card","card"])
  end

  it "returns rank of specified card" do
    card = Card.new(:heart, "King", 13)
    card_array = [card]
    deck = Deck.new(card_array)
    expect(deck.rank_of_card_at(0)).to eq(13)
  end

end
