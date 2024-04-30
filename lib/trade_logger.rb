require 'logger'

class TradeLogger < Logger
  def initialize(logdev, level: Logger::DEBUG, progname: nil, shift_age: 'daily', shift_size: 10 * 1024 * 1024)
    super(logdev, shift_age, shift_size)
    self.level = level
    self.progname = progname
    self.formatter = proc do |severity, datetime, progname, msg|
      "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} [#{severity}] #{progname}: #{msg}\n"
    end
  end
end
