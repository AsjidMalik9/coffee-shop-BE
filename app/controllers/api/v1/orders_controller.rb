# frozen_string_literal: true

module Api
  module V1
    class OrdersController < Api::V1::ApiController
      before_action :set_order, only: :update

      def index
        @orders = OrderSerializer.new(@user.orders.includes(:items).all)

        render json: @orders, status: :ok
      end

      def create
        @order = @user.orders.new(order_params)

        if @order.save
          render json: OrderSerializer.new(@order), status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def update
        if @order.update(order_params)
          render json: OrderSerializer.new(@order), status: :ok
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      private

      def set_order
        @order = Order.find(params[:id])
      end

      def order_params
        params.require(:order).permit(:user_id, :status, order_items_attributes: %i[item_id quantity])
      end
    end
  end
end
