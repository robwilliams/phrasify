require_relative './spec_helper'

describe Phrasify::Text do
  
  describe "#words" do
    
    let(:words) { 
      Phrasify::Text.new(%q(
        The quick brown fox jumps over the lazy dog. 
        It's inevitable.
        and and and
      )).words 
    }
    
    it "should return an Array" do
      words.should be_a(Array)
    end

    it "should not have any duplicate words" do
      words.should eql(words.uniq)
    end
    
    it "should not contain any strings with apostrophes" do
      words.join.should_not include("it's")
    end
    
    it "should only have lowercase characters" do
      words.join.should_not match(/[A-Z].+/)
    end
  end

  describe "#phraseable_words" do
    let(:phraseable_words) {
      Phrasify::Text.new(%q(
        The quick brown fox jumps over the lazy dog. 
        It's inevitable.
        and and and
      )).phraseable_words
    }
    
    it "should not contain any common words" do
      phraseable_words.should eql(phraseable_words - Phrasify::COMMON_WORDS)
    end
  end
end