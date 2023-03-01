class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  def to_s
    email
  end

  def create_stripe_id
    response = Stripe::Customer.list({email: email})
    update(stripe_customer_id: response[:data].first.id)
  end

  after_create do
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
