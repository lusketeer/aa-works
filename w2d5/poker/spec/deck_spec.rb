require 'deck'

describe Deck do

  subject(:deck) { Deck.new }

  describe "#initialize" do

    it "creates a deck of 52 cards" do
      expect(deck.cards.count).to eq(52)
    end

    it "creates a deck with no repeated cards" do
      rendered_deck = deck.cards.map { |card| card.render }
      expect(rendered_deck.uniq.size).to eq(52)
    end

  end

  describe "#take" do

    it "permanently removes n cards from deck" do
      expect(deck.take(3).size).to eq(3)
      expect(deck.cards.size).to eq(49)
    end

  end
end
