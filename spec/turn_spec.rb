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

end
