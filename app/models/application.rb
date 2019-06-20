class Application < ApplicationRecord
    has_many :chats, inverse_of: 'application_intiators'
    has_many :chats, inverse_of: 'application_receivers'
    has_many :messages, inverse_of: 'senders'
    has_many :messages, inverse_of: 'receivers'
end
