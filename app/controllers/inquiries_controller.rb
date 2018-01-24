class InquiriesController < ApplicationController

  def new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save

      # Use token authentication
      api = Kintone::Api.new("devxorudc.cybozu.com", "rBoD1vaqme5y5ezC38MVWdpoUAilIUYP4Rs8OwIO")

      # Record register(single record)
      # Use Hash
      app = 103
      record = {"Customer" => {"value" => inquiry_params[:company_name]},
                "Customer_name" => {"value" => inquiry_params[:client_name]},
                "QType" => {"value" => inquiry_params[:contact_type]},
                "Detail" => {"value" => inquiry_params[:details]}
                }
      api.record.register(app, record)
      redirect_to root_path
    else
      render 'new'
    end


  end
  private
    def inquiry_params
      params.require(:inquiry).permit(:company_name, :client_name, :contact_type, :details)
    end
end
