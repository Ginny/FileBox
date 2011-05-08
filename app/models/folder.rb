class Folder < ActiveRecord::Base
  acts_as_tree # it tells to the gem, what entity should acts as tree
  
  attr_accessible :name, :parent_id, :user_id
  
  belongs_to :user
end
