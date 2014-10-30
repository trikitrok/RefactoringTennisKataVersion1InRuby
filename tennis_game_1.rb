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
  attr_accessor :points, :name

  def initialize(name) 
    @name = name
    @points = 0
  end

end 

class TennisGame1

  attr_reader :first_player, :second_player

  def initialize(player1_name, player2_name)
    @first_player = Player.new(player1_name)
    @second_player = Player.new(player2_name)
  end

  def won_point(player_name)
    if player_name == first_player.name
      first_player.points += 1
    else
      second_player.points += 1
    end
  end

  def score
    score_displayer().display
  end

  def tied?
    first_player.points == second_player.points
  end

  def current_winner
    first_player.points > second_player.points ? first_player : second_player
  end

  def game_over?
    points_difference = first_player.points - second_player.points
    points_difference.abs >= 2
  end

  def both_under_forty_points?
    first_player.points < 4 and second_player.points < 4 
  end

  def score_displayer
    if tied?
      TieDisplayer.new(first_player.points)
    elsif both_under_forty_points?
      DefaultDisplayer.new(first_player.points, second_player.points)
    else
      if game_over?
        GameOverDisplayer.new(current_winner().name)
      else 
        AdvantageDisplayer.new(current_winner().name)
      end
    end
  end
end
