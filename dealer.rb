# frozen_string_literal: true

require_relative 'player.rb'

class Dealer < Player
  def initialize(name = 'Дилер')
    super
  end

  def show_cards
    puts "Карты дилера: #{cards}"
    puts "Очки дилера: #{score}"
  end

  def hidden_cards
    puts "Карты дилера: #{cards.map { '*' }}"
  end

  def take_more?
    return true if score <= 10 || cards.length < 2

    (10..15).include?(score) && [0, 1].sample.zero?
  end
end
