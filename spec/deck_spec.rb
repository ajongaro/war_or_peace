# frozen_string_literal: true

require './lib/deck'
require './lib/card'

RSpec.describe Deck do
  it 'exists' do
    deck = Deck.new
    expect(deck).to be_an_instance_of(Deck)
  end

  it 'takes an array of cards as arg' do
    deck = Deck.new(['card', 'card', 'card'])
    expect(deck.cards).to eq(['card', 'card', 'card'])
  end

  it 'returns rank of specified card' do
    card = Card.new(:heart, 'King', 13)
    card_array = [card]
    deck = Deck.new(card_array)
    expect(deck.rank_of_card_at(0)).to eq(13)
  end

  it 'returns array of cards ranked 11 or higher' do
    card = Card.new(:spade, '3', 3)
    card2 = Card.new(:diamond, 'King', 13)
    card3 = Card.new(:heart, 'Jack', 11)
    card4 = Card.new(:club, '10', 10)
    deck = Deck.new([card, card2, card3, card4])

    expect(deck.high_ranking_cards).to eq([card2, card3])
  end

  it 'returns percent of deck that is high ranking' do
    card = Card.new(:spade, '3', 3)
    card2 = Card.new(:diamond, 'King', 13)
    card3 = Card.new(:heart, 'Jack', 11)
    card4 = Card.new(:club, '10', 10)
    deck = Deck.new([card, card2, card3, card4])

    expect(deck.percent_high_ranking).to eq(50.00)
  end

  it 'removes top card from the deck' do
    card = Card.new(:spade, '3', 3)
    card2 = Card.new(:diamond, 'King', 13)
    card3 = Card.new(:heart, 'Jack', 11)
    deck = Deck.new([card, card2, card3])

    deck.remove_card
    expect(deck.cards).to eq([card2, card3])
  end

  it 'adds a card to end of array' do
    card = Card.new(:spade, '3', 3)
    card2 = Card.new(:diamond, 'King', 13)
    card3 = Card.new(:heart, 'Jack', 11)
    deck = Deck.new([card, card2])

    deck.add_card(card3)
    expect(deck.cards).to eq([card, card2, card3])
  end
end
