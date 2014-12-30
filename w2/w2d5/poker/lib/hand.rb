class Hand

  attr_accessor :cards_in_hand, :cards_by_suit, :cards_by_value

  def initialize(cards)
    @cards_in_hand = cards
    find_cards_by_suit
    find_cards_by_value
  end

  def to_s
    return_str = ""
    @cards_in_hand.sort_by do |card|
      card.poker_value
    end.each do |card|
      return_str += card.to_s + " "
    end
    return_str.chomp
  end


  def has_triple?
    @cards_by_value.any? { |value, suits| suits.length == 3 }
  end

  def has_four_of_a_kind?
    @cards_by_value.any? { |value, suits| suits.length == 4 }
  end

  def is_straight?
    return false unless self.cards_by_value.size == 5
    sorted_keys = cards_by_value.keys.sort
    sorted_keys.first + 4 == sorted_keys.last
  end

  def is_flush?
    self.cards_by_suit.size == 1
  end

  def is_straight_flush?
    is_flush? && is_straight?
  end

  def is_royal_flush?
    is_straight_flush? && @cards_by_value.keys.include?(14)
  end

  def is_full_house?
    has_triple? && has_single_pair?
  end

  def has_two_pairs?
    cards_by_value.any? { |value, suits| suits.length == 2 } && self.cards_by_value.length == 3
  end

  def has_single_pair?
    @cards_by_value.any? { |value, suits| suits.length == 2 } && self.cards_by_value.length != 4
  end

  def find_highest_card_value
    @cards_by_value.keys.sort.last
  end

  def beat?(other_hand)
    if (!self.is_flush? && !other_hand.is_flush?) && (!self.is_straight? && !other_hand.is_straight?)
      case self.cards_by_value.size <=> other_hand.cards_by_value.size
      when -1
        return 1
      when 1
        return -1
      else
        my_self = self.cards_by_value.sort_by {|key, value| value.length}.reverse.first[0]
        other_player = other_hand.cards_by_value.sort_by {|key, value| value.length}.reverse.first[0]
        return my_self <=> other_player
      end
    end

    methods_arr = [:is_royal_flush?, :is_straight_flush?, :is_full_house?, :is_flush?,
      :has_four_of_a_kind?, :is_straight?, :has_triple?, :has_two_pairs?, :has_single_pair?]

    methods_arr.each do |method|
      if self.send(method) && !other_hand.send(method)
        return 1
      elsif !self.send(method) && other_hand.send(method)
        return -1
      elsif self.send(method) && other_hand.send(method)
        my_self = self.cards_by_value.sort_by {|key, value| value.length}.reverse.first[0]
        other_player = other_hand.cards_by_value.sort_by {|key, value| value.length}.reverse.first[0]
        return my_self <=> other_player
      end
    end

    self.find_highest_card_value <=> other_hand.find_highest_card_value
  end



  private

    def find_cards_by_suit
      @cards_by_suit = Hash.new { |h, k| h[k] = [] }
      @cards_in_hand.each do |card|
        cards_by_suit[card.suit] << card.poker_value
      end
    end

    def find_cards_by_value
      @cards_by_value = Hash.new { |h, k| h[k] = [] }
      @cards_in_hand.each do |card|
        cards_by_value[card.poker_value] << card.suit
      end
    end
end
