class City < ActiveRecord::Base
  
  validates :name, uniqueness:true
  has_many :users
  belongs_to :country
  has_many :pets, through: :users
  
end
