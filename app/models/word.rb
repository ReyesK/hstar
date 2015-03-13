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
    adv_def = Wordnik.word.get_definitions(adv, partOfSpeech: 'adverb')[0]["text"]
    verb = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'verb-transitive')["word"]
    verb_def = Wordnik.words.get_definitions(verb, partOfSpeech: 'verb-transitive')[0]["text"]
    adj = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'adjective')["word"]
    adj_def = Wordnik.words.get_definitions(adj, partOfSpeech: 'adjective')[0]["text"]
    noun = Wordnik.words.get_random_word(hasDictionaryDef: true, includePartOfSpeech: 'noun')["word"]
    phrases = Wordnik.words.get_phrases(noun, limit: 10)

    if phrases.empty?
      phrase = noun
      phrase_def = Wordnik.word.get_definitions(phrase, partOfSpeech: 'noun')[0]["text"]
      phrase_string = "<span title='#{phrase_def}'>#{phrase}</span>"
    else
      phrase_hash = phrases[rand(phrases.size)]
      phrase_piece1 = phrase_hash["gram1"]
      phrase_piece2 = phrase_hash["gram2"]
      phrase_def_hash1 = Wordnik.word.get_definitions(phrase_piece1)
      phrase_def1 = phrase_def_hash1.empty? ? "" : phrase_def_hash1[0]["text"]
      phrase_def_hash2 = Wordnik.word.get_definitions(phrase_piece2)
      phrase_def2 = phrase_def_hash2.empty? ? "" : phrase_def_hash2[0]["text"]
      phrase_string = "<span title='#{phrase_def1}'>#{phrase_piece1}</span> <span title='#{phrase_def2}'>#{phrase_piece2}</span>"
    end


    strings = []
    strings << "I had to <span title='#{adv_def}'>#{adv}</span> <span title='#{verb_def}'>#{verb}</span> the #{phrase_string}."
    strings << "my #{phrase_string} is <span title='#{adj_def}'>#{adj}</span>."

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
