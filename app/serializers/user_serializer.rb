class UserSerializer
  include JSONAPI::Serializer
  attributes :uuid, :email, :created_at
end
