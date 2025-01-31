class Admin < User
  has_paper_trail save_changes: true
end
