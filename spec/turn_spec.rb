# frozen_string_literal: true

require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

RSpec.describe Turn do
  let(:card_rank12) { Card.new(:diamond, 'Queen', 12) }
  let(:card_rank3) { Card.new(:spade, '3', 3) }
  let(:card_rank4) { Card.new(:spade, '4', 4) }
  let(:deck1) { Deck.new([card_rank12, card_rank4, card_rank3]) }
  let(:deck2) { Deck.new([card_rank12, card_rank4, card_rank4]) }
  let(:deck3) { Deck.new([card_rank4, card_rank12]) }
  let(:deck4) { Deck.new([card_rank12]) }
  let(:player1) { Player.new('Clarisa', deck1) }

  it 'exists' do
    player2 = Player.new('Tom', deck2)
    turn = Turn.new(player1, player2)
    expect(turn).to be_an_instance_of(Turn)
  end

  it 'takes two players as args' do
    player2 = Player.new('Tom', deck2)
    turn = Turn.new(player1, player2)
    expect(turn.player1).to eq(player1)
    expect(turn.player2).to eq(player2)
  end

  it 'can access spoils_of_war array' do
    player2 = Player.new('Tom', deck2)
    turn = Turn.new(player1, player2)
    expect(turn.spoils_of_war).to eq([])
  end

  describe '#type' do
    it 'is basic type when different ranks' do
      player2 = Player.new('Rachel', deck3)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:basic)
    end

    it 'is war type when ranks ranks are same' do
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:war)
    end

    it 'is destruction type when [0] and [2] are same rank' do
      player2 = Player.new('Rachel', deck1)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:mutually_assured_destruction)
    end

    it 'is not destruction type if a card[2] is nil' do
      player2 = Player.new('Rachel', deck4)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:war)
    end
  end

  describe '#winner' do
    it 'determines winner for basic type' do
      player2 = Player.new('Lisa', deck3)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq(player1)
    end

    it 'determines winner of war type' do
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq(player2)
    end

    it 'has no winner when mutually assured dest' do
      player2 = Player.new('Rachel', deck1)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq('No Winner')
    end
  end

  describe '#pile_cards' do
    it 'piles cards into spoils of war for basic' do
      deck1 = Deck.new([card_rank12])
      deck2 = Deck.new([card_rank3])
      player1 = Player.new('Tony', deck1)
      player2 = Player.new('Lisa', deck2)
      turn = Turn.new(player1, player2)

      turn.pile_cards
      expect(turn.spoils_of_war.include?(card_rank12 && card_rank3)).to be true
    end

    it 'piles cards into spoils for war' do
      deck1 = Deck.new([card_rank12, card_rank3, card_rank4])
      deck2 = Deck.new([card_rank12, card_rank4, card_rank3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      turn.pile_cards

      expect(turn.spoils_of_war.size).to eq(6)

      expect(player1.deck.cards).to eq([])
      expect(player2.deck.cards).to eq([])
    end

    it 'six cards lost when mutually assured destruction' do
      deck1 = Deck.new([card_rank12, nil, card_rank3])
      deck2 = Deck.new([card_rank12, nil, card_rank3])
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

  describe '#award_spoils' do
    it 'awards spoils pile to winning player of war' do
      deck1 = Deck.new([card_rank12, card_rank3, card_rank4])
      deck2 = Deck.new([card_rank12, card_rank4, card_rank3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq(player1)
      winner = turn.winner
      turn.pile_cards
      # require "pry"; binding.pry
      turn.award_spoils(winner)

      expect(turn.spoils_of_war).to eq([])
      expect(player2.deck.cards.count).to eq(0)
      expect(player1.deck.cards.count).to eq(6)
    end

    it 'awards spoils pile to winning player of basic' do
      deck1 = Deck.new([card_rank12, card_rank3, card_rank4])
      deck2 = Deck.new([card_rank3, card_rank4, card_rank3])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq(player1)
      winner = turn.winner
      turn.pile_cards
      # require "pry"; binding.pry
      turn.award_spoils(winner)

      expect(turn.spoils_of_war).to eq([])
      expect(player2.deck.cards.count).to eq(2)
      expect(player1.deck.cards.count).to eq(4)
    end

    it "doesn't award anything during destruction" do
      deck1 = Deck.new([card_rank12, card_rank3, card_rank4])
      deck2 = Deck.new([card_rank12, card_rank4, card_rank4])
      player1 = Player.new('Clarisa', deck1)
      player2 = Player.new('Rachel', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.winner).to eq('No Winner')
      winner = turn.winner
      turn.pile_cards
      turn.award_spoils(winner)

      expect(turn.spoils_of_war).to eq([])
      expect(player2.deck.cards.count).to eq(0)
      expect(player1.deck.cards.count).to eq(0)
    end
  end
end
