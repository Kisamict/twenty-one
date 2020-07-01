# frozen_string_literal: true

class Player
  attr_reader :name
  attr_accessor :score, :cards

  def initialize(name)
    @name = name
    @cards = []
    @score = 0
  end

  def take_card(deck)
    return if cards.length == 3
    return if self.class == Dealer && take_more? == false

    card = deck.pop
    cards << card
    count_score(card)
    card
  end

  def count_score(card)
    if card.to_i.positive?
      self.score += card.to_i
    elsif card.include?('A')
      score <= 10 ? (self.score += 11) : (self.score += 1)
    else
      self.score += 10
    end
  end

  def refresh_stats
    self.cards = []
    self.score = 0
  end
end
