class CreatePhrase < ActiveRecord::Migration
  def self.up
    create_table :phrases do |t|
      t.text :text
      t.integer :language_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :phrases
  end
end
