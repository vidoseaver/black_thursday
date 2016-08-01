require_relative "../lib/customer"
# require_relative "../lib/item"
require "csv"
require 'pry'

class CustomerRepository
attr_reader :all

  def initialize(data_path, sales_engine=nil)
    @sales_engine = sales_engine
    @all = []
    csv_loader(data_path)
    customer_maker
  end

  def csv_loader(data_path)
    @csv = CSV.open data_path, headers:true, header_converters: :symbol
  end

  def customer_maker
    @all = @csv.map do |row|
      Customer.new(row, self)
    end
  end

  def find_by_id(id_input)
    @all.find do |instance|
      instance.id == id_input
    end
  end

  def find_all_by_first_name(first_name_fragment)
    @all.find_all do |instance|
      instance.first_name.downcase.include?(first_name_fragment.to_s.downcase)
    end
  end

  def find_all_by_last_name(last_name_fragment)
    @all.find_all do |instance|
      instance.last_name.downcase.include?(last_name_fragment.to_s.downcase)
    end
  end

  def inspect
  end

end
