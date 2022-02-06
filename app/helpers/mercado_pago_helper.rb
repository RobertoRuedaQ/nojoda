module MercadoPagoHelper
  def cash_by_currency(billing_document)
    currency = billing_document.currency
    cash = nil
    case currency
    when 'PEN'
      cash = 'atm'
    else
      cash = 'ticket'
    end

    return cash
  end
end