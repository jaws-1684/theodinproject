require_relative '../lib/player.rb'

describe Player do

  let(:player1) { Player.new('adam', 'red') }

  context "checking player name and color" do
    it "player1 name should be adam" do
      expect(player1.name).to eq 'adam'
    end
    it "player1 color should be red" do
      expect(player1.color).to eq 'red'
    end
  end
end