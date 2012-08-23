class Task < ActiveRecord::Base
  include Enumerize

  belongs_to :user

  attr_accessible :title, :due_date, :priority, :completed, :user

  enumerize :priority, in: [:very_high, :high, :normal, :low, :very_low], default: :normal

  validates :title, presence: true
  validates :due_date, presence: true
  validates :priority, presence: true
  validates :user_id, presence: true

  after_initialize :set_defaults

  def self.priority_options
    options = {}
    Task.priority.options.map{ |p| options[p[1]] = p[0] }
    options
  end

  private

  def set_defaults
    self.completed = false if completed.blank?
    self.due_date = Date.today if due_date.blank?
    self.priority = :normal if priority.blank?
  end
end
