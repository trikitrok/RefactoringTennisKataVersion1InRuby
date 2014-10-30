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

class TennisGame1

  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1points = 0
    @p2points = 0
  end

  def won_point(player_name)
    if player_name == @player1_name
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    score_displayer().display
  end

  def tied?
    @p1points==@p2points
  end

  def current_winner_name
    (@p1points > @p2points ? @player1_name : @player2_name)
  end

  def game_over?
    points_difference = @p1points-@p2points
    points_difference.abs >= 2
  end

  def score_displayer
    if tied?
      TieDisplayer.new(@p1points)
    elsif (@p1points>=4 or @p2points>=4)
      if game_over?
        GameOverDisplayer.new(current_winner_name)
      else 
        AdvantageDisplayer.new(current_winner_name)
      end
    else
      DefaultDisplayer.new(@p1points, @p2points)
    end
  end
end
