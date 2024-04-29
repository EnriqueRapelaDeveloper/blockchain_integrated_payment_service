class FeeService
  KINDS = {
    Payment: 'payments',
    Trade: 'trades'
  }

  def initialize(resource, fee_configuration)
    @resource = resource
    @fee_configuration = fee_configuration
  end

  def collect(amount_cents, currency)
    kind = type_of_fee
    fee_amount_cents = calculate_fee(amount_cents, kind)
    create_fee(kind, fee_amount_cents, currency)

    fee_amount_cents
  end

  def get_fees(amount_cents)
    kind = type_of_fee
    calculate_fee(amount_cents, kind)
  end

  private

  def type_of_fee
    KINDS[KINDS.keys.find { |k| @resource.class.to_s.include?(k.to_s) }]
  end

  def calculate_fee(amount_cents, kind)
    percentage = @fee_configuration.send("#{kind}_percentage")
    amount_cents * (percentage / 100)
  end

  def create_fee(kind, fee_amount_cents, currency)
    paid = @fee_configuration.send(kind)
    @resource.build_fee(amount_cents: fee_amount_cents, amount_currency: currency, paid: paid)
  end
end
