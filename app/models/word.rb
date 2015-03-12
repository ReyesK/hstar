class Word < ActiveRecord::Base
  self.inheritance_column = "not_type"
end
