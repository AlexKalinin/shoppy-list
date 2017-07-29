module Adminka
  class ProductListsController < BasicController
    check_authorization except: [:index, :is_name_taken]
    load_and_authorize_resource param_method: :product_list_params

    before_action :set_product_list,
                  only: [:edit, :update, :destroy, :remove_product, :add_product, :products, :toggle_done ]

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

    def add_product
      product = Product.find(params[:product_id])
      authorize! :update, @product_list
      authorize! :read, product
      @product_list.products << product unless @product_list.product_ids.include? product.id
      render json: true
    end

    def is_name_taken
      render json: ProductList.name_taken(params[:name], current_user)
    end

    def products
      @product_lists_products = @product_list.product_lists_products
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
