class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :prefecture_id
end
