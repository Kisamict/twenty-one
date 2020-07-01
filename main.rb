# frozen_string_literal: true

require_relative 'requireable.rb'

class Game
  def initialize
    @user = create_user
    @dealer = create_dealer
    @deck = create_deck
  end

  def call
    game_interface
  end

  private

  attr_accessor :game_over, :user, :dealer, :deck, :turn
  attr_writer :game_result

  def game_interface
    puts greet_user

    loop do
      puts 'Игра началась!'
      deal_cards
      user.show_cards
      dealer.hidden_cards
      move
      break if exit?

      refresh_stats
    end
  end

  def create_user
    print 'Имя игрока: '
    User.new(gets.chomp.strip)
  end

  def greet_user
    "Приветствую, #{user.name}!"
  end

  def create_dealer
    Dealer.new
  end

  def create_deck
    Deck.new
  end

  def deal_cards
    2.times do
      user.take_card(deck.cards)
      dealer.take_card(deck.cards)
    end
  end

  def exit?
    puts "1. Сыграть еще раз \n"\
         '2. Выйти'

    gets.chomp.to_i == 2
  end

  def move
    self.turn = [user, dealer].sample

    until game_over
      turn == user ? user_move : dealer_move

      break end_game if cards_max?
    end
  end

  def cards_max?
    user.cards.length == 3 && dealer.cards.length == 3
  end

  def user_interface
    [
      '1. Взять еще одну карту',
      '2. Пропустить ход',
      '3. Открыть карты'
    ]
  end

  def user_move
    puts 'Ваш ход'
    puts user_interface
    user_actions

    self.turn = dealer
  end

  def dealer_move
    puts 'Ход дилера'

    if dealer.take_card(deck.cards)
      puts 'Дилер взял карту'
    else
      puts 'Дилер пропустил ход'
    end

    dealer.hidden_cards

    self.turn = user
  end

  def user_actions
    case gets.chomp.strip
    when '1'
      return puts 'Вы не можете взять больше трех карт' unless user.take_card(deck.cards)

      puts 'Вы взяли карту'

      user.show_cards
    when '2'
      puts 'Вы пропустили ход'
    when '3'
      end_game
    end
  end

  def end_game
    user.show_cards
    puts '-----------'
    dealer.show_cards
    puts game_result

    self.game_over = true
  end

  def game_result
    self.game_result = if win?
                         'ПОБЕДА!'
                       elsif lose?
                         'ПОРАЖЕНИЕ!'
                       else
                         'НИЧЬЯ!'
                       end

    @game_result
  end

  def win?
    (
      (user.score > dealer.score) && (user.score <= 21) ||
      (dealer.score > 21) && (user.score <= 21)
    )
  end

  def lose?
    (
      (user.score < dealer.score) && (dealer.score <= 21) ||
      (user.score > 21) && (dealer.score <= 21)
    )
  end

  def refresh_stats
    self.deck = create_deck
    dealer.refresh_stats
    user.refresh_stats
    self.game_over = false
  end
end

Game.new.call
