require './test/test_helper'
require_relative "../lib/customer"
# require_relative "../lib/merchant_repository"
require_relative "../lib/sales_engine"

class CustomerTest < MiniTest::Test
  def setup
    # @se = SalesEngine.from_csv({
    #                              :items     => "./data/items.csv",
    #                              :merchants => "./data/merchants.csv",
    #                             })
    @customer = Customer.new({ :id         => "1",
                               :first_name => "Joey",
                               :last_name  => "Ondricka",
                               :created_at => "2012-03-27 14:54:09 UTC",
                               :updated_at => "2012-03-27 14:54:09 UTC"})

  end

  def test_it_holds_an_id
    assert_equal 1, @customer.id
  end

  def test_it_holds_a_first_name
    assert_equal "Joey", @customer.first_name
  end

  def test_it_holds_a_last_name
    assert_equal "Ondricka", @customer.last_name
  end

  def test_it_holds_a_parsed_created_at
    assert_equal true, @customer.created_at.is_a?(Time)
  end

  def test_it_holdss_a_parsed_updated_at
    assert_equal true, @customer.updated_at.is_a?(Time)
  end
end
