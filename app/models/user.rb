class User < ActiveRecord::Base
  devise   :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :vkontakte, :odnoklassniki, :yandex, :mailru, :google_oauth2]
  
  validates :nickname, :uniqueness  => { case_sensitive: false }, length: { minimum: 3 }, format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows letters" }, allow_nil: true
  #validates_format_of :nickname , with: /\A[a-zA-Z0-9]+\z/
  #validates_uniqueness_of :nickname, allow_nil: true



  has_many   :mypets, dependent: :destroy
  has_many   :reviews
  has_many   :mini_reviews
  has_many   :blogs
  has_many   :comments
  has_many   :notices
  belongs_to :city
  has_and_belongs_to_many :dialogs
  has_many   :messages
  has_many   :topics
  has_many   :posts
  belongs_to :country
  has_many   :votes
  has_many   :subscribes
  has_many   :winners
  has_many   :authorizations, dependent: :destroy

  
  has_attached_file :avatar, :styles => { :small => "200x200#", :large => "500x500>" },
                      :processors => [:cropper],
                      :url => "/system/:attachment/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
  validates_attachment_content_type :avatar, :content_type => /\Aimage/
 #validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes


  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => "cropping?"
  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.send_new_user_message(self).deliver
  end



  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  def self.find_for_oauth_facebook(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 10]
      user = User.create!(email: email, password: password, password_confirmation: password, nickname: "user#{(User.last.id).to_i + 1}", first_name: auth.info[:first_name], last_name: auth.info[:last_name])
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    end
    user
  end

  def self.find_for_oauth_vk(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    if auth.info[:email].to_s == ''
      email = "#{((0...10).map { ('a'..'z').to_a[rand(26)] }.join)}@mail.com"
    else
      email = auth.info[:email]
    end

    user  = User.find_by_email(email)

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 10]
      user = User.new(email: email, password: password, password_confirmation: password, nickname: "user#{(User.last.id).to_i + 1}", first_name: auth.info[:first_name], last_name: auth.info[:last_name])
      if user.valid?
        user.save!
        unless auth.extra.raw_info[:photo_200_orig].to_s == 'http://vk.com/images/camera_200.png'
          require 'open-uri'
          open('image.png', 'wb') do |file|
            file << open(auth.extra.raw_info[:photo_200_orig]).read
            user.update(avatar: file)
          end
        end
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
      end
    end
    return user
  end

  def self.find_for_oauth_ok(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization


    email = "#{((0...10).map { ('a'..'z').to_a[rand(26)] }.join)}@mail.com"

    user  = User.find_by_email(email)

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 10]
      user = User.new(email: email, password: password, password_confirmation: password, nickname: "user#{(User.last.id).to_i + 1}", first_name: auth.info[:first_name], last_name: auth.info[:last_name])
      if user.valid?
        user.save
        if auth.info[:image]
          require 'open-uri'
          open('image.png', 'wb') do |file|
            file << open(auth.info[:image]).read
            User.last.update(avatar: file)
          end
        end
        if auth.extra.raw_info.location
          if city = City.find_by_name(auth.extra.raw_info.location[:city])
            user.city = city
            user.save
          end
        end
        user.authorizations.create(provider: auth.provider, uid: auth.uid)
      end
    end
    user
  end

  def self.find_for_oauth_yandex(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user  = User.find_by_email(email)

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 10]
      user = User.new(email: email, password: password, password_confirmation: password, nickname: "user#{(User.last.id).to_i + 1}", first_name: auth.extra.raw_info[:first_name], last_name: auth.extra.raw_info[:last_name])
      if user.valid?
        user.save
        user.authorizations.create(provider: auth.provider, uid: auth.uid)
      end
    end
    user
  end

  def self.find_for_oauth_mailru(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user  = User.find_by_email(email)

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 10]
      user = User.new(email: email, password: password, password_confirmation: password, nickname: "user#{(User.last.id).to_i + 1}", first_name: auth.info[:first_name], last_name: auth.info[:last_name])
      if user.valid?
        user.save
        if auth.extra.raw_info.location.city
          if city = City.find_by_name(auth.extra.raw_info.location.city[:name])
            user.city = city
            user.save
          end
        end
        user.authorizations.create(provider: auth.provider, uid: auth.uid)
      end
    end
    user
  end

  def self.find_for_oauth_gmail(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user  = User.find_by_email(email)

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 10]
      user = User.new(email: email, password: password, password_confirmation: password, nickname: "user#{(User.last.id).to_i + 1}", first_name: auth.info[:first_name], last_name: auth.info[:last_name])
      if user.valid?
        user.save
        user.authorizations.create(provider: auth.provider, uid: auth.uid)
      end
    end
    user
  end

  private

  def reprocess_avatar
    avatar.reprocess!
  end

end
