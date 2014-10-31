require File.join(File.dirname(__FILE__), "tennis_game_1")
require 'test/unit'

TEST_CASES = [
   [0, 0, "Love-All", 'player1', 'player2'],
   [1, 1, "Fifteen-All", 'player1', 'player2'],
   [2, 2, "Thirty-All", 'player1', 'player2'],
   [3, 3, "Deuce", 'player1', 'player2'],
   [4, 4, "Deuce", 'player1', 'player2'],
   
   [1, 0, "Fifteen-Love", 'player1', 'player2'],
   [0, 1, "Love-Fifteen", 'player1', 'player2'],
   [2, 0, "Thirty-Love", 'player1', 'player2'],
   [0, 2, "Love-Thirty", 'player1', 'player2'],
   [3, 0, "Forty-Love", 'player1', 'player2'],
   [0, 3, "Love-Forty", 'player1', 'player2'],
   [4, 0, "Win for player1", 'player1', 'player2'],
   [0, 4, "Win for player2", 'player1', 'player2'],
   
   [2, 1, "Thirty-Fifteen", 'player1', 'player2'],
   [1, 2, "Fifteen-Thirty", 'player1', 'player2'],
   [3, 1, "Forty-Fifteen", 'player1', 'player2'],
   [1, 3, "Fifteen-Forty", 'player1', 'player2'],
   [4, 1, "Win for player1", 'player1', 'player2'],
   [1, 4, "Win for player2", 'player1', 'player2'],
   
   [3, 2, "Forty-Thirty", 'player1', 'player2'],
   [2, 3, "Thirty-Forty", 'player1', 'player2'],
   [4, 2, "Win for player1", 'player1', 'player2'],
   [2, 4, "Win for player2", 'player1', 'player2'],
   
   [4, 3, "Advantage player1", 'player1', 'player2'],
   [3, 4, "Advantage player2", 'player1', 'player2'],
   [5, 4, "Advantage player1", 'player1', 'player2'],
   [4, 5, "Advantage player2", 'player1', 'player2'],
   [15, 14, "Advantage player1", 'player1', 'player2'],
   [14, 15, "Advantage player2", 'player1', 'player2'],
   
   [6, 4, 'Win for player1', 'player1', 'player2'], 
   [4, 6, 'Win for player2', 'player1', 'player2'], 
   [16, 14, 'Win for player1', 'player1', 'player2'], 
   [14, 16, 'Win for player2', 'player1', 'player2'], 

   [6, 4, 'Win for One', 'One', 'player2'],
   [4, 6, 'Win for Two', 'player1', 'Two'], 
   [6, 5, 'Advantage One', 'One', 'player2'],
   [5, 6, 'Advantage Two', 'player1', 'Two'] 
]

