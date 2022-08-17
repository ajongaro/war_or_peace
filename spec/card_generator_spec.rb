require './lib/card_generator'

RSpec.describe CardGenerator do
  describe '#initialize' do
    it 'is an instance of self' do
      card_gen = CardGenerator.new

      expect(card_gen).to be_a CardGenerator
    end

    it 'creates a new text file' do
      card_gen = CardGenerator.new

      expect(card_gen.text_file).to be_a File
    end

    it 'can write to the text file' do
      card_gen = CardGenerator.new

      expect(File.writable?( card_gen.text_file )).to be true
    end

  end
end
