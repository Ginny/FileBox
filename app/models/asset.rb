class Asset < ActiveRecord::Base
  attr_accessible :user_id, :uploaded_file, :folder_id  
  belongs_to :user
  belongs_to :folder
  
  # paperclip usage
  has_attached_file :uploaded_file,
				:url => "assets/get/:id",
				:path => ":rails_root/assets/:id/:basename.:extension"
  
  validates_attachment_size :uploaded_file, :less_than => 10.megabytes
  validates_attachment_presence :uploaded_file
  
  # Paperclip created us column in assets called uploaded_file_file_name, but it's a bit ugly and too long
  def file_name
    uploaded_file_file_name
  end
  
  def file_size
    uploaded_file_file_size
  end
end
