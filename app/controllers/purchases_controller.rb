class PurchasesController < ApplicationController

  before_action :payment_params, only: [:create]

  def create
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'aud',
            product_data: {
              name: 'Adopt a tree',
            },
            unit_amount: 100,
          },
          quantity: params[:quantity]
        }],
        mode: 'payment',
        success_url: 'http://localhost:3001/Mytrees',
        cancel_url: 'http://localhost:3001/Adopt'
      })
      redirect_to session.url, status: 303
  end

  def webhook
    event = nil
    begin
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      payload = request.body.read
      endpoint_secret = Rails.application.credentials.stripe[:endpoint_secret]
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      return head :bad_request
    end

    if event['type'] == 'checkout.session.completed'
      checkout_session = event['data']['object']
      fulfill_order(checkout-session)
    end

    head :ok
  end

  private

  def payment_params
    params.permit(:quantity)
  end

  def fulfill_order(checkout_session)
    # TODO: fill in with your own logic
    puts "Fulfilling order for #{checkout_session.inspect}"
  end
end
