class Chat < ApplicationRecord
    has_many :messages
    belongs_to :application_intiator,class_name: 'Application', foreign_key: 'application_intiator_id'
    belongs_to :application_receiver,class_name: 'Application', foreign_key: 'application_receiver_id'  
end
