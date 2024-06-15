# frozen_string_literal: true

module Api
  module V1
    class DealsController < Api::V1::ApiController
      before_action :set_deal, only: [:show, :update, :destroy]

      def index
        @deals = Deal.includes(:items).all
        render json: DealSerializer.new(@deals), status: :ok
      end

      def show
        render json: DealSerializer.new(@deal), status: :ok
      end

      def create
        @deal = Deal.new(deal_params)
        
        if @deal.save
          create_deal_items
          render json: DealSerializer.new(@deal), status: :created
        else
          render json: @deal.errors, status: :unprocessable_entity
        end
      end

      def update
        if @deal.update(deal_params)
          update_deal_items
          render json: DealSerializer.new(@deal), status: :ok
        else
          render json: @deal.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @deal.destroy
        head :no_content
      end

      private

      def set_deal
        @deal = Deal.find(params[:id])
      end

      def deal_params
        params.require(:deal).permit(:name, :description, :start_date, :end_date, :overall_discount, item_ids: [])
      end

      def create_deal_items
        params[:deal][:deal_items_attributes].each do |deal_item|
          @deal.deal_items.create(item_id: deal_item["item_id"], deal_price: deal_item["deal_price"])
        end if params[:deal][:deal_items_attributes].present?
      end

      def update_deal_items
        @deal.deal_items.destroy_all
        create_deal_items
      end
    end
  end
end
