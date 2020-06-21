require_relative "requireable.rb"

class Game
  def initialize
    @player = create_user
    @dealer = create_dealer
    @deck = create_deck
  end

  def call
    puts greet_user
    loop do
      puts "Игра началась!"
      deal_cards
      puts @player.show_cards, @player.show_score
      puts @dealer.hidden_cards
      moves
      break if exit?
    end
  end

  private

  attr_accessor :move, :game_over

  def create_user
    print "Имя игрока: "
    User.new(gets.chomp.strip)
  end

  def greet_user
    "Приветствую, #{@player.name}"
  end

  def create_dealer
    Dealer.new
  end

  def create_deck
    Deck.new.cards
  end

  def deal_cards
    2.times { @player.take_card(@deck); @dealer.take_card(@deck) }
  end

  def exit?
    puts "1. Сыграть еще раз", "2. Выйти"
    input = gets.chomp.strip
    input == "2" ? (true) : (refresh_stats; false)
  end

  def moves
    @turn = [@player, @dealer].sample
    until game_over
      @turn == @player ? user_move : dealer_move
      break end_game if @player.cards.length == 3 && @dealer.cards.length == 3
    end
  end

  def user_move
    puts "Ваш ход"
    puts user_interface
    user_options
  end

  def user_interface
    [
      "1. Взять еще одну карту",
      "2. Пропустить ход",
      "3. Открыть карты"
    ]
  end

  def dealer_move
    puts "Ход Дилера!"
    case @dealer.moves_logic
    when "Взять карту"
      return (@turn = @player; puts "Дилер пропустил ход") if @dealer.cards.length == 3
      @dealer.take_card(@deck)
      puts "Дилер взял карту"
    when "Пропустить ход"
      puts "Дилер пропустил ход"
    end
    puts @dealer.hidden_cards
    @turn = @player
  end

  def user_options
    case gets.chomp.strip
    when "1"
      return puts "Вы не можете взять больше трех карт" if @player.cards.length == 3
      puts "Вы взяли карту #{@player.take_card(@deck)}"
      puts @player.show_score
    when "2"
      puts "Вы пропустили ход"
    when "3"
      end_game
    end
    @turn = @dealer
  end

  def end_game
    puts @player.show_cards, @player.show_score
    puts "---"*10
    puts @dealer.show_cards, @dealer.show_score

    self.game_over = true

    return puts "НИЧЬЯ!" if draw?
    return puts "ПОБЕДА!" if win?
    return puts "ПОРАЖЕНИЕ.." if lose?
  end

  def draw?
    true if ((@player.score == @dealer.score) || (@player.score == 21 && @dealer.score == 21)) || (@dealer.score > 21 && @player.score > 21)
  end

  def win?
    true if ((@player.score > @dealer.score) && (@player.score <= 21)) || (@dealer.score > 21) && (@player.score <= 21)
  end

  def lose?
    true if ((@player.score < @dealer.score) && (@dealer.score <= 21)) || (@player.score > 21) && (@dealer.score <= 21)
  end

  def refresh_stats
    @deck = create_deck
    @dealer.refresh_stats
    @player.refresh_stats
    self.game_over = false
  end
end

Game.new.call
