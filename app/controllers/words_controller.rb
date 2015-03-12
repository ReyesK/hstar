class WordsController < ApplicationController

  def new
    @word = Word.new
  end

  def create

    text = params[:word][:text]
    exists = Word.exists?(text: text)

    if exists
      @word = Word.where(text: text).first
    else
      @word = Word.create(word_params)
    end

    if @word.save
      flash[:success] = "word created"
      redirect_to '/'
    else
      flash[:error] = "era era era eh eh eh eh eh eh eh"
      redirect_to new_word_path
    end
  end


  def word_params
    params.require(:word).permit(:type, :text, :article, :pronoun)
  end

end
