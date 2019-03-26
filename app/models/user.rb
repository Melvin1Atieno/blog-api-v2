# frozen_string_literal: true

class User < ApplicationRecord
    has_secure_password
    has_many :blogs, dependent: :destroy
    validates :email, :username, :password, presence: true
    validates :username, :length=> {:minimum=>2}
    validates :password, :length => { :in => 8..20 }
    validates :email, :format => {:with=> /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
end
