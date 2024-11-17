Rails.configuration.stripe = {
  publishable_key: "pk_test_51QM7YeF7f8sxx1UdN6D5yJ0DUJM0A1tyLClCuUAWpwbgfCTngxyVES7C0PneU3NMRPRfz33JpsfgZm7KR4hGvFXZ00RWrmLCnR",
  secret_key: "sk_test_51QM7YeF7f8sxx1UdeQKQiJGeTbJngg3jbV1X7Y9NDNt25rFaqLeobaCFekf0ZCuUK9tb55H10Mc5TzjRlqZIV6QA00K68eSl3A"
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
# Stripe.api_key = Rails.configuration.stripe[:secret_key]

# Stripe.api_key = Rails.application.credentials.dig(:stripe, :sk)
STRIPE_SUPPORTED_COUNTRIES = ["AU", "AT", "BE", "BG", "CA", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR", "HK", "HU", "IE", "IT", "JP", "LV", "LT", "LU", "MT", "NL", "NZ", "NO", "PL", "PT", "RO", "SG", "SK", "SI", "ES", "SE", "CH", "GB", "US"].freeze