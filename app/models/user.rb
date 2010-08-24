class User < ActiveRecord::Base
  acts_as_authentic #do |c|
#    c.validate_email_field = false # Email was excluded from the model at all
#  end

  #Model relationship
  has_and_belongs_to_many :languages
  has_one                 :default_language, :class_name => "Language"
end
