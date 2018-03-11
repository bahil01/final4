class Log < ApplicationRecord
  # Direct associations

  belongs_to :symptom

  belongs_to :user

  # Indirect associations

  # Validations

end
