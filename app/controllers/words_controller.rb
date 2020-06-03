class WordsController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    @word.user = current_user
    url = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20200518T152813Z.29926faa408da3c8.036e59f098ab34250bca659697ae2932edfc642e&lang=es-en&text=#{@word.word}"
    word_serialized = open(url).read
    translated_word = JSON.parse(word_serialized)
    spanish_word = translated_word['text'].first
    @word.translation = spanish_word

    # took out my photos code here
    if @word.save
      redirect_to word_path(@word)
    else
      render 'new'
    end
  end

  def index
    @words = Word.all
  end

  def flashcards
    @word = Word.all.sample
  end

  def flashcards_second
    @guess = guess_params[:guess]
    word_id = guess_params[:word]
    @word_prompt = Word.find(word_id)
    if @guess == @word_prompt.word
      redirect_to flashcards_words_path
    else
      @answer = true
      @word = Word.find(word_id)
      render :flashcards
    end
  end

  def show
    @word = Word.find(params[:id])

    image_search_url = "https://api.cognitive.microsoft.com/bing/v7.0/images/search?Subscription-Key=895bd91126ba4364997596d10078196f&q=#{@word.word}&count=9"
    image_search_url_serialized = open(image_search_url).read
    image_search_url_parsed = JSON.parse(image_search_url_serialized)
    int = 0

    9.times do
      @word.image_urls << image_search_url_parsed['value'][int]['thumbnailUrl']
      int += 1
    end

  end

  private

  def word_params
    params.require(:word).permit(:word)
  end

  def guess_params
    params.require(:flashcards).permit(:guess, :word)
  end
end





