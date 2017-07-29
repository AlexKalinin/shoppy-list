<script>
  import ProductFormComponent from './product-form-component'

  export default {
    name: 'modal-edit-product',

    components: { ProductFormComponent },

    props: [
      'productListId',
      'productData',       //product should have `id` field.
    ],

    methods: {
      handleFormChanged(data){
        this.isFormValid = data.isValid;
        this.product = data.product;
        this.amount = data.amount;
      },

      handleUpdateButton(){
        if(!this.isFormValid){
          return;
        }

        $.ajax({
          url: Routes.adminka_product_path(this.productData.id),
          method: 'PUT',
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

        $('#modal-edit-product').modal('hide');
        $('#modal-edit-product').on('hidden.bs.modal',(e) => {
          this.$emit('submitted');
        });
      },

      handleCanceled(){
        $('#modal-edit-product').modal('hide');
        $('#modal-edit-product').on('hidden.bs.modal',(e) => {
          this.$emit('canceled');
        });
      },
    },

    data: function () {
      return {
        isFormValid: false,
        product: {},
      }
    },

    mounted(){
      $('#modal-edit-product').modal('show');
      $('#modal-edit-product').on('shown.bs.modal',(e) => {
        $(e.target).find('input[type="text"]').focus();
      });
    },
  }
</script>

<template>
  <div
    id="modal-edit-product"
    class="modal fade" data-keyboard="false" data-backdrop="static"
    @keyup.esc="handleCanceled" >

      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ t('adminka.product_list.ui_modal_edit_product.header.title') }}</h5>
          </div>

          <div class="modal-body">
            <product-form-component
              @changed="handleFormChanged"
              :productData="productData"
              isUpdating="true"
            />
          </div>

          <div class="modal-footer">
            <button type="button" class="btn btn-primary" :disabled="!isFormValid" @click="handleUpdateButton">{{ t('adminka.product_list.ui_modal_edit_product.footer.btn_update') }}</button>
            <button type="button" class="btn btn-secondary" @click="handleCanceled">{{ t('adminka.product_list.ui_modal_edit_product.footer.btn_cancel') }}</button>
          </div>
        </div>
      </div>
  </div>
</template>

<style lang="scss" scoped>

</style>
