require './test/test_helper'
require_relative "../lib/merchant"
require_relative "../lib/merchant_repository"
require_relative "../lib/sales_engine"

class MerchantTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv({
                            :items         => "./data/items.csv",
                            :merchants     => "./data/merchants.csv",
                            :invoices      => "./data/invoices.csv",
                            :transactions  => "./data/transactions.csv",
                            :invoice_items => "./data/invoice_items.csv",
                            :customers     => "./data/customers.csv"})
    @merchant = Merchant.new({ :id         => "12334105",
                               :name       => "Shopin1901",
                               :created_at => "12/10/10",
                               :updated_at => "12/4/11"})

  end

  def test_it_holds_an_id
    assert_equal 12334105, @merchant.id
  end

  def test_it_holds_a_name
    assert_equal "Shopin1901", @merchant.name
  end

  def test_it_holds_a_parsed_created_at
    assert_equal true, @merchant.created_at.is_a?(Time)
  end

  def test_it_holdss_a_parsed_updated_at
    assert_equal true, @merchant.updated_at.is_a?(Time)
  end

  def test_it_can_return_self
    assert_equal nil, @merchant.parent
  end

  def test_it_gets_the_item
    assert_instance_of Item, @se.merchants.find_by_id(12334141).items[0]
  end

  def test_it_gets_the_invoice
    assert_instance_of Invoice, @se.merchants.find_invoices_by_merchant_id(12335938)[0]
  end

  def test_customers_gets_array_of_invoices
    assert_equal true, @se.merchants.find_by_id(12335311).customers.is_a?(Array)
  end

  def test_it_has_a_total
    assert_instance_of BigDecimal, @se.merchants.find_by_id(12337139).total
  end
end
