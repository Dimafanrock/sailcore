class TokenService
  def self.generate_for(user)
    JsonWebToken.encode(user_id: user.id, type: user.type)
  end
end
