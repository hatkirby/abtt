# == Schema Information
#
# Table name: permissions
#
#  id      :integer          not null, primary key
#  pattern :string(255)
#

# See <a href="http://wiki.rubyonrails.com/rails/show/AccessControlListExample">http://wiki.rubyonrails.com/rails/show/AccessControlListExample</a>
# and <a href="http://wiki.rubyonrails.com/rails/show/LoginGeneratorAccessControlList">http://wiki.rubyonrails.com/rails/show/LoginGeneratorAccessControlList</a>

class Permission < ActiveRecord::Base
  has_and_belongs_to_many :roles

  def to_s
    pattern
  end
end
