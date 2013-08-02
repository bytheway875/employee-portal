class Message < ActiveRecord::Base
  attr_accessible :body

  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  validates :body, :presence => true

  scope :unread, -> { where(read: false) }

  def deliver!(sending:nil, receiving:nil)
     raise ArgumentError, "both sender and receiver must be specified" unless sending && receiving
     raise Exception, "message cannot be nil" if self.body == nil || self.body == ""
     # raise , "message cannot be empty" unless body
    self.sender = sending
    self.recipient = receiving
    self.save
  end
end
