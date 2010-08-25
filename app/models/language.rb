class Language < ActiveRecord::Base
  # Special model Language is just convenient to use some AR power and connect different entities
  # to the same objects


  #Model relationship
  has_and_belongs_to_many :users


#  def self.named(lang)
#    unless lang.is_a? Language
#      lang = Language.find_by_name lang
#
#      raise ArgumentError, "cannot work with specified language" unless lang
#    end
#
#    lang
#  end
end
