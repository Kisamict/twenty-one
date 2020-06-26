class Deck
  CARDS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  SUITS = ["\u{2660}", "\u{2663}", "\u{2665}", "\u{2666}"]

  attr_reader :cards

  def initialize
    @cards = build_deck
  end

  private

  def build_deck
    CARDS.collect do |card|
      SUITS.map { |suit| card + suit }
    end.flatten.shuffle
  end
end
