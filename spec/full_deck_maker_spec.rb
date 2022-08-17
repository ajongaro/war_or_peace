# frozen_string_literal: true
require './lib/full_deck_maker'

RSpec.describe FullDeckMaker do
  let(:cards) { FullDeckMaker.new }

  describe '#initialize' do
    it 'exists' do
      expect(cards).to be_an_instance_of(FullDeckMaker)
    end
  end

  describe '#deck_builder' do
    it 'has 52 cards in deck' do
      expect(cards.full_deck.count).to eq(52)
    end

    it 'has all the right cards' do
      @output = ''
      cards.full_deck.each do |x|
        @output = @output + ("[#{x.suit}, #{x.value}, #{x.rank}] ")
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

  describe '#deck_shuffler' do
    it 'shuffles the deck' do
      cards.deck_shuffler
      card_zero = cards.shuffled_deck[0]
      test_card = [card_zero.suit, card_zero.value, card_zero.rank]
      expect(test_card).to_not eq([:diamond, 'ace', 14])
    end
  end

  describe '#deck_splitter' do
    it 'splits the deck evenly' do
      cards.deck_shuffler
      cards.deck_splitter
      expect(cards.first_half_shuffled.count).to eq(26)
      expect(cards.second_half_shuffled.count).to eq(26)
      expect(cards.shuffled_deck).to eq([])
    end
  end
end
