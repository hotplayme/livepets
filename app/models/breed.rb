class Breed < ActiveRecord::Base

  validates :name, uniqueness: true 
  has_many :pets
  has_many :reviews
  has_many :subscribers, as: :subscribable, dependent: :destroy

  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
