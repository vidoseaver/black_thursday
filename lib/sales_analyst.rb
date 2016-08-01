require "bigdecimal"
require "pry"
class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchant_items(merchant_id)
    @sales_engine.find_items_by_merchant_id(merchant_id)
  end

  def merchant_items_count(merchant_id)
    @sales_engine.find_items_by_merchant_id(merchant_id).count
  end

  def merchant_invoice_count(merchant_id)
    @sales_engine.find_invoices_by_merchant_id(merchant_id).count
  end

  def merchant_count
    @sales_engine.merchant_count
  end

  def item_count
    @sales_engine.item_count
  end

  def invoice_count
    @sales_engine.invoice_count
  end

  def average_items_per_merchant
  (item_count/merchant_count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    total = all_merchants.map do |merchant|
      ((merchant_items_count(merchant.id)) - average_items_per_merchant)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1)).round(2)
  end

  def all_merchants
    @sales_engine.all_merchants
  end

  def all_items
    @sales_engine.all_items
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    all_merchants.find_all do |merchant|
      merchant_items_count(merchant.id) > (standard_deviation + average_items_per_merchant)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    total = merchant_items(merchant_id).map do |item|
      item.unit_price
    end
    (total.reduce(:+)/total.length).round(2)
  end

  def average_average_price_per_merchant
    averages = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  (averages.reduce(:+)/all_merchants.length).round(2)
  end

  def average_item_price
    total = all_items.map do |item|
      item.unit_price
    end
    (total.reduce(:+)/total.length.to_f)
  end

  def standard_deviation_of_items
    total = all_items.map do |item|
      ((item.unit_price) - average_item_price)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1))
  end

  def golden_items
    standard_deviation = standard_deviation_of_items
    all_items.find_all do |item|
      item.unit_price > (standard_deviation*2)
    end
  end

  def average_invoices_per_merchant
    (invoice_count/merchant_count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    total = all_merchants.map do |merchant|
      ((merchant_invoice_count(merchant.id)) - average_invoices_per_merchant)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1)).round(2)
  end

  def top_merchants_by_invoice_count
    standard_deviation = average_invoices_per_merchant_standard_deviation
    all_merchants.find_all do |merchant|
      merchant_invoice_count(merchant.id) > ((standard_deviation *2) + average_invoices_per_merchant )
    end
  end

  def bottom_merchants_by_invoice_count
    standard_deviation = average_invoices_per_merchant_standard_deviation
    all_merchants.find_all do |merchant|
      merchant_invoice_count(merchant.id) < ((-standard_deviation *2) + average_invoices_per_merchant )
    end
  end

  def days_invoices_were_created
    @sales_engine.all_invoices.map do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def number_of_invoices_per_given_day
    invoices_per_day = Hash.new 0
    days_invoices_were_created.each do |day|
      invoices_per_day[day] += 1
    end
    invoices_per_day
  end

  def average_invoices_per_day
    invoice_count/7.0
  end

  def standard_deviation_of_invoices_per_day
    total = number_of_invoices_per_given_day.map do |day, count|
      (count - average_invoices_per_day)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1)).round(2)
  end

  def top_days_by_invoice_count
    days = number_of_invoices_per_given_day
    standard_deviation = standard_deviation_of_invoices_per_day
    average = average_invoices_per_day
    days.select do |day, count|
      day if count > (standard_deviation + average)
    end.keys
  end

  def invoice_status(status_input)
    count = @sales_engine.all_invoices.find_all do |invoice|
      invoice.status == status_input
    end
    ((count.length.to_f/invoice_count)*100).round(2)
  end

end
