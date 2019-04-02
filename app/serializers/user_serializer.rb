class UserSerializer
  class << self

    def serialize(user)
      user.as_json(root: true, only: %i[id email role created_at updated_at])
    end
  end
end
