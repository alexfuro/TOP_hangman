class Player
  attr_reader :name
  attr_accessor :guesses

  def initialize(name)
    @name = name
    @guesses = []
  end
  def user_guess(guess)
    return if guess.nil?
    guess = guess.downcase
    if guess.length == 1
      if !@guesses.include?(guess)
        @guesses.push(guess)
      end
    end
  end
end
