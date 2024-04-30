class SummaryService
  def initialize(user)
    @user = user
  end

  def monthly_rates
    paid_fees, unpaid_fees = partition_fees
    generate_fees_json(paid_fees, unpaid_fees)
  end

  private

  def partition_fees
    fees = @user.fees.where('created_at > ? AND created_at < ?', Time.now.at_beginning_of_month, Time.now.at_end_of_month)
    grouped_fees = fees.group_by { |fee| [fee.paid, fee.amount_currency] }

    grouped_fees.values.partition { |group| group[0].paid }
  end

  def generate_fees_json(paid_fees, unpaid_fees)
    json = {
      paid_fees: [],
      unpaid_fees: []
    }

    add_diff_fees(json, paid_fees, :paid_fees)
    add_diff_fees(json, unpaid_fees, :unpaid_fees)

    json
  end

  def add_diff_fees(json, group_fees, type)
    group_fees.each do |fees|
      json[type].push(
        {
          amount_cents: fees.sum(&:amount_cents),
          amount_currency: fees[0].amount_currency
        }
      )
    end
  end
end
