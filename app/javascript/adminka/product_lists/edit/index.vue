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
      },

      validateName(){
        if(this.productListName === this.originalProductListName){
          this.invalidNameWarnMessage = '';
          this.isNameValid = true;
          this.isNameChanged = false;
          return;
        }
        if(this.productListName && this.productListName.length > 0){
          this.isNameValid = true;
          this.invalidNameWarnMessage = '';

          //is this name is already taken?
          $.ajax({
            url: Routes.is_name_taken_adminka_product_lists_path(),
            method: 'GET',
            data: { name: this.productListName },
            dataType: 'json',
            success: (is_name_taken) => {
              if(is_name_taken){
                this.isNameValid = false;
                this.invalidNameWarnMessage = this.t('adminka.product_lists.ui_modal_new.warnings.already_taken')
              }else{
                if(this.invalidNameWarnMessage === this.t('adminka.product_lists.ui_modal_new.warnings.already_taken')){
                  this.invalidNameWarnMessage = '';
                  this.isNameValid = true;
                }
              }
            }
          });
        }else{
          this.isNameValid = false;
          this.invalidNameWarnMessage = this.t('adminka.product_lists.ui_modal_new.warnings.incorrect_name');
        }
      },

      handleUpdateName(){
        if(!this.isNameValid){
          return;
        }

        $.ajax({
          url: Routes.adminka_product_list_path(this.productListId),
          method: 'PUT',
          dataType: 'json',
          data: { product_list: { name: this.productListName } },
          success: () => {
            UI.success(this.t('adminka.product_list.flash.product_list_name_updated'))
            this.originalProductListName = this.productListName;
            this.isNameChanged = false;
          }
        })
      },
      handleResetName(){
        this.productListName = this.originalProductListName;
        this.invalidNameWarnMessage = '';
        this.isNameValid = true;
        this.isNameChanged = false;
      },
      handleModalNewProductSubmitted(){
        this.showNewProductWindow = false;
        this.loadProductsFromServer();
      },
      handleModalNewProductCanceled(){
        this.showNewProductWindow = false;
      },
    },

    data: function () {
      return {
        isNameChanged: false,
        originalProductListName: '',
        productListId: -1,
        productListName: '',
        showNewProductWindow: false,
        isProductsLoading: false,
        products: [],
        isNameValid: true,
        invalidNameWarnMessage: '',
      }
    },

    mounted(){
      this.originalProductListName = this.productListName;
      this.loadProductsFromServer();
    },

    watch: {
      'productListName': function(val){
        this.isNameChanged = true;
        this.validateName();
      }
    },


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
          <input type="text" class="form-control" aria-describedby="nameWarningText" :placeholder="t('adminka.product_list.name_input.placeholder')" v-model="productListName">
          <span class="input-group-btn">
            <button
              v-if="isNameChanged"
              @click="handleResetName()"
              class="btn btn-secondary"
              type="button" >
              x
            </button>
          </span>

          <span class="input-group-btn">
            <button
                    @click="handleUpdateName()"
                    :disabled='!isNameValid || !isNameChanged'
                    class="btn btn-primary"
                    type="button" >
                {{ t('adminka.product_list.name_input.btn_update') }}
            </button>
          </span>
        </div>
        <small v-if="!isNameValid" id="nameWarningText" class="form-text text-warning">{{invalidNameWarnMessage}}</small>
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

    <modal-new-product
      v-if="showNewProductWindow"
      :productListId="productListId"
      @submitted="handleModalNewProductSubmitted"
      @canceled="handleModalNewProductCanceled"
    />

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
