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

  

end
