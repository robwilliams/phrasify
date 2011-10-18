module Phrasify
  class Phrase
    
    attr_reader :matcher
    
    def initialize(matcher)
      @matcher = matcher
    end
    
    def replace
      "herrpr"
    end
    
    def self.search(phrases)
      [new("fred")]
    end
  end
end
