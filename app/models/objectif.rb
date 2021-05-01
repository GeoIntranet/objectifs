class Objectif < ApplicationRecord

  validates :title, presence: true
  validates :title, length: { in: 3..15 }
  validates :weight, presence: true
  validates :weight, numericality: { only_integer: true }

  has_many :krs, dependent: :delete_all
end
