require "pry"
require "time"

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(invoice_data, parent=nil)
              @id          = invoice_data[:id].to_i
              @customer_id = invoice_data[:customer_id].to_i
              @merchant_id = invoice_data[:merchant_id].to_i
              @status      = invoice_data[:status].to_sym
              @created_at  = Time.parse(invoice_data[:created_at])
              @updated_at  = Time.parse(invoice_data[:updated_at])
              @parent      = parent
  end
  def merchant
    @parent.find_merchant_by_id(merchant_id)
  end

  def items
    @parent.find_items_by_invoice_id(id)
  end

  def transactions
    @parent.find_transactions_by_invoice_id(id)
  end

  def customer
    @parent.find_customer_by_invoice_id(customer_id)
  end

  def is_paid_in_full?
    if  transactions.length == 0
      false
    else
      transactions.all? { |transaction| transaction.result == "success" }
    end
  end

  def invoice_items
    @parent.find_invoice_items_by_invoice_id(id)
  end

  def total
    if is_paid_in_full?
      invoice_items.reduce(0) do |item, num|
        item += (num.unit_price * num.quantity)
      end
    end
  end





end
