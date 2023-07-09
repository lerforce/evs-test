module Api
  module First
    class PotatosController < ApplicationController

      def show
        date = params[:id].to_date
        raise InvalidDateError if (date > Date.today)
        potatos = ::Potato.where("time >= ? AND time <= ?", date.beginning_of_day, date.end_of_day)
        render json: potatos.order(time: :asc)
      end

    end
  end
end