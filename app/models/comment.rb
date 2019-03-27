# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :blog
  validates :body, presence: true
end
