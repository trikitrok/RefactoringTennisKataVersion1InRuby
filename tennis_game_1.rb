class GameVocabulary
  def initialize(vocabulary)
    @vocabulary = vocabulary
  end

  def word_for(key)
    @vocabulary[key]
  end
end

class GameScore
  attr_reader :first_player, :second_player

  def initialize(first_player, second_player)
    @first_player = first_player 
    @second_player = second_player
  end

  def tied?
    first_player.points == second_player.points
  end

  def advantage_for_any_player?
    both_with_forty_or_more? and points_difference() == 1
  end

  def over?
    any_over_forty? and points_difference() >= 2
  end

  def won_point(player_name)
    if player_name == first_player.name
      first_player.won_point
    else
      second_player.won_point
    end
  end

  def current_winner
    first_player.points > second_player.points ? first_player : second_player
  end

  private

  def points_difference
    (first_player.points - second_player.points).abs
  end

  def both_with_forty_or_more?
    first_player.points >= 3 and second_player.points >= 3
  end

  def any_over_forty?
    first_player.points >= 4 or second_player.points >= 4
  end
end

class ScoreDisplayer
  attr_accessor :vocabulary

  def initialize
    @vocabulary = GameVocabulary.new({
        :zero_all => "Love-All",
        :fifteen_all => "Fifteen-All",
        :thirty_all => "Thirty-All",
        :deuce => "Deuce",
        :zero => "Love",
        :fifteen => "Fifteen",
        :thirty => "Thirty",
        :forty => "Forty",
        :advantage => "Advantage",
        :game_over => "Win for"
      })
  end

  def display(game_state)
    if game_state.tied?
      display_tie(game_state.first_player)
    elsif game_state.over?
      display_game_over(game_state.current_winner())
    elsif game_state.advantage_for_any_player?
      display_advantage(game_state.current_winner())
    else 
      display_default(game_state.first_player, game_state.second_player)
    end
  end

  def display_game_over(winner)
    @vocabulary.word_for(:game_over) + " " + winner.name
  end

  def display_advantage(player_with_advantage)
    @vocabulary.word_for(:advantage) + " " + player_with_advantage.name
  end

  def display_tie(any_player)
    key = {
      0 => :zero_all,
      1 => :fifteen_all,
      2 => :thirty_all,
    }.fetch(any_player.points, :deuce)

    @vocabulary.word_for(key)
  end

  def display_default(first_player, second_player)
    key_by_points = {
        0 => :zero,
        1 => :fifteen,
        2 => :thirty,
        3 => :forty,
    }

    @vocabulary.word_for(key_by_points[first_player.points]) + 
      "-" + 
      @vocabulary.word_for(key_by_points[second_player.points])
  end
end

class Player 
  attr_reader :points, :name

  def initialize(name) 
    @name = name
    @points = 0
  end

  def won_point
    @points += 1
  end
end 

class TennisGame
  attr_reader :game_state, :score_displayer

  def initialize(game_state, score_displayer)
    @game_state = game_state 
    @score_displayer = score_displayer
  end

  def won_point(player_name)
    game_state.won_point(player_name)
  end

  def score
    score_displayer.display(game_state)
  end
end
