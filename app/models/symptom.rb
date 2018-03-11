class Symptom < ApplicationRecord
  # Direct associations

  has_many   :logs,
             :dependent => :destroy

  # Indirect associations

  has_many   :users,
             :through => :logs,
             :source => :user

  # Validations

end
