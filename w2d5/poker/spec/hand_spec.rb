require 'rspec'
require 'hand'

describe Hand do
  let(:card1) { double("card", suit: :spades, value: :queen, poker_value: 12) }
  let(:card2) { double("card", suit: :hearts, value: :nine, poker_value: 9) }
  let(:card3) { double("card", suit: :diamonds, value: :five, poker_value: 5) }
  let(:card4) { double("card", suit: :hearts, value: :ten, poker_value: 10) }
  let(:card5) { double("card", suit: :clubs, value: :ace, poker_value: 14) }
  subject(:hand) { Hand.new([card1, card2, card3, card4, card5]) }

  describe '#initialize' do
    it 'receives 5 cards and stores them' do
      expect(hand.cards_in_hand.count).to eq(5)
    end

  end
end
