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
    if deuce?
      "Deuce"
    elsif tied?
      {
          0 => "Love-All",
          1 => "Fifteen-All",
          2 => "Thirty-All",
      }.fetch(@p1points)
    elsif (@p1points>=4 or @p2points>=4)
      minusResult = @p1points-@p2points
      if (minusResult==1)
        "Advantage " + @player1_name
      elsif (minusResult ==-1)
        "Advantage " + @player2_name
      elsif (minusResult>=2)
        "Win for " + @player1_name
      else
        "Win for " + @player2_name
      end
    else
      scoreBeforeDeuce
    end
  end

  def tied?
    @p1points==@p2points
  end 

  def deuce?
    tied? and @p1points > 2
  end 

  def scoreBeforeDeuce
    result = ""
    tempScore=0
    (1...3).each do |i|
      if (i==1)
        tempScore = @p1points
      else
        result+="-"
        tempScore = @p2points
      end
      result += {
          0 => "Love",
          1 => "Fifteen",
          2 => "Thirty",
          3 => "Forty",
      }[tempScore]
    end
    result
  end
end
