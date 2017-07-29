module Adminka
  class ProductsController < BasicController
    check_authorization except: [:index, :is_name_taken]
    load_and_authorize_resource param_method: :product_list_params

    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def index
      @products = Product.all

      if (filter_product_list_id = params.dig(:filter, :except_product_list_id))
        excluding_ids = ProductList.find(filter_product_list_id).product_ids
        @products = @products.excluded_by_ids(excluding_ids)
      end
    end

    def show
    end

    def new
      @product = Product.new
    end

    def edit
    end

    def create
      @product = Product.create!(product_params)
      if (list_id = params[:productListId]) && (amount = params[:amount])
        ProductListsProduct.create!(product: @product, amount: amount, product_list_id: list_id)
      end
      render json: true
    end

    def update
      @product.update!(product_params)
      if (list_id = params[:productListId]) && (amount = params[:amount])
        ProductListsProduct.find_by(product: @product, product_list_id: list_id).update_attribute(:amount, amount)
      end
      render json: true
    end

    def destroy
      respond_to do |format|
        format.html {redirect_to products_url, notice: 'Product was successfully destroyed.'}
        format.json {head :no_content}
      end
    end

    def is_name_taken
      render json: Product.name_taken(params[:name], current_user)
    end

    private
      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:name, :description, :unit, :color, :price).merge({author: current_user})
      end
  end
end