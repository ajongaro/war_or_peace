require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

RSpec.describe Turn do
  it 'exists' do
    turn = Turn.new(:foo, :foobar)
    expect(turn).to be_an_instance_of(Turn)
  end

  it 'takes two players as args' do
    turn = Turn.new(:player1, :player2)
    expect(turn.player1).to eq(:player1)
    expect(turn.player2).to eq(:player2)
  end

  it 'can access spoils_of_war array' do
    turn = Turn.new(:player1, :player2)
    expect(turn.spoils_of_war).to eq([])
  end

  it 'is basic type when different ranks' do
    card1 = Card.new(:diamond, 'Jack', 11)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Queen', 12)
    card4 = Card.new(:club, '3', 3)
    deck1 = Deck.new([card1, card2])
    deck2 = Deck.new([card3, card4])
    player1 = Player.new('Clarisa', deck1)
    player2 = Player.new('Rachel', deck2)
    turn = Turn.new(player1, player2)

    expect(turn.type).to eq(:basic)
  end

  it 'is war type when ranks ranks are same' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Queen', 12)
    card4 = Card.new(:club, '3', 3)
    deck1 = Deck.new([card1, card2])
    deck2 = Deck.new([card3, card4])
    player1 = Player.new('Clarisa', deck1)
    player2 = Player.new('Rachel', deck2)
    turn = Turn.new(player1, player2)

    expect(turn.type).to eq(:war)
  end

  it 'is destruction type when [0] and [2] are same rank' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Queen', 12)
    card4 = Card.new(:club, '3', 3)
    deck1 = Deck.new([card1, nil, card2])
    deck2 = Deck.new([card3, nil, card4])
    player1 = Player.new('Clarisa', deck1)
    player2 = Player.new('Rachel', deck2)
    turn = Turn.new(player1, player2)

    expect(turn.type).to eq(:mutually_assured_destruction)
  end

  it 'is not destruction type if a card[2] is nil' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Queen', 12)
    card4 = Card.new(:club, '3', 3)
    deck1 = Deck.new([card1, card2, card3])
    deck2 = Deck.new([card3, card4]) # [02] is nil here
    player1 = Player.new('Clarisa', deck1)
    player2 = Player.new('Rachel', deck2)
    turn = Turn.new(player1, player2)

    expect(turn.type).to eq(:war)
  end

  it 'determines winner for basic type' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    deck1 = Deck.new([card1])
    deck2 = Deck.new([card2])
    player1 = Player.new('Tony', deck1)
    player2 = Player.new('Lisa', deck2)
    turn = Turn.new(player1, player2)

    expect(turn.winner).to eq(player1)
  end

  it 'determines winner of war type' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '4', 4)
    card3 = Card.new(:heart, 'Queen', 12)
    card4 = Card.new(:club, '3', 3)
    deck1 = Deck.new([card1, nil, card2])
    deck2 = Deck.new([card3, nil, card4])
    player1 = Player.new('Clarisa', deck1)
    player2 = Player.new('Rachel', deck2)
    turn = Turn.new(player1, player2)

    expect(turn.winner).to eq(player1)
  end

  it 'has no winner when mutually assured dest' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Queen', 12)
    card4 = Card.new(:club, '3', 3)
    deck1 = Deck.new([card1, nil, card2])
    deck2 = Deck.new([card3, nil, card4])
    player1 = Player.new('Clarisa', deck1)
    player2 = Player.new('Rachel', deck2)
    turn = Turn.new(player1, player2)

    expect(turn.winner).to eq('No Winner')
  end

  it 'piles cards into spoils of war for basic' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    deck1 = Deck.new([card1])
    deck2 = Deck.new([card2])
    player1 = Player.new('Tony', deck1)
    player2 = Player.new('Lisa', deck2)
    turn = Turn.new(player1, player2)

    turn.pile_cards
    expect(turn.spoils_of_war.include?(card1 && card2)).to be true
  end

  it 'piles cards into spoils for war' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '4', 4)
    card3 = Card.new(:heart, 'Queen', 12)
    card4 = Card.new(:club, '3', 3)
    deck1 = Deck.new([card1, :foo1, card2])
    deck2 = Deck.new([card3, :foo2, card4])
    player1 = Player.new('Clarisa', deck1)
    player2 = Player.new('Rachel', deck2)
    turn = Turn.new(player1, player2)

    turn.pile_cards

    expect(turn.spoils_of_war.include?(card1)).to be true
    expect(turn.spoils_of_war.include?(card2)).to be true
    expect(turn.spoils_of_war.include?(card3)).to be true
    expect(turn.spoils_of_war.include?(card4)).to be true
    expect(turn.spoils_of_war.include?(:foo1)).to be true
    expect(turn.spoils_of_war.include?(:foo2)).to be true
    expect(player1.deck.cards).to eq([])
    expect(player2.deck.cards).to eq([])
  end

  it 'six cards lost when mutually assured destruction' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Queen', 12)
    card4 = Card.new(:club, '3', 3)
    deck1 = Deck.new([card1, nil, card2])
    deck2 = Deck.new([card3, nil, card4])
    player1 = Player.new('Clarisa', deck1)
    player2 = Player.new('Rachel', deck2)
    turn = Turn.new(player1, player2)

    expect(turn.winner).to eq('No Winner')
    turn.pile_cards
    expect(turn.spoils_of_war.include?(card1)).to be false
    expect(turn.spoils_of_war.include?(card2)).to be false
    expect(turn.spoils_of_war.include?(card3)).to be false
    expect(turn.spoils_of_war.include?(card4)).to be false
    expect(turn.spoils_of_war.include?(:foo1)).to be false
    expect(turn.spoils_of_war.include?(:foo2)).to be false
    expect(player1.deck.cards).to eq([])
    expect(player2.deck.cards).to eq([])
  end
end
