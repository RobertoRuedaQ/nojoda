FactoryBot.define do
  factory :country do
    name { 'Colombia'}
    yearly_usury_rate { 40 }
    round_up_to { 2 }
    currency { 'COP' }
  end
end