class User < ApplicationRecord
  before_create :generate_token
  has_secure_password

  belongs_to :hometown, class_name: "City", optional: true
  belongs_to :residency, class_name: "City", optional: true
  has_many :posts, foreign_key: :author_id
  has_many :likes
  has_many :comments, foreign_key: :commenter_id

  accepts_nested_attributes_for :hometown,
                                :reject_if => :all_blank
  accepts_nested_attributes_for :residency,
                                :reject_if => :all_blank

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  validates :birth_date, :first_name, :last_name, :email, :gender, :birth_date, presence: true

  validates :first_name, :last_name, :email, length: { in: (1..50) }
  validates_format_of :email, :with => /@/
  validates :college, length: { maximum: 50 }
  validates :telephone, length: { maximum: 20 }
  validates :quote, length: { maximum: 255 }
  validates :about, length: { maximum: 1000 }

  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self.auth_token)
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
