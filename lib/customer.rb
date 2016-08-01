require "pry"
require "time"

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(customer_data, parent=nil)
              @id         = customer_data[:id].to_i
              @first_name = customer_data[:first_name].to_s
              @last_name  = customer_data[:last_name].to_s
              @created_at = Time.parse(customer_data[:created_at])
              @updated_at = Time.parse(customer_data[:updated_at])
              @parent     = parent
  end

  def merchant
    @parent.find_merchant_by_customer_id(customer_id)
  end

end
