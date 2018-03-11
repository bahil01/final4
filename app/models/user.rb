class User < ApplicationRecord
  # Direct associations

  has_many   :logs,
             :dependent => :destroy

  has_one    :treatment,
             :dependent => :destroy

  has_one    :cancer,
             :dependent => :destroy

  # Indirect associations

  has_many   :symptoms,
             :through => :logs,
             :source => :symptom

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