TEST_CASES_SPANISH = [
   [0, 0, "Cero iguales", 'jugador 1', 'jugador 2'],
   [1, 1, "Quince iguales", 'jugador 1', 'jugador 2'],
   [2, 2, "Treinta iguales", 'jugador 1', 'jugador 2'],
   [3, 3, "Deuce", 'jugador 1', 'jugador 2'],
   [4, 4, "Deuce", 'jugador 1', 'jugador 2'],
   
   [1, 0, "Quince-Cero", 'jugador 1', 'jugador 2'],
   [0, 1, "Cero-Quince", 'jugador 1', 'jugador 2'],
   [2, 0, "Treinta-Cero", 'jugador 1', 'jugador 2'],
   [0, 2, "Cero-Treinta", 'jugador 1', 'jugador 2'],
   [3, 0, "Cuarenta-Cero", 'jugador 1', 'jugador 2'],
   [0, 3, "Cero-Cuarenta", 'jugador 1', 'jugador 2'],
   [4, 0, "Juego para el jugador 1", 'jugador 1', 'jugador 2'],
   [0, 4, "Juego para el jugador 2", 'jugador 1', 'jugador 2'],
   
   [2, 1, "Treinta-Quince", 'jugador 1', 'jugador 2'],
   [1, 2, "Quince-Treinta", 'jugador 1', 'jugador 2'],
   [3, 1, "Cuarenta-Quince", 'jugador 1', 'jugador 2'],
   [1, 3, "Quince-Cuarenta", 'jugador 1', 'jugador 2'],
   [4, 1, "Juego para el jugador 1", 'jugador 1', 'jugador 2'],
   [1, 4, "Juego para el jugador 2", 'jugador 1', 'jugador 2'],
   
   [3, 2, "Cuarenta-Treinta", 'jugador 1', 'jugador 2'],
   [2, 3, "Treinta-Cuarenta", 'jugador 1', 'jugador 2'],
   [4, 2, "Juego para el jugador 1", 'jugador 1', 'jugador 2'],
   [2, 4, "Juego para el jugador 2", 'jugador 1', 'jugador 2'],
   
   [4, 3, "Ventaja para el jugador 1", 'jugador 1', 'jugador 2'],
   [3, 4, "Ventaja para el jugador 2", 'jugador 1', 'jugador 2'],
   [5, 4, "Ventaja para el jugador 1", 'jugador 1', 'jugador 2'],
   [4, 5, "Ventaja para el jugador 2", 'jugador 1', 'jugador 2'],
   [15, 14, "Ventaja para el jugador 1", 'jugador 1', 'jugador 2'],
   [14, 15, "Ventaja para el jugador 2", 'jugador 1', 'jugador 2'],
   
   [6, 4, 'Juego para el jugador 1', 'jugador 1', 'jugador 2'], 
   [4, 6, 'Juego para el jugador 2', 'jugador 1', 'jugador 2'], 
   [16, 14, 'Juego para el jugador 1', 'jugador 1', 'jugador 2'], 
   [14, 16, 'Juego para el jugador 2', 'jugador 1', 'jugador 2'], 

   [6, 4, 'Juego para el Uno', 'Uno', 'jugador 2'],
   [4, 6, 'Juego para el Dos', 'jugador 1', 'Dos'], 
   [6, 5, 'Ventaja para el Uno', 'Uno', 'jugador 2'],
   [5, 6, 'Ventaja para el Dos', 'jugador 1', 'Dos'] 
]

class TestTennis < Test::Unit::TestCase
  def test_scoring
    TEST_CASES.each do |p1_points, p2_points, score, p1_name, p2_name|
      game = display_game_in_english(p1_points, p2_points, p1_name, p2_name)
      assert_equal(score, game.score)
    end
  end

  def test_scoring_in_spanish
    TEST_CASES_SPANISH.each do |p1_points, p2_points, score, p1_name, p2_name|
      game = display_game_in_spanish(p1_points, p2_points, p1_name, p2_name)
      assert_equal(score, game.score)
    end
  end

  def display_game_in_english(p1_points, p2_points, p1_name, p2_name)
    first_player = Player.new(p1_name)
    second_player = Player.new(p2_name)
    score_displayer = ScoreDisplayer.new(first_player, second_player)
    
    play_game(p1_points, p2_points, p1_name, p2_name, TennisGame.new(first_player, second_player, score_displayer))
  end

  def display_game_in_spanish(p1_points, p2_points, p1_name, p2_name)
    spanish_game_vocabulary = {
      :zero_all => "Cero iguales",
      :fifteen_all => "Quince iguales",
      :thirty_all => "Treinta iguales",
      :deuce => "Deuce",
      :zero => "Cero",
      :fifteen => "Quince",
      :thirty => "Treinta",
      :forty => "Cuarenta",
      :advantage => "Ventaja para el",
      :game_over => "Juego para el"
    }
    first_player = Player.new(p1_name)
    second_player = Player.new(p2_name)
    score_displayer = ScoreDisplayer.new(first_player, second_player)
    score_displayer.vocabulary = GameVocabulary.new(spanish_game_vocabulary)
    
    play_game(p1_points, p2_points, p1_name, p2_name, TennisGame.new(first_player, second_player, score_displayer))
  end

  def play_game(p1_points, p2_points, p1_name, p2_name, game)
    (0..[p1_points, p2_points].max).each do |i|
      if i < p1_points
        game.won_point(p1_name)
      end
      if i < p2_points
        game.won_point(p2_name)
      end
    end
    game
  end
end
