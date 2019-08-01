class Transferencia < ActiveRecord::Base
  has_many :lancamentos, dependent: :destroy


  def full_name
    "#{id} - #{nome}"

  end
end
