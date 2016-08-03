require './test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'bigdecimal'


class SalesAnalystTest < MiniTest::Test
  def setup
    @sa = SalesAnalyst.new(SalesEngine.new({
                                             :items     => "./data/items.csv",
                                             :merchants => "./data/merchants.csv",
                                             :invoices  => "./data/invoices.csv",
                                             :transactions => "./data/transactions.csv",
                                             :invoice_items => "./data/invoice_items.csv",
                                             :customers => "./data/customers.csv"
                                            }))
  end

  def test_it_has_copy_of_sales_engine
    assert_instance_of SalesEngine, @sa.sales_engine
  end

  def test_it_can_find_how_many_items_a_merchant_has
    assert_equal 1, @sa.merchant_items_count(12334141)
  end

  def test_it_can_find_how_many_invoices_a_merchant_has
    assert_equal 0, @sa.merchant_invoice_count(12334141)
  end

  def test_it_knows_the_number_of_merchants
    assert_equal 475, @sa.merchant_count
  end

  def test_item_count
    assert_equal 9, @sa.item_count
  end

  def test_invoice_count
    assert_equal 19, @sa.invoice_count
  end

  def test_merchant_items
    # assert_equal 3, @sa.merchant_items(12334185).count
  end

  def test_average_items_per_merchant
    assert_equal 0.02, @sa.average_items_per_merchant
  end

  def test_it_can_access_all_the_merchants
    assert_instance_of Merchant, @sa.all_merchants.last
  end

  def test_it_can_access_all_the_items
    assert_instance_of Item, @sa.all_items.last
  end
  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.2, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 5, @sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334141)
  end

  def test_average_average_price_per_merchant
    assert_equal "some bullshit", "some bullshit"
  end

  def test_it_has_returns_an_average_item_price
    assert_instance_of BigDecimal, @sa.average_item_price
  end

  def test_standard_deviation_of_items
    assert_equal 128.89235694088995, @sa.standard_deviation_of_items
  end

  def test_golden_items
    assert_instance_of Item, @sa.golden_items.last
  end

  def test_it_returns_the_average_invoices_per_merchant
    assert_equal 0.04, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 0.22, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 17, @sa.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal [], @sa.bottom_merchants_by_invoice_count
  end

  def test_we_can_get_all_days_from_invoices
    assert_equal "Saturday", @sa.days_invoices_were_created[0]
  end

  def test_it_returns_a_hash_of_the_counts_of_each_day
    assert_equal true, @sa.number_of_invoices_per_given_day.is_a?(Hash)
  end

  def test_average_invoices_per_day
    assert_equal 2.7142857142857144, @sa.average_invoices_per_day
  end

  def test_standard_deviation_of_invoices_per_day
    assert_equal 1.89, @sa.standard_deviation_of_invoices_per_day
  end

  def test_top_days_by_invoice_count
    assert_equal ["Saturday", "Friday"], @sa.top_days_by_invoice_count
  end

  def test_it_returns_invoice_status_percentage
    assert_equal 47.37, @sa.invoice_status(:pending)
  end

  def test_it_gets_all_invoice_items_by_date
    assert_instance_of Invoice, @sa.find_invoices_by_date(Time.parse("2012-11-23")).first
    assert_instance_of Invoice, @sa.find_invoices_by_date(Time.parse("2012-11-23")).last
  end

  def test_it_adds_unit_prices_from_invoice_items
    assert_instance_of BigDecimal, @sa.total_revenue_by_date(Time.parse("2012-11-23"))
  end

  def test_it_returns_top_earners_by_input
    assert_instance_of Merchant, @sa.top_revenue_earners(2).first
    assert_equal 2, @sa.top_revenue_earners(2).length
  end
end
