module Api
  module Second
    class PotatosController < ApplicationController

      def show
        date = params[:id].to_date
        raise InvalidDateError if (date > Date.today)
        render json: { value: "#{ComputeProfits.new({ date: date }).process!}€" }
      end

    end
  end
end