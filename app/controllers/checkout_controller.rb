class CheckoutController < ApplicationController 


  def create
    require 'stripe'
    Stripe.api_key = 'sk_test_51MWmjkHFC97yK2BpCHN44H3B5OarVE1biaZjaGbOz0MOH8aN8kw0283EjVIucUqJ52QvUZYtxzkNe7zLOGx2DJ5a00plhTltaZ'
      product = Product.find_by(id:params[:id].to_i)

      @session=Stripe::Checkout::Session.create({
        customer: current_user.stripe_customer_id,
        line_items: @cart.collect {|item| item.to_builder.attributes!},
        mode: 'payment',
        success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: root_url

      })
      respond_to do |format|
        format.js
      end
  end

  def success 
    @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]})
    @session_with_expand.line_items.data.each do |line_item|
      product = Product.find_by(stripe_product_id: line_item.price.product)
    end
  end

  def cancel;end

end