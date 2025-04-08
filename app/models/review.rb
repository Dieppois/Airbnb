class Review < ApplicationRecord
  belongs_to :user
  belongs_to :property, counter_cache: true

  validates :content, presence: :true
  validates :cleanliness_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :accuracy_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :checkin_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :communication_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :location_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :value_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  ## Appel la méthode update_final_rating l'orsque qu'on ajoute ou modifie une review
  after_commit :update_final_rating, on: [:create, :update]

  def update_final_rating
    total =
    cleanliness_rating +
    accuracy_rating +
    checkin_rating +
    communication_rating +
    location_rating +
    value_rating

    update_column(:final_rating, total.to_f / 6)

    property.update_average_rating
  end
end
