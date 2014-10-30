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
    display_score game_state
  end

  def tied?
    @p1points==@p2points
  end 

  def game_state
    if tied?
      :tied
    elsif (@p1points>=4 or @p2points>=4)
      minusResult = @p1points-@p2points
      if (minusResult==1)
        :advantage1
      elsif (minusResult ==-1)
        :advantage2
      elsif (minusResult>=2)
        :game_over1
      else
        :game_over2
      end
    else
      :default
    end
  end

  def display_score (state)
    displayers_by_state = {
      :advantage1 => AdvantageDisplayer.new(@player1_name),
      :advantage2 => AdvantageDisplayer.new(@player2_name),
      :game_over1 => GameOverDisplayer.new(@player1_name),
      :game_over2 => GameOverDisplayer.new(@player2_name),
      :tied =>  TieDisplayer.new(@p1points),
      :default => DefaultDisplayer.new(@p1points, @p2points)
    }

    displayers_by_state[state].display()
  end
end
