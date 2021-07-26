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
        success_url: "http://localhost:3001/Success?trees=#{params[:quantity]}",
        cancel_url: 'http://localhost:3001/Adopt',
        metadata: {
          'name': params[:name],
          'email': params[:email],
          'token': params[:token],
          'key': params[:key],
          'store_key': params[:store_key]
        },
      })
      redirect_to session.url, status: 303
  end

  def success

  end

  def webhook
    event = nil
    begin
      @payment_intent_id= params[:data][:object][:payment_intent]
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
      puts 'checkout_session object'
      pp checkout_session
      fulfill_order(checkout_session)
    end

    head :ok
  end

  private

  def payment_params
    params.permit(:quantity, :name, :email, :token, :key, :store_key)
  end

  def fulfill_order(checkout_session)
    @payment = Stripe::PaymentIntent.retrieve(@payment_intent_id)
    puts 'payment object'
    pp @payment
    @user = User.find_by(email: checkout_session["metadata"]["email"])
    puts 'found user'
    pp @user
    purchase = Purchase.create(user: @user, payment_intent_id: @payment_intent_id, receipt_url: @payment.charges.data[0]["receipt_url"])
    pp purchase
    # TODO: fill in with your own logic
    puts "Fulfilling order for #{checkout_session.inspect}"
  end
end
