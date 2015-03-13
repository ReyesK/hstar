class Word < ActiveRecord::Base
  validates_presence_of :text
  validates_presence_of :type
  validates_presence_of :article, :if => :noun?
  validates_presence_of :pronoun, :if => :noun?

  self.inheritance_column = "not_type"

  NOUN_TYPE = "0"
  VERB_TYPE = "1"
  ADJ_TYPE  = "2"
  ADV_TYPE  = "3"

  WORD_TYPES = [["noun", NOUN_TYPE], ["verb", VERB_TYPE]]

  ARTICLE_OPTS = [["A", "a"], ["An", "an"], ["The", "the"], ["My", "my"]]

  PRONOUN_OPTS = [
                    ["I", "I"], ["Me", "me"], ["My", "my"], ["Mine", "mine"], ["Myself", "myself"],
                    ["You", "you"], ["Your", "your"], ["Yours", "yours"], ["Yourself", "yourself"],
                    ["He", "he"], ["Him", "him"], ["His", "his"], ["Himself", "himself"],
                    ["She", "she"], ["Her", "her"], ["Hers", "hers"], ["Herself", "herself"],
                    ["It", "it"], ["Its", "its"], ["Itself", "itself"],
                    ["We", "we"], ["Us", "us"], ["Our", "our"], ["Ours", "ours"], ["Ourselves", "ourselves"],
                    ["You", "you"], ["Your", "your"], ["Yours", "yours"], ["Yourselves", "yourselves"],
                    ["They", "they"], ["Them", "them"], ["Their", "their"], ["Theirs", "theirs"], ["Themselves", "themselves"]
                 ]

                 
  def noun?
    type == NOUN_TYPE
  end

  def self.generate_excuse
    # here generate it
    # I have to [verb] [article] [noun] because [noun] [verb] [pronoun]

    adv = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'adverb')["word"]
    adv2 = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'adverb')["word"]
    verb = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'verb-transitive')["word"]
    adj = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'adjective')["word"]
    adj2 = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'adjective')["word"]
    noun = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'noun')["word"]
    phrases = Wordnik.words.get_phrases(noun, limit: 10)
    Rails.logger.debug(phrases)

    if phrases.empty?
      phrase = noun
    else
      phrase_hash = phrases[rand(phrases.size)]
      phrase = phrase_hash["gram1"] + " " + phrase_hash["gram2"]
    end


    strings = []
    strings << "I had to #{adv} #{verb} the #{phrase}"
    strings << "My #{phrase} is #{adj2}"

    strings[rand(strings.size)]


    # OLD CRAP
    # count = Word.last.id
    # while verb1.nil?
    #   verb1 = Word.where("id >= ? and type=?", rand(count), Word::VERB_TYPE).first
    # end
    #
    # while verb2.nil?
    #   verb2 = Word.where("(id != ? and id >= ?) and type=?", verb1.id, rand(count), Word::VERB_TYPE).first
    # end
    #
    # while noun1.nil?
    #   noun1 = Word.where("id >= ? and type=?", rand(count), Word::NOUN_TYPE).first
    # end
    #
    # while noun2.nil?
    #   noun2 = Word.where("(id != ? and id >= ?) and type=?", noun1.id, rand(count), Word::NOUN_TYPE).first
    # end

    # "I have to #{verb1.text} #{noun1.article} #{noun1.text} because #{noun2.text} #{verb2.text} #{noun1.pronoun}."
    # END THAT OLD CRAP
  end

end
