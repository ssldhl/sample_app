# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :avatar
  has_secure_password
  has_many :forms, dependent: :destroy

  has_attached_file :avatar, :styles =>{:thumb => "100x100>", :small => "50x50>" }

  before_save { |user| user.email = email.downcase }

  before_save :create_remember_token

  validates_attachment :avatar, :size => { :in => 0..100.kilobytes }
  
  validates :name, presence: true, length: {maximum: 50}, :uniqueness => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Form.where("user_id = ?", id)
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
