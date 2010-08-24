class Translation < ActiveRecord::Base
  # In case AR has no efficient solution for Model-to-itself HABTM associations we'll use special
  # Translation model with helpful methods to find Phrase.translations

  # Each new Translation from phrase A to B immediately creates its twin with phrase B to A connection

  #Model relationship
  belongs_to :source, :class_name => "Phrase"
  belongs_to :target, :class_name => "Phrase"

  belongs_to :user # who suggests translation pair
  validates_presence_of :source, :target, :user

  # after_create twin
  def after_create
    unless Translation.for?(self.target, self.source) #primitive construction to avoid cycling
      twin = self.clone

      twin.source, twin.target = self.target, self.source
      twin.save!
    end
  end



  # Existence public class method
  def self.for?(phrase_a, phrase_b)
    raise ArgumentError, "requires Phrases as params" unless phrase_a.is_a?(Phrase) && phrase_b.is_a?(Phrase)
    
    Translation.first(:conditions => {:source_id => phrase_a, :target_id => phrase_b})
  end
end