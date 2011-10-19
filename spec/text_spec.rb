require_relative './spec_helper'

describe Phrasify::Text do
  
  let(:text) {
    Phrasify::Text.new(%q(
      The quick brown fox jumps over the lazy dog. 
      It's inevitable.
      and and and
    ))
  }
  
  describe "#words" do

    it "should return an Array" do
      text.words.should be_a(Array)
    end

    it "should not have any duplicate words" do
      text.words.should eql(text.words.uniq)
    end
    
    it "should not contain any strings with apostrophes" do
      text.words.join.should_not include("it's")
    end
    
    it "should only have lowercase characters" do
      text.words.join.should_not match(/[A-Z].+/)
    end
  end

  describe "#phraseable_words" do
    let(:phraseable_words) {
      text.phraseable_words
    }
    
    it "should not contain any common words" do
      phraseable_words.should eql(phraseable_words - Phrasify::COMMON_WORDS)
    end
  end

  describe "#parse" do
    
    before do
      @phrases = [
        Phrasify::Phrase.new("brown fox", "yellow rabbit"),
        Phrasify::Phrase.new("lazy", "laid back")
      ]
      Phrasify::Phrase.stub!(:search).and_return(@phrases)
    end
    
    it "should replace the contents of the string" do
      @phrases.each do |phrase|
        text.parse.should include(phrase.replace)
      end
    end
  end

  describe "#parse", "with phrases that match replacements" do
    
    before do
      @phrases = [
        Phrasify::Phrase.new("brown fox", "yellow rabbit"),
        Phrasify::Phrase.new("yellow rabbit", "purple kangaroo")
      ]
      Phrasify::Phrase.stub!(:search).and_return(@phrases)
    end
    
    it "should only replace phrases that have not already been matched" do
      text.parse.should include("yellow rabbit")
      text.parse.should_not include("purple kangaroo")
    end
  end

  describe "#parse", "with phrases that target the same term" do
    
    before do
      @phrases = [
        Phrasify::Phrase.new("brown fox", "orange hippo"),
        Phrasify::Phrase.new("brown", "purple kangaroo")
      ]
      Phrasify::Phrase.stub!(:search).and_return(@phrases)
    end
    
    it "should only replace phrase once" do
      text.parse.should include("orange hippo")
      text.parse.should_not include("purple kangaroo")
    end
  end


end