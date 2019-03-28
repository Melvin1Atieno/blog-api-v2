class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username
  type 'user'

  has_many :blogs
end
