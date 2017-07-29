<script>
  import ProductFormComponent from './product-form-component'

  export default {
    name: 'modal-new-product-creation-form',

    components: { ProductFormComponent },

    props: ['productListId'],

    methods: {
      handleFormChanged(data){
        if(data.isValid){
          this.isFormValid = true;
          this.product = data.product;
          this.amount = data.amount;
        }
      },

      handleCreateButton(){
        if(!this.isFormValid){
          return;
        }

        $.ajax({
          url: Routes.adminka_products_path(),
          method: 'POST',
          dataType: 'json',
          data: {
            product: this.product,
            productListId: this.productListId,
            amount: this.amount
          },
          success: () => {
            this.$emit('created');
          }
        });
      },

      handleCancelButton(){
        this.$emit('canceled');
      },
    },



    data: function () {
      return {
        isFormValid: false,
        product: {},
        amount: 1,
      }
    },

    mounted(){

    },

    watch: { }
  }
</script>

<template>
  <div class="product-creation-form">

    <product-form-component
      @changed="handleFormChanged"
    />

    <div class="modal-footer">
      <button type="button" class="btn btn-success" :disabled="!isFormValid" @click="handleCreateButton">{{ t('adminka.product_list.ui_modal_new_product.footer.btn_create') }}</button>
      <button type="button" class="btn btn-secondary" @click="handleCancelButton">{{ t('adminka.product_list.ui_modal_new_product.footer.btn_cancel') }}</button>
    </div>

  </div>
</template>

<style lang="scss" scoped>
  .product-creation-form{
    .product-color-item{
      display: inline-block;
      margin-right: 10px;
    }
  }
</style>
