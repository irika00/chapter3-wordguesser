class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses, :curr, :word_with_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
  end

  def guess(letter)
    if letter.nil? || !letter.is_a?(String) || !letter.match?(/\A[a-zA-Z]\z/)
      raise ArgumentError
    end
    letter = letter.downcase
    if @word.include?(letter) == false
      if @wrong_guesses == nil
        @wrong_guessesguesses += letter
      elsif @wrong_guesses.include?(letter) == false
        @wrong_guesses += letter
      else
        return false
      end
      
    elsif @word.include?(letter) == true 
      if @guesses == nil
        @guesses += letter
      elsif @guesses.include?(letter) == false
        @guesses += letter
      else
        return false
      end
    end
    true
  end

  def word_with_guesses
    result = ''
    @word.each_char do |letter|
      if @guesses.include?(letter)
        result += letter
      else
        result += '-'
      end
    end
    result
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif !word_with_guesses.include?('-')
      :win
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://esaas-randomword-27a759b6224d.herokuapp.com/RandomWord') 
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http| 
      return http.post(uri, "").body
    end
  end
end

