class Subscriber < ActiveRecord::Base

  belongs_to :user
  belongs_to :subscribable, polymorphic: true

end
