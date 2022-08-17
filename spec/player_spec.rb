# frozen_string_literal: true
require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'

RSpec.describe Player do
  it 'exists' do
    player = Player.new('Anthony', :FIXME)
    expect(player).to be_an_instance_of(Player)
  end

  it 'is initialized with a deck and name' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])
    player = Player.new('Clarisa', deck)

    expect(player.name).to eq('Clarisa')
    expect(player.deck.cards).to eq([card1, card2, card3])
  end

  it 'recognizes when they have lost' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])
    player = Player.new('Clarisa', deck)

    expect(player.has_lost?).to be false

    player.deck.remove_card
    expect(player.has_lost?).to be false

    2.times { player.deck.remove_card }
    expect(player.has_lost?).to be true
  end
  

end
