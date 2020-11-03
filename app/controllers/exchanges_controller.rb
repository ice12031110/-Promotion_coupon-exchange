class ExchangesController < ApplicationController
    def index 
        @exchanges = Exchange.all
    end

    def new 
        @exchange = Exchange.new
    end

    def create 
        @exchange = Exchange.new(params_exchanges)
        if @exchange.save
          @coupon = @exchange.create_coupon(serial_number: [*'a'..'z',*'0'..'9',*'A'..'Z'].sample(10).join )
          redirect_to exchanges_path, notice: "兌換成功"
        else
            render :new
        end
    end

   
    private
    def params_exchanges 
        params.require(:exchange).permit(:company_name, :company_number, :phone_number)
    end

end