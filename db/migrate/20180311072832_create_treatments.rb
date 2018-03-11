class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.integer :user_id
      t.string :treatment_name

      t.timestamps

    end
  end
end
