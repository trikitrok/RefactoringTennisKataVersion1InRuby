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

    display_score
  end

  def tied?
    @p1points==@p2points
  end 

  def tied_over_thirty?
    tied? and @p1points > 2
  end 

  def update_game_state
    if tied_over_thirty?
      @state = :deuce
    elsif (@p1points>=4 or @p2points>=4)
      minusResult = @p1points-@p2points
      if (minusResult==1)
        @state = :advantage
      elsif (minusResult ==-1)
        @state = :advantage
      elsif (minusResult>=2)
        @state = :game_over
      else
        @state = :game_over
      end
    else
      @state = :initial
    end
  end

  def display_score
    if @state == :deuce
      "Deuce"
    elsif @state == :advantage
      "Advantage " + (@p1points > @p2points ? @player1_name : @player2_name)
    elsif @state == :game_over
      "Win for " + (@p1points > @p2points ? @player1_name : @player2_name)
    else
      def score_before_deuce
        if tied?
          {
              0 => "Love-All",
              1 => "Fifteen-All",
              2 => "Thirty-All",
          }.fetch(@p1points)
        else
          display_by_points = {
              0 => "Love",
              1 => "Fifteen",
              2 => "Thirty",
              3 => "Forty",
          }

          display_by_points[@p1points] + "-" + display_by_points[@p2points]
        end
      end
      score_before_deuce
    end
  end
end
