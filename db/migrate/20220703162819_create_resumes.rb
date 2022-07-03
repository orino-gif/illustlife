class CreateResumes < ActiveRecord::Migration[5.2]
  def change
    create_table :resumes do |t|
      t.integer :resume_user
      t.integer :notification_user

      t.timestamps
    end
  end
end
