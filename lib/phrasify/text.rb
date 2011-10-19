module Phrasify
  class Text < ::String
        
    ##
    # 
    #
    # @param [String] string The string you want to match phrases against
    # @param [#search] phrase_klass A class that responds to search with an array
    #                               of strings
    # @return [Phrasify::Text]
    def initialize(string, phrase_klass = Phrase)
      @phrase_klass = phrase_klass
      super(string)
    end
    
    ##
    # 
    # 
    # @return [Phrasify::Text]
    def parsed
      phrases.inject(self) {|string, phrase|
        string = gsub(phrase.match, phrase.replace)
      }
    end
    
    ##
    # Text broken down into words with all punctuation removed
    #
    # @return [Array<String>]
    def words
      gsub(/[^A-Za-z0-9_-|\s]/, '').downcase.split(" ").uniq
    end
    
    ##
    # Unique list of words that could have a matching phrase
    #
    # @return [Array<String>]
    def phraseable_words
      words - COMMON_WORDS
    end
    
    ##
    # Phrases that could match text
    #
    # @return [Array[<Phrase>]]
    def phrases
      @phrase_klass.search(phraseable_words)
    end
  end
end
