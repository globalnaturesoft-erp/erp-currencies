module Erp
  module Currencies
    module Backend
      class PriceTermsController < Erp::Backend::BackendController
        before_action :set_price_term, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_price_terms, only: [:delete_all, :archive_all, :unarchive_all]
    
        # GET /price_terms
        def index
        end
        
        # POST /price_terms/list
        def list
          @price_terms = PriceTerm.search(params).paginate(:page => params[:page], :per_page => 10)
          
          render layout: nil
        end
    
        # GET /price_terms/new
        def new
          @price_term = PriceTerm.new
        end
    
        # GET /price_terms/1/edit
        def edit
        end
    
        # POST /price_terms
        def create
          @price_term = PriceTerm.new(price_term_params)
          @price_term.creator = current_user
    
          if @price_term.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @price_term.name,
                value: @price_term.id
              }
            else
              redirect_to erp_currencies.edit_backend_price_term_path(@price_term), notice: t('.success')
            end
          else
            render :new        
          end
        end
    
        # PATCH/PUT /price_terms/1
        def update
          if @price_term.update(price_term_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @price_term.name,
                value: @price_term.id
              }              
            else
              redirect_to erp_currencies.edit_backend_price_term_path(@price_term), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /price_terms/1
        def destroy
          @price_term.destroy

          respond_to do |format|
            format.html { redirect_to erp_currencies.backend_price_terms_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # ARCHIVE /price_terms/archive?id=1
        def archive
          @price_term.archive
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # UNARCHIVE /price_terms/archive?id=1
        def unarchive
          @price_term.unarchive
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE ALL /price_terms/delete_all?ids=1,2,3
        def delete_all         
          @price_terms.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # ARCHIVE ALL /price_terms/archive_all?ids=1,2,3
        def archive_all         
          @price_terms.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # UNARCHIVE ALL /price_terms/unarchive_all?ids=1,2,3
        def unarchive_all
          @price_terms.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # DATASELECT
        def dataselect
          respond_to do |format|
            format.json {
              render json: PriceTerm.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_price_term
            @price_term = PriceTerm.find(params[:id])
          end
          
          def set_price_terms
            @price_terms = PriceTerm.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def price_term_params
            params.fetch(:price_term, {}).permit(:name, :code, :currency_id, :use_for)
          end
      end
    end
  end
end
