class Folder < ActiveRecord::Base
  acts_as_tree # it tells to the gem, what entity should acts as tree
  
  attr_accessible :name, :parent_id, :user_id
  
  belongs_to :user
  
  # If I delete 1 folder, it'll remove all the folder's assets
  has_many :assets, :dependent => :destroy
end
