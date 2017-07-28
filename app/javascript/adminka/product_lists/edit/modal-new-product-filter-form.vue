<script>
  export default {
    name: 'modal-new-product-filter-form',

    props: ['productListId'],

    methods: {
      handleSelectButton(){
        if(!this.isProductSelected){
          return;
        }

        $.ajax({
            url: Routes.add_product_to_adminka_product_list_path(this.productListId, this.lastSelectedProduct.id),
            method: 'POST',
            dataType: 'json',
            success: () => {
              this.$emit('selected');
            }
        });
      },

      handleCancelButton(){
        this.$emit('canceled');
      },

      loadProductsFromServer(){
        this.isProductsLoading = true;
        $.ajax({
          url: Routes.adminka_products_path(),
          method: 'GET',
          dataType: 'json',
          success: (data) => {
            for(let i = 0; i < data.length; i++){ //helping observer to watch `isSelected` field
              data[i].isSelected = false;
            }
            this.productsFromServer = data;
            this.products = $.merge([], data);
            this.isProductsLoading = false;
          }
        })
      },

      productItemCss(product){
        return 'list-group-item' + (product.isSelected ? ' active' : '');
      },

      selectProduct(product){
        this.removeProductsSelection();
        product.isSelected = true;
        this.lastSelectedProduct = product;
        this.isProductSelected = true;
      },

      removeProductsSelection(){
        this.lastSelectedProduct.isSelected = false;
        this.lastSelectedProduct = {};
        this.isProductSelected = false;
      },

      handleProductClick(product){
        this.selectProduct(product);
      },

      /**
       * imitate search engine ( TODO: use solr instead )
       */
      filterProducts(){
        this.products = this.productsFromServer.map(product => {
          let name = product.name.toLowerCase();
          let query = this.filterQuery.toLowerCase();
          let matchPriority = 3; // do not include in search results;

          if (name.includes(query)) {
            matchPriority = 2 // include in search results at bottom
          }

          if (name.substring(0, query.length) === query) {
            matchPriority = 1 // include in search results at top
          }

          return {matchPriority: matchPriority, product: product};
        }).filter(search => {
          return search.matchPriority < 3;
        }).sort((a, b) => {
          return a.matchPriority > b.matchPriority;
        }).map(search => {
          return search.product;
        });
      },

      clearFilterQuery(){
        this.filterQuery = '';
      }
    },



    data: function () {
      return {
        filterQuery: '',
        isProductsLoading: true,
        productsFromServer: [],
        products: [],
        lastSelectedProduct: {},
        isProductSelected: false,
      }
    },

    mounted(){
      this.loadProductsFromServer()
    },

    watch: {
      'filterQuery': function(query){
        this.removeProductsSelection();
        this.filterProducts();
      }
    },
  }
</script>

<template>
  <div class="product-filter-form">
    <div class="form-group row">
      <label for="product-filter-input" class="col-2 col-form-label">
        {{ t('adminka.product_list.ui_modal_new_product.filter.label') }}
      </label>
      <div class="col-10">
        <div class="input-group">
          <input
                  class="form-control" type="text" id="product-filter-input"
                  :placeholder="t('adminka.product_list.ui_modal_new_product.filter.placeholder')"
                  v-model="filterQuery">
          <span class="input-group-btn">
            <button v-if='!!filterQuery' class="btn btn-secondary" type="button" @click="clearFilterQuery()">
              x
            </button>
          </span>
        </div>
      </div>
    </div>
    <div class="product-list-container">
      <ul class="list-group">
        <li v-if="isProductsLoading" class="list-group-item text-muted">{{ t('adminka.product_list.ui_modal_new_product.filter.loading') }}</li>

        <li v-for="product in products" @click="handleProductClick(product)" :class="productItemCss(product)">{{ product.name }}</li>
      </ul>
    </div>

    <div class="modal-footer" scope="props">
      <button type="button" class="btn btn-primary" :disabled="!isProductSelected" @click="handleSelectButton">{{ t('adminka.product_list.ui_modal_new_product.footer.btn_add') }}</button>
      <button type="button" class="btn btn-secondary" @click="handleCancelButton">{{ t('adminka.product_list.ui_modal_new_product.footer.btn_cancel') }}</button>
    </div>

  </div>
</template>

<style lang="scss" scoped>
  .product-filter-form{
    .product-list-container{
      height: 300px;
      overflow: auto;
    }
  }
</style>
