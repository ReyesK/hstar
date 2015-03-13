class HomeController < ApplicationController

  def index

  end


  # GET /generate_excuse
  # responds JS
  def generate_excuse
    @excuse = "Because.... " + Word.generate_excuse
    Excuse.create(excuse: @excuse)
    respond_to do |format|
      format.js
    end

  end

end
