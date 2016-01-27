class Breed < ActiveRecord::Base

  validates :name, uniqueness: true 
  has_many :mypets
  has_many :reviews

  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
