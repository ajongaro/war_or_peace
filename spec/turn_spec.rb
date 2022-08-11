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

  let(:card_rank_12) { Card.new(:diamond, 'Queen', 12) }
  let(:card_rank_3) { Card.new(:spade, '3', 3) }
  let(:card_rank_4) { Card.new(:spade, '4', 4)}

  describe '#type' do

    it 'is basic type when different ranks' do
      deck1 = Deck.new([card_rank_4, card_rank_3])
      deck2 = Deck.new([card_rank_12, card_rank_3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:basic)
    end

    it 'is war type when ranks ranks are same' do
      deck1 = Deck.new([card_rank_12, card_rank_3])
      deck2 = Deck.new([card_rank_12, card_rank_3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:war)
    end

    it 'is destruction type when [0] and [2] are same rank' do
      deck1 = Deck.new([card_rank_12, nil, card_rank_3])
      deck2 = Deck.new([card_rank_12, nil, card_rank_3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:mutually_assured_destruction)
    end

    it 'is not destruction type if a card[2] is nil' do
      deck1 = Deck.new([card_rank_12, card_rank_3, card_rank_4])
      deck2 = Deck.new([card_rank_12, card_rank_3]) # [02] is nil here
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:war)
    end
  end

  describe '#winner' do

    it 'determines winner for basic type' do
      deck1 = Deck.new([card_rank_12])
      deck2 = Deck.new([card_rank_3])
      player1 = Player.new('Tony', deck1)
      player2 = Player.new('Lisa', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq(player1)
    end

    it 'determines winner of war type' do
      deck1 = Deck.new([card_rank_12, nil, card_rank_4])
      deck2 = Deck.new([card_rank_12, nil, card_rank_3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq(player1)
    end

    it 'has no winner when mutually assured dest' do
      deck1 = Deck.new([card_rank_12, nil, card_rank_3])
      deck2 = Deck.new([card_rank_12, nil, card_rank_3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq('No Winner')
    end
  end

  describe '#piles_cards' do
    it 'piles cards into spoils of war for basic' do
      deck1 = Deck.new([card_rank_12])
      deck2 = Deck.new([card_rank_3])
      player1 = Player.new('Tony', deck1)
      player2 = Player.new('Lisa', deck2)
      turn = Turn.new(player1, player2)

      turn.pile_cards
      expect(turn.spoils_of_war.include?(card_rank_12 && card_rank_3)).to be true
    end

    it 'piles cards into spoils for war' do
      deck1 = Deck.new([card_rank_12, :foo1, card_rank_4])
      deck2 = Deck.new([card_rank_12, :foo2, card_rank_3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      turn.pile_cards

      expect(turn.spoils_of_war.size).to eq(6)

      expect(player1.deck.cards).to eq([])
      expect(player2.deck.cards).to eq([])
    end

    it 'six cards lost when mutually assured destruction' do
      deck1 = Deck.new([card_rank_12, nil, card_rank_3])
      deck2 = Deck.new([card_rank_12, nil, card_rank_3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq('No Winner')

      turn.pile_cards
      expect(turn.spoils_of_war).to eq([])

      expect(player1.deck.cards).to eq([])
      expect(player2.deck.cards).to eq([])
    end
  end
end
