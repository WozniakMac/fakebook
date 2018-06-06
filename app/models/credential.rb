class Credential < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :username, presence: true
  validates :apikey, presence: true
end
