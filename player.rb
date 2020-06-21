class Player
  attr_accessor :cards, :score
  attr_reader :name

  def initialize(name)
    @name = name
    @cards = []
    @score = 0
  end

  def take_card(deck)
    card = deck.pop
    @cards << card
    count_score(card)
    card
  end

  def count_score(card)
    if card.to_i > 0
      @score += card.to_i
    elsif card.include?("A")
      @score <= 10 ? (@score += 11) : (@score += 1)
    else
      @score += 10
    end
  end

  def refresh_stats
    self.cards = []
    self.score = 0
  end

  def show_cards
    if self.name == "Дилер"
      "Карты дилера: #{self.cards}"
    else
      "Ваши карты: #{self.cards}"
    end
  end

  def show_score
    if self.name == "Дилер"
      "Очки дилера: #{self.score}"
    else
      "Ваши очки: #{self.score}"
    end
  end
end
