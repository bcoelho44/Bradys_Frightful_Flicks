Rails.configuration.stripe[:publishable_key] = ENV["STRIPE_PUBLISHABLE_KEY"]
Rails.configuration.stripe[:secret_key] = ENV["STRIPE_SECRET_KEY"]

Stripe.api_key = Rails.configuration.stripe[:secret_key]
