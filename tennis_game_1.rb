class TennisGame1

  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1points = 0
    @p2points = 0
    @state = :initial
  end

  def won_point(player_name)
    if player_name == @player1_name
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    update_game_state

    display_score @state
  end

  def tied?
    @p1points==@p2points
  end 

  def over_thirty?
    @p1points > 2
  end

  def tied_over_thirty?
    tied? and over_thirty?
  end 

  def update_game_state
    if tied?
      @state = :tied
    elsif (@p1points>=4 or @p2points>=4)
      minusResult = @p1points-@p2points
      if (minusResult==1)
        @state = :advantage1
      elsif (minusResult ==-1)
        @state = :advantage2
      elsif (minusResult>=2)
        @state = :game_over1
      else
        @state = :game_over2
      end
    else
      @state = :default
    end
  end

  def display_score (state)
    def advantage_for (player_name)
      "Advantage " + player_name
    end

    def win_for (player_name)
      "Win for " + (@p1points > @p2points ? @player1_name : @player2_name)
    end

    displayers_by_state = {
      :advantage1 => Proc.new { advantage_for(@player1_name)},
      :advantage2 => Proc.new { advantage_for(@player2_name) },
      :game_over1 => Proc.new { win_for(@player1_name) },
      :game_over2 => Proc.new { win_for(@player2_name) },
      :tied =>  Proc.new { 
        {
            0 => "Love-All",
            1 => "Fifteen-All",
            2 => "Thirty-All",
        }.fetch(@p1points, "Deuce")
      },
      :default => Proc.new {
        display_by_points = {
            0 => "Love",
            1 => "Fifteen",
            2 => "Thirty",
            3 => "Forty",
        }
        display_by_points[@p1points] + "-" + display_by_points[@p2points]
      }
    }

    displayers_by_state[state].call()
  end
end
