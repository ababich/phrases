class CreateTranslation < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.integer :source_id # Phrase
      t.integer :target_id # Phrase
      t.integer :user_id   # Creator

      t.timestamps
    end

    add_index :translations, [:source_id, :target_id], :unique => true
  end

  def self.down
    drop_table :phrases
  end
end
