class BlockchainService
  def initialize(user, amount_cents, amount_currency)
    @user = user
    @amount_cents = amount_cents
    @amount_currency = amount_currency
    @blockchain_payment = initialize_blockchain_payment
  end

  def execute
    calculate_fee

    @blockchain_payment.save
  end

  private

  def initialize_blockchain_payment
    BlockchainPayment.new(user: @user, amount_cents: @amount_cents, amount_currency: @amount_currency)
  end

  def calculate_fee
    fee_service = FeeService.new(@blockchain_payment, @user.fee_configuration)
    fee_amount_cents = fee_service.get_fees(@blockchain_payment.amount_cents)
    fee_service.collect(@blockchain_payment.amount_cents, @blockchain_payment.amount_currency)

    return unless @user.fee_configuration.payments

    @blockchain_payment.amount_cents = @blockchain_payment.amount_cents - fee_amount_cents
  end
end
