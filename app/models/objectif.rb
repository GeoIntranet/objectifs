class Objectif < ApplicationRecord
  has_many :krs, dependent: :delete_all
end
