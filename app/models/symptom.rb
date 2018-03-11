class Symptom < ApplicationRecord
  # Direct associations

  has_many   :logs,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
