require 'json'
require 'open-uri'
require 'rubygems'
require 'bing_translator'

class WordsController < ApplicationController

  def new
    @word = Word.new
  end

  def create
    translator = BingTranslator.new(ENV['COGNITIVE_SUBSCRIPTION_KEY'])
    @locale = translator.detect(word_params["word"])
    if @locale == :es
      @word = Word.new(word_params)
      @word.translation = translator.translate(@word.word, :from => 'es', :to => 'en').downcase
      @word.user = current_user
    else
      spanish_word = translator.translate(word_params["word"], :from => 'en', :to => 'es').downcase
      @word = Word.new(word: spanish_word)
      @word.translation = word_params["word"]
      @word.user = current_user
    end


    # spanish = translator.translate('Hello. This will be translated!', :to => 'es')

    # url = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20200518T152813Z.29926faa408da3c8.036e59f098ab34250bca659697ae2932edfc642e&lang=es-en&text=#{@word.word}"
    # word_serialized = open(url).read
    # translated_word = JSON.parse(word_serialized)
    # spanish_word = translated_word['text'].first
    # @word.translation = spanish_word

    # took out my photos code here
    if @word.save
      redirect_to word_path(@word)
    else
      render 'new'
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    # no need for app/views/restaurants/destroy.html.erb
    redirect_to words_path
  end

  def index
    @words = Word.where(user: current_user)
  end

  def flashcards
    @word = Word.where(user: current_user).sample
    if @word.nil?
      return
    else
    @photo = @word.image_urls.sample
    end
  end

  def flashcards_second
    @guess = guess_params[:guess]
    word_id = guess_params[:word]
    @word_prompt = Word.find(word_id)
    if current_user.language == 'spanish'
      if @guess == @word_prompt.word
        redirect_to flashcards_words_path
      else
        @wrong = true
        @word = Word.find(word_id)
        @photo = guess_params[:photo]
        render :flashcards
      end
    else
      if @guess == @word_prompt.translation
        redirect_to flashcards_words_path
      else
        @wrong = true
        @word = Word.find(word_id)
        @photo = guess_params[:photo]
        render :flashcards
      end
    end
  end

  def practice
    @all_words = Word.where(user: current_user)
    number_of_words = @all_words.count
    @index2 = params["nextword"].to_i || @index2 = 0

    if @index2 == number_of_words
      @index2 = 0
    end

    @word = @all_words[@index2]


    # unless params["nextword"].nil?
    #   @word = @words[params["nextword"].to_i]
    # else
    #   @word = @words[index]
    #   @index2 = 0
    # end
    if @all_words.empty?
      return
    else
    current_user.language == "spanish" ? @displayed_word = @word.translation : @displayed_word = @word.word
    current_user.language == 'spanish' ? @moving_word = @word.word : @moving_word = @word.translation
    end
    # params["nextword"] != nil ? @index2 +=1 : @index2 = 1


    @photo = @word.image_urls.sample
  end

  def show
    @word = Word.find(params[:id])
    remove_accents = @word.translation

    # tr(
    # "ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
    # "AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")


    image_search_url = "https://api.cognitive.microsoft.com/bing/v7.0/images/search?Subscription-Key=#{ENV['SUBSCRIPTION_KEY']}&q=#{remove_accents}&count=9"
    image_search_url_serialized = open(image_search_url).read
    image_search_url_parsed = JSON.parse(image_search_url_serialized)
    int = 0

    9.times do
      @word.image_urls << image_search_url_parsed['value'][int]['thumbnailUrl']
      int += 1
    end
  end

  def show_second
    @word = Word.find(params[:id])
    urls_string = params[:photo_urls].split(/,/)
    @word.image_urls.replace(urls_string)
    @word.save
    redirect_to words_path
  end

  def settings

  end

  def settingssecond
    current_user.language = params["language"]
    current_user.save
    redirect_to new_word_path
  end

  private

  def word_params
    params.require(:word).permit(:word)
  end

  def guess_params
    params.require(:flashcards).permit(:guess, :word, :photo)
  end

  # def next_word
  #   params.require(:nextword).permit(:index2)
  # end

end
