class Excuse < ActiveRecord::Base


  def self.info
    "We have helped <span class='excuse_count'><b>#{Excuse.all.size}</b></span> people get out of things they don't want to do.".html_safe
  end

end
