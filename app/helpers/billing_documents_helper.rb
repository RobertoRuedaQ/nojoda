module BillingDocumentsHelper
  def uwc_to_payment(billing_document)
    f_o = billing_document.isa.funding_opportunity
    if f_o.id == 220
      return 'https://checkout.baccredomatic.com//YTYyZDNjNDQ4ODcwODU2MDMyNjczNC4xNjIzMzQ1MzYz'
    elsif f_o.id == 369
      return 'https://checkout.baccredomatic.com//MDA0NTNlNTRmMmMyNDY2LmEyODYwMzcxNjIzMzQ1Mzgw'
    else
      return nil
    end
  end
end
