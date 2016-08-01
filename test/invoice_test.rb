require './test/test_helper'
require_relative "../lib/invoice"
# require_relative "../lib/invoice_repository"
require_relative "../lib/sales_engine"

class InvoiceTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv({
                                 :items         => "./data/items.csv",
                                 :merchants     => "./data/merchants.csv",
                                 :invoices      => "./data/invoices.csv",
                                 :transactions  => "./data/transactions.csv",
                                 :invoice_items => "./data/invoice_items.csv",
                                 :customers     => "./data/customers.csv"
                                })
    @invoice = Invoice.new({ :id           => "1",
                             :customer_id  => "1",
                             :merchant_id  => "12335938",
                             :status       => "pending",
                             :created_at   => "2009-02-07",
                             :updated_at   => "2014-03-15"})

  end

  def test_it_holds_an_id
    assert_equal 1, @invoice.id
  end

  def test_it_holds_customer_id
    assert_equal 1, @invoice.customer_id
  end

  def test_it_holds_merchant_id
    assert_equal 12335938, @invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal :pending, @invoice.status
  end

  def test_it_holds_a_parsed_created_at
    assert_equal true, @invoice.created_at.is_a?(Time)
  end

  def test_it_holds_a_parsed_updated_at
    assert_equal true, @invoice.updated_at.is_a?(Time)
  end

  def test_it_finds_by_merchant_id
    assert_instance_of Merchant, @se.invoices.find_merchant_by_id(12335955)
  end

  def test_it_returns_array_of_items
    assert_instance_of Item, @se.invoices.find_by_id(3).items.last
  end
  def test_it_returns_array_of_transactions
    assert_instance_of Transaction, @se.invoices.find_by_id(19).transactions.last
  end
  def test_it_returns_a_customer
    assert_instance_of Customer, @se.customers.find_by_id(2)
  end
end
