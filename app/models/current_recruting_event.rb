class CurrentRecrutingEvent < ApplicationRecord
  belongs_to :user
  
  validates :end_of_application, presence: true, length: { maximum: 50 }
  validates :date_of_event, presence: true, length: { maximum: 50 }
  validates :event_name, presence: true, length: { maximum: 50 }
  validates :application_form, presence: true, length: { maximum: 100 }
end
