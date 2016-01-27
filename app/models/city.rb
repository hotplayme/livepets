class City < ActiveRecord::Base
  
  validates :name, uniqueness:true
  has_many :users
  belongs_to :country
  has_many :mypets, through: :users
  
end
