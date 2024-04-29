class FeeSerializer
  include JSONAPI::Serializer
  set_id :uuid
  attributes :amount_cents, :amount_currency, :paid, :created_at
end
