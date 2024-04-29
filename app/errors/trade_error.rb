class TradeError < StandardError
  attr_reader :error_code, :full_message

  def initialize(error_code, full_message = 'An error occurred while converting.')
    trade_logger = TradeLogger.new('log/trade.log')
    @error_code = error_code
    @full_message = full_message
    trade_logger.error('An error ocurred while converting.')
    super(full_message)
  end
end
