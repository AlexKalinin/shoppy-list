<script>
  import Products from './products'
  import ModalNewProduct from './modal-new-product'

  export default {
    components: { Products, ModalNewProduct },
    methods: {
      showCreateNewProductPopup(){
        this.showNewProductWindow = true;
      },
      loadProductsFromServer(){
        this.isProductsLoading = true;
        $.ajax({
          url: Routes.products_of_adminka_product_list_path(this.productListId),
          method: 'GET',
          dataType: 'json',
          success: (data) => {
            this.products = data;
            this.isProductsLoading = false;
          }
        })
      }
    },

    data: function () {
      return {
        productListId: -1,
        productListName: '',
        showNewProductWindow: false,
        isProductsLoading: false,
        products: [],
      }
    },

    mounted(){
      this.loadProductsFromServer();
    }
  }
</script>

<template>
  <div>
    <div class="row mt-3">
      <div class="col">
        <h1>{{ t('adminka.product_list.page_title') }}</h1>
      </div>
    </div>
    <div class="row mt-3">
      <div class="col">
        <div class="input-group">
          <input type="text" class="form-control" :placeholder="t('adminka.product_list.name_input.placeholder')" :value="productListName">
          <span class="input-group-btn">
            <button class="btn btn-secondary" type="button">{{ t('adminka.product_list.name_input.btn_update') }}</button>
          </span>
        </div>
      </div>
    </div>
    <div class="row mt-3">
      <div class="col">
        <h3>{{ t('adminka.product_list.products_title') }}</h3>
      </div>
    </div>
    <div class="row  mt-3">
      <div class="col">
        <a @click="showCreateNewProductPopup()" href="javascript:void(0)" class='btn btn-success'>{{ t('adminka.product_list.button_new') }}</a>
      </div>
    </div>

    <modal-new-product v-if="showNewProductWindow" />

    <div class="row mt-3">
      <div class="col">
        <products
          :products="products"
          :isLoading="isProductsLoading"
          @deleted="loadProductsFromServer()"
          :productListId="productListId"
        />
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>
