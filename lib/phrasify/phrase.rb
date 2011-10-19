module Phrasify
  class Phrase
    
    attr_reader :match, :replace
    
    def initialize(match, replace)
      @match, @replace = match, replace
    end
        
    def self.search(phrases)
      [new("fred", "derf")]
    end
  end
end
