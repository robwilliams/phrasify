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
    def parse
      phrases.inject(self) do |string, phrase|
        
        string = string.split(":phrasify:").inject("") do |new_string, part|
          
          # If this part of the string has already been matched we won't try
          # and match it again.
          if part.include?(":matched:")
            new_string += part
          else
            new_string += part.gsub(
              phrase.match, 
              ":phrasify::matched:#{phrase.replace}:matched::phrasify:"
            )
          end
        end
      end.gsub(":matched:", "").gsub(":phrasify:", "")
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
