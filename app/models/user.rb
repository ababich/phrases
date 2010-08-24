class User < ActiveRecord::Base
  acts_as_authentic #do |c|
#    c.validate_email_field = false # Email was excluded from the model at all
#  end
end
