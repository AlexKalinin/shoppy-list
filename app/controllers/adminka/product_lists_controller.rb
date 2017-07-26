module Adminka
  class ProductListsController < BasicController
    before_action :set_product_list, only: [:show, :edit, :update, :destroy, :remove_product, :new_product, :create_product]

    def index
      @product_lists = ProductList.all
    end

    def show
    end

    def new
      @product_list = ProductList.new
    end

    def edit
    end

    def create
      ProductList.create!(product_list_params)
      render json: true
    end

    def update
      respond_to do |format|
        if @product_list.update(product_list_params)
          format.html {redirect_to @product_list, notice: 'Product list was successfully updated.'}
          format.json {render :show, status: :ok, location: @product_list}
        else
          format.html {render :edit}
          format.json {render json: @product_list.errors, status: :unprocessable_entity}
        end
      end
    end

    def destroy
      @product_list.destroy
      respond_to do |format|
        format.html {redirect_to product_lists_url, notice: 'Product list was successfully destroyed.'}
        format.json {head :no_content}
      end
    end

    def remove_product
      @product_list.products.delete(params[:product_id])
      redirect_to product_list_path(@product_list), notice: 'Product was successfully removed from this list.'
    end

    def create_product
      @product_list.products << Product.find(params[:product_list][:products])
      redirect_to product_list_path(@product_list), notice: 'Product was successfully added this list.'
    end

    def new_product
    end

    def is_busy
      render json: !!ProductList.find_by(name: params[:name])
    end

    private
      def set_product_list
        @product_list = ProductList.find(params[:id])
      end


      def product_list_params
        params.require(:product_list).permit(:name)
      end
  end
end
