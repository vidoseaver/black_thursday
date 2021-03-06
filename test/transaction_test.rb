require './test/test_helper'
require_relative '../lib/transaction'
require 'bigdecimal'

class TransactionTest < MiniTest::Test
    def setup
      @se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices  => "./data/invoices.csv",
        :transactions => "./data/transactions.csv",
        :invoice_items => "./data/invoice_items.csv",
        :customers => "./data/customers.csv"
      })

      @first_transaction = Transaction.new({
            :id                             => "1",
            :invoice_id                     => "2179",
            :credit_card_number             => "4068631943231473",
            :credit_card_expiration_date    => "2179",
            :result                         => "success",
            :created_at                     => "2012-02-26 20:56:56 UTC	",
            :updated_at                     => "2012-02-26 20:56:56 UTC",
            }, self)
    end

    def test_it_holds_id
      assert_equal 1, @first_transaction.id
    end

    def test_it_holds_returns_only_integers
      assert_equal 1, @first_transaction.id
    end

    def test_it_holds_a_invoice_id
      assert_equal 2179, @first_transaction.invoice_id
    end

    def test_it_holds_credit_card_number
      assert_equal 4068631943231473, @first_transaction.credit_card_number
    end

    def test_it_holds_credit_card_expiration_date
      assert_equal "2179", @first_transaction.credit_card_expiration_date
    end

    def test_it_holds_a_result
      assert_equal "success", @first_transaction.result
    end

    def test_it_holds_created_at
      assert_equal true, @first_transaction.created_at.is_a?(Time)
    end

    def test_it_holds_updated_at
      assert_equal true, @first_transaction.updated_at.is_a?(Time)
    end

    def test_it_returns_self
      assert_equal true, @first_transaction.parent.is_a?(TransactionTest)
    end

    def test_it_gets_all_items_by_invoice_id
      assert_instance_of Invoice, @se.transactions.find_by_id(40).invoice
    end


end
