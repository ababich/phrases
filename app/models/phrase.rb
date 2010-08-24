class Phrase < ActiveRecord::Base
  #Model relationship
  has_many :translations, :foreign_key => "source_id"

  belongs_to :user # who suggests phrase

  belongs_to :language
  validates_presence_of :language, :user, :text

  # Translate methods
  def save_translation_to_lang_with_text(lang, text, user = nil)
    lang = Language.named lang
    if lang == self.language
      raise "you cannot translate to the same language"
    end

    target = Phrase.create!({:language => lang, :text => text, :user => user})
    self.translate_to(target)
  end

  def save_translation_to(target, user = target.user)
    unless target.is_a? Phrase
      raise ArgumentError, "requeires Prase as param, try to use save_translation_to_lang_with_text if have no Phrase"
    end
    if target.language == self.language
      raise "you cannot translate to the same language"
    end

    return nil if Translation.for?(self, target)

    Translation.create!({:user => user, :source => self, :target => target})
    target.reload
    self.reload
  end

  def translate_to(lang)
    lang = Language.named lang
    return self if self.language == lang

    # TODO: slow method, should be replaced with direct AR.find-family constructions if DB is big
    self.translation_phrases.detect { |p| p.language == lang }
  end

  def translation_phrases
    self.translations.map(&:target)
  end
end