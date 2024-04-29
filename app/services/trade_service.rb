class TradeService
  def initialize(user, amount_cents, amount_currency)
    @user = user
    @amount_cents = amount_cents
    @amount_currency = amount_currency
  end

  def execute
    @trade = initialize_trade
    calculate_fee
    final_amount_cents, final_amount_currency = calculate_conversion
    update_trade(final_amount_cents, final_amount_currency)
  end

  private

  def initialize_trade
    Trade.new(user: @user, original_amount_cents: @amount_cents, original_amount_currency: @amount_currency)
  end

  def calculate_fee
    fee_service = FeeService.new(@trade, @user.fee_configuration)
    fee_amount_cents = fee_service.get_fees(@trade.original_amount_cents)
    fee_service.collect(@trade.original_amount_cents, @trade.original_amount_currency)

    return unless @user.fee_configuration.trades

    @trade.original_amount_cents = @trade.original_amount_cents - fee_amount_cents
  end

  def calculate_conversion
    # Mock API call to realize the exchange
    exchange_rate = 1.20 # EUR/USDT
    currency = 'USDT'
    [@trade.original_amount_cents * exchange_rate, currency]
  end

  def update_trade(final_amount_cents, final_amount_currency)
    @trade.final_amount_cents = final_amount_cents
    @trade.final_amount_currency = final_amount_currency

    @trade.save
  end
end
