class Client < User
  has_paper_trail save_changes: true
  acts_as_voter

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true, length: { maximum: 256 }
  validates :password, format: { with: /(?=.*\d)(?=.*[a-zA-Z]).{6,}/,
                                 message: I18n.t('models.user.password_validation') }
  validates :password, confirmation: true

  validates :email, uniqueness: true
end
