require_relative  "../lib/item_repository"
require_relative  "../lib/merchant_repository"
require_relative  "../lib/invoice_repository"
require_relative  "../lib/transactions_repository"
require_relative  "../lib/invoice_item_repository"
require_relative  "../lib/customer_repository"
require "csv"
require "pry"

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :invoice_items,
              :customers

  def initialize(files_to_load)
      @items = ItemRepository.new(files_to_load[:items], self)
      @merchants = MerchantRepository.new(files_to_load[:merchants], self)
      @invoices = InvoiceRepository.new(files_to_load[:invoices], self)
      @transactions = TransactionRepository.new(files_to_load[:transactions], self)
      @invoice_items = InvoiceItemRepository.new(files_to_load[:invoice_items], self)
      @customers = CustomerRepository.new(files_to_load[:customers], self)

  end

  def self.from_csv(files_to_load)
      self.new(files_to_load)
  end

  def find_items_by_merchant_id(merchant_id_input)
    items.find_all_by_merchant_id(merchant_id_input)
  end

  def find_invoices_by_merchant_id(merchant_id_input)
    invoices.find_all_by_merchant_id(merchant_id_input)
  end

  def find_merchants_by_invoices(customer_id_input)
    invoices_array = find_invoices_by_customer_id(customer_id_input)
    invoices_array.map do |invoice|
      merchants.find_by_id(invoice.merchant_id)
    end
  end

  def find_merchant_by_id(merchant_id_input)
    merchants.find_by_id(merchant_id_input)
  end

  def find_items_by_invoice_id(invoice_id_input)
    invoice_items_to_iterate  = invoice_items.find_all_by_invoice_id(invoice_id_input)
    invoice_items_to_iterate.map do |invoice_item|
      items.find_by_id(invoice_item.item_id)
    end
  end

  def find_transactions_by_invoice_id(invoice_id_input)
    transactions.find_all_by_invoice_id(invoice_id_input)
  end

  def find_customer_by_invoice_id(customer_id_input)
    customers.find_by_id(customer_id_input)
  end

  def find_invoice_by_invoice_id(invoice_id_input)
    invoices.find_by_id(invoice_id_input)
  end

  def find_invoices_by_customer_id(customer_id_input)
    invoices.find_all_invoices_by_customer_id(customer_id_input)
  end

  def find_customers_by_invoices(invoices_array)
    invoices_array.map do |invoice|
      customers.find_by_id(invoice.customer_id)
    end
  end

  def merchant_count
    merchants.all.count
  end

  def item_count
    items.all.count
  end

  def invoice_count
    invoices.all.count
  end

  def all_merchants
    merchants.all
  end

  def all_items
    items.all
  end

  def all_invoices
    invoices.all
  end


end
