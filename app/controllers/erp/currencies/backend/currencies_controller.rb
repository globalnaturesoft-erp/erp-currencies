require_dependency "erp/backend/backend_controller"

module Erp
  module Currencies
    module Backend
      class CurrenciesController < Erp::Backend::BackendController
        before_action :set_currency, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_currencies, only: [:delete_all, :archive_all, :unarchive_all]
    
        # GET /currencies
        def index
        end
        
        # POST /currencies/list
        def list
          @currencies = Currency.search(params).paginate(:page => params[:page], :per_page => 10)
          
          render layout: nil
        end
    
        # GET /currencies/new
        def new
          @currency = Currency.new
        end
    
        # GET /currencies/1/edit
        def edit
        end
    
        # POST /currencies
        def create
          @currency = Currency.new(currency_params)
          @currency.creator = current_user
    
          if @currency.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @currency.name,
                value: @currency.id
              }
            else
              redirect_to erp_currencies.edit_backend_currency_path(@currency), notice: t('.success')
            end
          else
            render :new        
          end
        end
    
        # PATCH/PUT /currencies/1
        def update
          if @currency.update(currency_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @currency.name,
                value: @currency.id
              }              
            else
              redirect_to erp_currencies.edit_backend_currency_path(@currency), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /currencies/1
        def destroy
          @currency.destroy

          respond_to do |format|
            format.html { redirect_to erp_currencies.backend_currencies_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @currency.archive
          respond_to do |format|
            format.html { redirect_to erp_currencies.backend_currencies_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @currency.unarchive
          respond_to do |format|
            format.html { redirect_to erp_currencies.backend_currencies_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /currencies/delete_all?ids=1,2,3
        def delete_all         
          @currencies.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /currencies/archive_all?ids=1,2,3
        def archive_all         
          @currencies.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /currencies/unarchive_all?ids=1,2,3
        def unarchive_all
          @currencies.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Currency.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_currency
            @currency = Currency.find(params[:id])
          end
          
          def set_currencies
            @currencies = Currency.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def currency_params
            params.fetch(:currency, {}).permit(:name, :code)
          end
      end
    end
  end
end
