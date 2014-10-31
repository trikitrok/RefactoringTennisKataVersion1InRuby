class GameOverDisplayer
  def initialize(player_name)
    @player_name = player_name
  end

  def display
    "Win for " + @player_name
  end
end

class AdvantageDisplayer
  def initialize(player_name)
    @player_name = player_name
  end

  def display
    "Advantage " + @player_name
  end
end

class TieDisplayer
  def initialize(points)
    @points = points
  end

  def display
    {
        0 => "Love-All",
        1 => "Fifteen-All",
        2 => "Thirty-All",
    }.fetch(@points, "Deuce")
  end
end

class DefaultDisplayer
  def initialize(first_player_points, second_player_points)
    @first_player_points = first_player_points
    @second_player_points = second_player_points
  end

  def display
    display_by_points = {
        0 => "Love",
        1 => "Fifteen",
        2 => "Thirty",
        3 => "Forty",
    }
    display_by_points[@first_player_points] + "-" + display_by_points[@second_player_points]
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

class TennisGame1
  def initialize(player1_name, player2_name)
    @first_player = Player.new(player1_name)
    @second_player = Player.new(player2_name)
  end

  def won_point(player_name)
    if player_name == first_player.name
      first_player.won_point
    else
      second_player.won_point
    end
  end

  def score
    score_displayer().display
  end

  private
  attr_reader :first_player, :second_player

  def tied?
    first_player.points == second_player.points
  end

  def current_winner
    first_player.points > second_player.points ? first_player : second_player
  end

  def point_difference_greater_than_two?
    points_difference = first_player.points - second_player.points
    points_difference.abs
  end

  def difference_of_two_points?
    points_difference = first_player.points - second_player.points
    points_difference.abs >= 2
  end

  def game_over?
    any_over_forty_points? and difference_of_two_points?
  end

  def any_over_forty_points?
    not both_under_forty_points?
  end

  def both_under_forty_points?
    first_player.points < 4 and second_player.points < 4 
  end

  def score_displayer
    if tied?
      TieDisplayer.new(first_player.points)
    elsif both_under_forty_points?
      DefaultDisplayer.new(first_player.points, second_player.points)
    elsif game_over?
      GameOverDisplayer.new(current_winner().name)
    else 
      AdvantageDisplayer.new(current_winner().name)
    end
  end
end
