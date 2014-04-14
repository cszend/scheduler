class Provider < ActiveRecord::Base
  belongs_to :office #, inverse_of: :offices
  #validates_presence_of :office

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :username,  presence: true, length: { maximum: 70 }
  #validates :office,  presence: true
  validates :role,  presence: true, numericality: { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 2 }
  validates :access,  numericality: { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 4 }, on: :update
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
     uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

  has_secure_password

  def Provider.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Provider.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Provider.hash(Provider.new_remember_token)
    end
end
