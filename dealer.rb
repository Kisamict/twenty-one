require_relative "player.rb"

class Dealer < Player
  def initialize(name = "Дилер")
    super
  end

  def take_card(card)
    return puts "Дилер пропустил ход" if take_more? == false || super.nil?

    puts "Дилер взял карту"
  end

  def hidden_cards
    puts "Карты дилера: #{ cards.map{ |card| "*" } }"
  end

  private

  def take_more?
    return true if score <= 10

    (10..15).include?(score) && [0,1].sample.zero?
  end
end
