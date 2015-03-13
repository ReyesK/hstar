class Excuse < ActiveRecord::Base


  def self.info
    "We have helped <b>#{Excuse.all.size}</b> people get out of things they don't want to do.".html_safe
  end

end
