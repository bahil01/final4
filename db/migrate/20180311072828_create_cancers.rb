class CreateCancers < ActiveRecord::Migration
  def change
    create_table :cancers do |t|
      t.integer :user_id
      t.string :cancer_name

      t.timestamps

    end
  end
end
