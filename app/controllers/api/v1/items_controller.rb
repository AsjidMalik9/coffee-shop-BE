# frozen_string_literal: true

module Api
  module V1
    class ItemsController < Api::V1::ApiController
      before_action :set_item, only: [:show, :update, :destroy]

      def index
        items = ItemSerializer.new(Item.includes(:deal_items).all)
        render json: items, status: :ok
      end

      def show
        render json: ItemSerializer.new(@item), status: :ok
      end

      def create
        item = Item.new(item_params)
        if item.save
          render json: ItemSerializer.new(item), status: :created
        else
          render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @item.update(item_params)
          render json: ItemSerializer.new(@item), status: :ok
        else
          render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @item.destroy
        head :no_content
      end

      private

      def set_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:name, :price, :tax_rate, :discount_type, :discount_amount)
      end
    end
  end
end
