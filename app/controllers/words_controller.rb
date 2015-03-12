class WordsController < ApplicationController

  def index

  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.create(word_params)

    respond
    if @word.save
      render 'new', flash: "word created"
    else

    end
  end


  def word_params
    params.require(:word).permit(:type, :text, :article, :pronoun)
  end

end
