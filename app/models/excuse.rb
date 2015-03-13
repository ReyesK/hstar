class Excuse < ActiveRecord::Base


  def self.info
    "We have helped #{Excuse.all.size} people get out of things they don't want to do."
  end

end
