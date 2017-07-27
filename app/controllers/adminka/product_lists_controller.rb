module Adminka
  class ProductListsController < BasicController
    check_authorization except: [:index, :name_taken?]
    load_and_authorize_resource param_method: :product_list_params

    before_action :set_product_list,
                  only: [ :show, :edit, :update, :destroy, :remove_product,
                          :new_product, :create_product, :products, :toggle_done ]

    def index
      @product_lists = ProductList.by_user(current_user)
      respond_to do |format|
        format.html
        format.json
      end
    end

    def edit

    end

    def create
      ProductList.create!(product_list_params)
      render json: true
    end

    def update
      @product_list.update!(product_list_params)
      render json: true
    end

    def destroy
      @product_list.destroy
      respond_to do |format|
        format.html {redirect_to product_lists_url, notice: 'Product list was successfully destroyed.'}
        format.json {head :no_content}
      end
    end

    def remove_product
      authorize! :update, @product_list
      render json: @product_list.products.delete(params[:product_id])
    end

    def create_product
      @product_list.products << Product.find(params[:product_list][:products])
      redirect_to product_list_path(@product_list), notice: 'Product was successfully added this list.'
    end

    def new_product
    end

    def name_taken?
      render json: ProductList.name_taken(params[:name], current_user)
    end

    def products
      @products = @product_list.products
      respond_to :json
    end

    def toggle_done
      authorize! :update, @product_list
      render json: @product_list.update_attribute(:done, !@product_list.done)
    end

    private
      def set_product_list
        @product_list = ProductList.find(params[:id])
      end

      def product_list_params
        params.require(:product_list).permit(:name).merge({author: current_user})
      end
  end
end
