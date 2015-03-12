class HomeController < ApplicationController

  def index

  end


  # GET /generate_excuse
  # responds JS
  def generate_excuse
    @excuse = Word.generate_excuse
    respond_to do |format|
      format.js
    end

  end

end
