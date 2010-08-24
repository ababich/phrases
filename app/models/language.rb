class Language < ActiveRecord::Base

  #Model relationship
  has_and_belongs_to_many :users
end
