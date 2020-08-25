require 'rubygems'
require 'bing_translator'

class PagesController < ApplicationController
  def home
  end

  def test

    translator = BingTranslator.new('cc3610100b0b44ad94f7a3dc9832a6c8')

    # Translation

    @spanish = translator.translate('Hello. This will be translated!', :from => 'en', :to => 'es')
    # spanish = translator.translate('Hello. This will be translated!', :to => 'es')

  end
end
