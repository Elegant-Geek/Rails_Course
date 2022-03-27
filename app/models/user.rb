class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  has_secure_password
  before_validation { self.password_confirmation ||= password }
  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ },
  uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 10, allow_blank: true } 

  
  scope :by_name, -> { order(name: :asc) }
  scope :not_admins, -> { by_name.where(admin: false) }
  # allow_blank :true means that a user is allowed to 
  # update other attributes without updating password.
  validates :username, 
  allow_blank: true,
  format: { with: /\A[A-Z0-9]+\z/i },
  uniqueness: { case_sensitive: false },
  length: { minimum: 5 }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

end

