class ExchangesController < ApplicationController
    def index 
        @exchanges = current_user.exchanges
        
    end

    def new 
        @exchange = current_user.exchanges.new
    end

    def create 
        @exchange = current_user.exchanges.new(params_exchanges)
        if @exchange.save
          @coupon = @exchange.create_coupon(serial_number: [*'a'..'z',*'0'..'9',*'A'..'Z'].sample(10).join )
          redirect_to exchanges_path, notice: "已成功兌換成功，您的兌換券序號為 " + @coupon.serial_number
        else
          @company = Exchange.find_by(company_name: @exchange.company_name)
          if @company.present?
            @year = @company.created_at.to_s.split[0].split("-")[0]
            @month = @company.created_at.to_s.split[0].split("-")[1]
            @day = @company.created_at.to_s.split[0].split("-")[2]
            redirect_to exchanges_path, notice: "您已於 " + @year +"年" + @month +"月" + @day +"日兌換過"
          else
            redirect_to exchanges_path, notice:"您所填的統一編號有誤，請確認後重新輸入!"
          end

        end
    end

   
    private
    def params_exchanges 
        params.require(:exchange).permit(:company_name, :company_number, :phone_number, :user_id)
    end

end