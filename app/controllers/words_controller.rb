class WordsController < ApplicationController

  def index

  end

  def new
    @word = Word.new
  end

end
