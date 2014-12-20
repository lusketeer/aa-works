require "spec_helper"
require "card.rb"

describe Card do
  subject(:card) { Card.new(:spades, :ace) }

  it "has suit, value string, and value" do
    expect(card.suit).to       eq(:spades)
    expect(card.value).to      eq(:ace)
    expect(card.poker_value).to eq(14)
  end

  describe "#render" do
    it "renders the art of the card" do
      expect(card.render).to eq("[A - ♠]")
    end
  end




end
