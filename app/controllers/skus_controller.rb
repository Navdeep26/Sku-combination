class SkusController < ApplicationController
	skip_before_action :verify_authenticity_token  

  def index
  end

  def read_csv
      render "read_csv"
    end

    def create
      if params[:sku].present? && params[:csv_file].present?
        option1 = []
        option2 = []
        option3 = []
        check = "yes"
        @final_value = []
        @sku = params[:sku].to_i + 1
        require 'csv'
        CSV.foreach(params[:csv_file].path, headers: true) do |row, index|
          row.each_with_index do |key, value|
            option1 << key[1]  if value == 0 && key[1].present?
            option2 << key[1]  if value == 1 && key[1].present?
            option3 << key[1]  if value == 2 && key[1].present?
          end
        end
        option1.each do |option1_value|
          option2.each do |option2_value|
            option3.each do |option3_value|
              @final_value << "#{option1_value}, #{option2_value}, #{option3_value}"
            end
          end
        end

        @final_value.present? && @final_value.each_with_index do |value, val|
          sku_demomination = SkuDenomination.new
          sku_demomination.sku_denomination = @sku + val
          sku_demomination.sku_combination = "#{value}"
          if sku_demomination.save
            check = "yes"
          else
            check = "no"
          end
        end
        if check == "yes"
          EmailerMailer.send_email_to_current_user(@current_user,@final_value.length).deliver_now
        end
        render "show_csv_data"
      else
        render :plain => "params value is not present"
      end
    end
end
