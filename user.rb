require_relative "player.rb"
class User < Player
  def show_cards
    puts "Ваши карты: #{cards}"
    puts "Ваши очки: #{score}"
  end
end
