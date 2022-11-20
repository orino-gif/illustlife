class RenameResume < ActiveRecord::Migration[5.2]
  def change
    rename_column :resumes, :resume_user, :re_id
    rename_column :resumes, :notification_user, :noti_id
  end
end
