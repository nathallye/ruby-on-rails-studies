class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }

  belongs_to :author # pertence a 
end
