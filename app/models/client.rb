class Client < User
  acts_as_voter
  has_paper_trail save_changes: true
end
