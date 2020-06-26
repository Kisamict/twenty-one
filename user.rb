require_relative "player.rb"
class User < Player
  def take_card(deck)
    return puts "Вы не можете взять больше трех карт" if super.nil?
    puts "Вы взяли карту #{ cards.last }"
  end
end
