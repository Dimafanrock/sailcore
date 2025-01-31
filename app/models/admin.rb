class Admin < User
  has_paper_trail

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true
end
