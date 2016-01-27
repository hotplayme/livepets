class Mypet < ActiveRecord::Base

  include Votable
  
  validates :name, presence:true
  validates :name, length: { minimum: 3 }

  
  x = rand(5..30000)

  has_attached_file :photo, :styles => { :medium => "600x432#", :thumb => "200x200#", :thumb_list => "280x201#", :thumb_small => "70x70#", :thumb_main => "174x120#", :pet_day => "880x495#" },
        :url => "/system/:attachment/:id/:style/:id.:extension",
        :path => ":rails_root/public/system/:attachment/:id/:style/:id.:extension"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :user
  belongs_to :breed
  has_many   :votes, as: :votable, dependent: :destroy
  has_many   :pet_attachments, dependent: :destroy
  #has_many :attachments, as: :attachable, dependent: :destroy

  def self.default_url
    "/images/pet_no_image_1.png"
  end

  def self.main_image(pet)
    if pet.pet_attachments.count > 0
      pet.pet_attachments.where(main:true).first.file.thumb_600
    else
      Mypet.default_url
    end
  end

end