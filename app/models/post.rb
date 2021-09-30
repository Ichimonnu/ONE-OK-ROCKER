class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    has_many :comments, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags, dependent: :destroy
end
