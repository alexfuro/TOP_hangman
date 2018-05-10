require './player.rb'
require 'sinatra'

class Hangman
  attr_accessor :misses
  attr_reader :player, :board, :secret_word
  def initialize(player)
    @player = player
    @secret_word = get_secret()
    @board = Array.new(@secret_word.length, "_")
    @misses = 0
  end

  def get_secret()
    word_dump = File.readlines("words.txt")
    secret_words = word_dump.select do |word|
      word.length < 13 && word.length > 4
    end
    @secret_word = secret_words[rand(secret_words.length)].strip.downcase
  end

  def play()

  end

  def display()
    @board.each do |letter|
     print letter
    end
    puts
  end

  def check_matches()
    match = false
    @secret_word.split("").each_with_index do |letter, index|
      if @player.guesses[-1] == letter
        @board[index] = letter
        match = true
      end
    end
    match
  end

  def gameover()
    if @misses >= 7 || !@board.include?("_")
      return true
    else
      return false
    end
  end
end

#sinatra code
enable :sessions
get '/' do
  player_name = params["name"]
  player = Player.new(player_name)
  game = Hangman.new(player)
  session[:name] = player_name
  session[:game] = game
  if !player_name.nil?
    redirect '/play'
  end

  erb :index
end

get '/play' do
  erb :play
end
