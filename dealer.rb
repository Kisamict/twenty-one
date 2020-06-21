require_relative "player.rb"

class Dealer < Player
  def initialize(name = "Дилер")
    super
  end

  def moves_logic
    return "Взять карту" if self.score <= 10
    if self.score > 10 && self.score < 15
      take_more? ? (return "Пропустить ход") : (return "Взять карту")
    else
      return "Пропустить ход"
    end
  end

  def hidden_cards
    "Карты дилера: #{self.cards.map{|card| "*"}}"
  end

  private

  def take_more?
    rand(1..5) > 3 ? true : false
  end
end
