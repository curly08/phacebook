class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :photo, dependent: :destroy

  validates_presence_of :body, :user
end
