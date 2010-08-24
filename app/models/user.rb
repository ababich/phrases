class User < ActiveRecord::Base
  acts_as_authentic # Note that most validations are made by AuthLogic with this command

  #Model relationship
  has_and_belongs_to_many :languages
  belongs_to              :default_language, :class_name => "Language"

  # User suggests and has
  has_many                :phrases
  has_many                :translations
end
