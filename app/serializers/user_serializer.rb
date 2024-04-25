class UserSerializer
  include JSONAPI::Serializer
  set_id :uuid
  attributes :email, :created_at
end
