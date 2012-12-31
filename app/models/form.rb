class Form < ActiveRecord::Base
  attr_accessible :address, :dob, :name
  belongs_to :user
  validates :address, presence: true, length: { maximum: 140 }
  validates :dob, presence: true
  validates :name, presence: true, length: {maximum: 50}
  validates :user_id, presence: true

  default_scope order: 'forms.created_at DESC'
end
