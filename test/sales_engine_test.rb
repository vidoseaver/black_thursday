require './test/test_helper'
require "./lib/sales_engine"
require 'pry'


class SalesEngineTest < MiniTest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv",
      :transactions => "./data/transactions.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv"
    })
  end

  def test_the_it_makes_merchant_repositories
    assert_equal true, se.merchants.is_a?(MerchantRepository)
    assert_equal false, se.merchants.is_a?(ItemRepository)
  end

  def test_the_it_makes_item_repositories
    assert_equal false, se.items.is_a?(MerchantRepository)
    assert_equal true, se.items.is_a?(ItemRepository)
  end

  def test_it_can_return_instance_of_merchant
    mr = se.merchants
    merchant = mr.find_by_name("sparetimecrocheter")
    assert_instance_of Merchant, merchant
    assert_equal 12335961, merchant.id
  end

  def test_it_can_return_instance_of_item
    ir = se.items
    item = ir.find_by_name("Disney scrabble frames")
    assert_instance_of Item, item
    assert_equal 263395721, item.id
  end

  def test_it_gets_the_items
    assert_instance_of Item, @se.find_items_by_merchant_id(12334141)[0]
  end

  def test_it_gets_the_merchant
    assert_instance_of Merchant, @se.find_merchant_by_id(12334141)
  end

  def test_merchant_count
    assert_equal 475, @se.merchant_count
  end
  def test_item_count
    assert_equal 9, @se.item_count
  end

  def test_it_has_all_the_merchants
    assert_instance_of Merchant, @se.all_merchants.last
  end

  def test_it_has_all_the_merchants
    assert_instance_of Item, @se.all_items.last
  end

  def test_it_gets_the_invoices
    assert_instance_of Invoice, @se.find_invoices_by_merchant_id(12335938)[0]
  end

  def test_it_gets_all_invoices
    assert_equal 19, @se.all_invoices.length
  end

  def test_it_gets_all_items_by_invoice_id
    assert_instance_of Item, @se.find_items_by_invoice_id(3).last
  end

  def test_it_gets_all_items_by_invoice_id
    assert_instance_of Invoice, @se.find_invoice_by_invoice_id(14)
  end

  def test_it_can_find_customers_by_invoice_id
    invoice = [@se.invoices.find_by_id(1)]
    assert_instance_of Customer, @se.find_customers_by_invoices(invoice).last
  end

  def test_find_invoices_by_customer_id
    assert_instance_of Invoice, @se.find_invoices_by_customer_id(1)[0]
  end

  def test_it_returns_an_array_of_merchants
    assert_instance_of Merchant, @se.customers.find_by_id(1).merchants[0]
  end

  def test_finds_invoice_items_by_invoice_id
    assert_instance_of InvoiceItem, @se.find_invoice_items_by_invoice_id(1).first
  end

  def test_it_gets_all_invoice_items_by_date
    assert_instance_of Invoice, @se.find_invoices_by_date(Time.parse("2012-11-23")).first
    assert_instance_of Invoice, @se.find_invoices_by_date(Time.parse("2012-11-23")).last
  end
end
