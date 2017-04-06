class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :name
      # t.references :question, foreign_key: true, index: true
      # ths key should nt b here. it should b in question model

      t.timestamps
    end
  end
end
