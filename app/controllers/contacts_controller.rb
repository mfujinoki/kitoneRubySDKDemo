class ContactsController < ApplicationController
  require 'kintone'


  def new
  end
  def create
    @query = Query.new(query_params)

    @query.save

    # Use token authentication
    api = Kintone::Api.new("devxorudc.cybozu.com", "rBoD1vaqme5y5ezC38MVWdpoUAilIUYP4Rs8OwIO")

    # Record register(single record)
    # Use Hash
    app = 103
    record = {"Customer" => {"value" => query_params[:company_name]},
              "client_name" => {"value" => query_params[:client_name]},
              "QType" => {"value" => query_params[:contact_type]},
              "Detail" => {"value" => query_params[:details]}
              }
    api.record.register(app, record) # => {"id" => "100", "revision" => "1"}

  end
  private
  def query_params
    params.require(:query).permit(:company_name, :client_name, :contact_type,:details)
  end
end
