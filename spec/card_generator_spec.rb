# frozen_string_literal: false

require './lib/card_generator'

RSpec.describe CardGenerator do
  let(:card_gen) { CardGenerator.new('cards.txt') }

  describe '#initialize' do
    it 'is an instance of self' do
      expect(card_gen).to be_a CardGenerator
    end

    it 'creates a new text file' do
      expect(card_gen.card_file).to eq('cards.txt')
    end

    it 'fills cards with a deck' do
      expect(card_gen.cards.count).to eq(52)
    end
  end

  describe '#text_file_builder' do
    it 'has all the right cards' do
      @output = ''
      card_gen.cards.each do |x|
        @output += "[#{x.suit}, #{x.value}, #{x.rank}] "
      end

      expect(@output).to eq('[diamond, ace, 14] [diamond, 2, 2]'\
        ' [diamond, 3, 3] [diamond, 4, 4]'\
        ' [diamond, 5, 5] [diamond, 6, 6] [diamond, 7, 7] [diamond, 8, 8]'\
        ' [diamond, 9, 9] [diamond, 10, 10] [diamond, Jack, 11]'\
        ' [diamond, Queen, 12] [diamond, King, 13]'\
        ' [heart, ace, 14] [heart, 2, 2] [heart, 3, 3] [heart, 4, 4]'\
        ' [heart, 5, 5] [heart, 6, 6] [heart, 7, 7] [heart, 8, 8]'\
        ' [heart, 9, 9] [heart, 10, 10] [heart, Jack, 11] [heart, Queen, 12]'\
        ' [heart, King, 13]'\
        ' [club, ace, 14] [club, 2, 2] [club, 3, 3] [club, 4, 4] [club, 5, 5]'\
        ' [club, 6, 6] [club, 7, 7] [club, 8, 8] [club, 9, 9] [club, 10, 10]'\
        ' [club, Jack, 11] [club, Queen, 12] [club, King, 13]'\
        ' [spade, ace, 14] [spade, 2, 2] [spade, 3, 3] [spade, 4, 4]'\
        ' [spade, 5, 5] [spade, 6, 6] [spade, 7, 7] [spade, 8, 8]'\
        ' [spade, 9, 9] [spade, 10, 10] [spade, Jack, 11] [spade, Queen, 12]'\
        ' [spade, King, 13] ')
    end
  end

  describe '#shuffle_cards' do
    it 'shuffles the deck' do
      card_gen.shuffle_cards
      card_zero = card_gen.cards[0]
      test_card = [card_zero.suit, card_zero.value, card_zero.rank]

      expect(test_card).to_not eq([:diamond, 'ace', 14])
    end
  end

  describe '#deal_cards' do
    it 'deals the cards one by one' do
      card_gen.shuffle_cards
      card_gen.deal_cards

      expect(card_gen.cards).to eq([])
      expect(card_gen.half_deck_one.count).to eq(26)
      expect(card_gen.half_deck_two.count).to eq(26)
      expect(card_gen.half_deck_one).to_not eq(card_gen.half_deck_two)
    end
  end
end
