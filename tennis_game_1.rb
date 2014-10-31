class GameOverDisplayer
  def initialize(player_name, vocabulary)
    @player_name = player_name
    @vocabulary = vocabulary
  end

  def display
    @vocabulary.word_for(:game_over) + " " + @player_name
  end
end

class AdvantageDisplayer
  def initialize(player_name, vocabulary)
    @player_name = player_name
    @vocabulary = vocabulary
  end

  def display
    @vocabulary.word_for(:advantage) + " " + @player_name
  end
end

class TieDisplayer
  def initialize(points, vocabulary)
    @points = points
    @vocabulary = vocabulary
  end

  def display
    key = {
      0 => :zero_all,
      1 => :fifteen_all,
      2 => :thirty_all,
    }.fetch(@points, :deuce)

    @vocabulary.word_for(key)
  end
end

class DefaultDisplayer
  def initialize(first_player_points, second_player_points, vocabulary)
    @first_player_points = first_player_points
    @second_player_points = second_player_points
    @vocabulary = vocabulary
  end

  def display
    key_by_points = {
        0 => :zero,
        1 => :fifteen,
        2 => :thirty,
        3 => :forty,
    }

    @vocabulary.word_for(key_by_points[@first_player_points]) + 
      "-" + 
      @vocabulary.word_for(key_by_points[@second_player_points])
  end
end

class GameVocabulary
  def initialize(vocabulary)
    @vocabulary = vocabulary
  end

  def word_for(key)
    @vocabulary[key]
  end
end

class ScoreDisplayer
   class << self  
    def in_english(first_player, second_player)
      english_vocabulary = {
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
      }

      new(first_player, second_player, GameVocabulary.new(english_vocabulary))  
    end  
  end

  def initialize(first_player, second_player, vocabulary)
    @first_player = first_player 
    @second_player = second_player
    @vocabulary = vocabulary
  end

  def display
    displayer().display
  end

  private
  attr_reader :vocabulary, :first_player, :second_player 

  def displayer
    if tied?
      TieDisplayer.new(first_player.points, vocabulary)
    elsif both_under_forty_points?
      DefaultDisplayer.new(first_player.points, second_player.points, vocabulary)
    elsif game_over?
      GameOverDisplayer.new(current_winner().name, vocabulary)
    else 
      AdvantageDisplayer.new(current_winner().name, vocabulary)
    end
  end

  def tied?
    first_player.points == second_player.points
  end

  def difference_of_two_or_more_points?
    points_difference = first_player.points - second_player.points
    points_difference.abs >= 2
  end

  def game_over?
    any_over_forty_points? and difference_of_two_or_more_points?
  end

  def any_over_forty_points?
    not both_under_forty_points?
  end

  def both_under_forty_points?
    first_player.points < 4 and second_player.points < 4 
  end

  def current_winner
    first_player.points > second_player.points ? first_player : second_player
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
  attr_reader :first_player, :second_player, :score_displayer

  def initialize(first_player, second_player, score_displayer)
    @first_player = first_player 
    @second_player = second_player
    @score_displayer = score_displayer
  end

  def won_point(player_name)
    if player_name == first_player.name
      first_player.won_point
    else
      second_player.won_point
    end
  end

  def score
    score_displayer.display
  end
end
