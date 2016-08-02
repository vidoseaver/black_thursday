require './test/test_helper'
require_relative "../lib/customer_repository"
require_relative "../lib/sales_engine"

require 'csv'


class CustomerRepositoryTest < MiniTest::Test
  attr_reader :customer_repository

  def setup
    @se = SalesEngine.from_csv({
            :items         => "./data/items.csv",
            :merchants     => "./data/merchants.csv",
            :invoices      => "./data/invoices.csv",
            :transactions  => "./data/transactions.csv",
            :invoice_items => "./data/invoice_items.csv",
            :customers     => "./data/customers.csv"})
            
    @customer_repository = CustomerRepository.new("./data/customers.csv")
  end

  def test_it_can_return_all
    assert_equal "Joey", customer_repository.all.first.first_name
    assert_equal "Hailey", customer_repository.all.last.first_name
  end

  def test_it_finds_by_id
    assert_equal "Joey", customer_repository.find_by_id(1).first_name
  end

  def test_it_returns_nil_if_no_ids_match
    assert_equal nil, customer_repository.find_by_id(1234567)
  end

  def test_it_finds_all_by_first_name
      assert_equal 10, customer_repository.find_all_by_first_name("Jo").length
      assert_equal "Fadel", customer_repository.find_all_by_first_name("Jo")[1].last_name
      assert_equal 3, customer_repository.find_all_by_first_name("ba").length
      assert_equal "Jenkins", customer_repository.find_all_by_first_name("ba")[0].last_name
      assert_equal 10, customer_repository.find_all_by_first_name("JO").length
  end

  def test_it_returns_empty_array_if_no_matches_to_first_name
    assert_equal [], customer_repository.find_all_by_first_name("joesghrdg")
  end

  def test_it_finds_all_by_last_name
      assert_equal 41, customer_repository.find_all_by_last_name("On").length
      assert_equal "Loyal", customer_repository.find_all_by_last_name("On")[1].first_name
      assert_equal 123, customer_repository.find_all_by_last_name("er").length
      assert_equal "Sylvester", customer_repository.find_all_by_last_name("er")[0].first_name
      assert_equal 41, customer_repository.find_all_by_last_name("ON").length
  end

  def test_it_returns_empty_array_if_no_matches_to_last_name
    assert_equal [], customer_repository.find_all_by_last_name("joesghrdg")
  end
end
