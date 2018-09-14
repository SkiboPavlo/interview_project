class Phone < ApplicationRecord
  validates :phone_num, format: { with: /\(?\b([1-9]{3})\)?[-. ]?([1-9]{3})[-. ]?([1-9]{4})\b/,
                                  message: 'Only format XXX-XXX-XXXX' }, allow_blank: true,
                                  uniqueness: { message: 'This number is already busy'}
end
