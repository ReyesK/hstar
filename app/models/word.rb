class Word < ActiveRecord::Base
  validates_presence_of :text
  validates_presence_of :type
  validates_presence_of :article, if: :noun?
  validates_presence_of :pronoun, if: :noun?

  self.inheritance_column = "not_type"

  NOUN_TYPE = 0
  VERB_TYPE = 1

  WORD_TYPES = [["noun", NOUN_TYPE], ["verb", VERB_TYPE]]

  def noun?
    Rails.logger.debug(type == NOUN_TYPE)
    type == NOUN_TYPE
  end

end
