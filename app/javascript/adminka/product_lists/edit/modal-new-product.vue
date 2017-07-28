<script>
  import ModalNewProductFilterForm from './modal-new-product-filter-form.vue';

  export default {
    name: 'modal-new-product',

    components: { ModalNewProductFilterForm },

    props: ['productListId'],

    methods: {
      handleSubmited(){
        $('#modal-new-product').modal('hide');
        $('#modal-new-product').on('hidden.bs.modal',(e) => {
          this.$emit('submitted');
        });
      },

      handleCanceled(){
        $('#modal-new-product').modal('hide');
        $('#modal-new-product').on('hidden.bs.modal',(e) => {
          this.$emit('canceled');
        });
      },
    },

    data: function () {
      return {
        addingSource: 'filter', // filter | creation
      }
    },

    mounted(){
      $('#modal-new-product').modal('show');
      $('#modal-new-product').on('shown.bs.modal',(e) => {
        $(e.target).find('input[type="text"]').focus();
      });
    },
  }
</script>

<template>
  <div
    id="modal-new-product"
    class="modal fade" data-keyboard="false" data-backdrop="static"
    @keyup.esc="handleCancelButton"
    @keyup.enter="handleCreateButton" >

      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ t('adminka.product_list.ui_modal_new_product.header.title') }}</h5>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <button type="button" class="btn btn-success">{{ t('adminka.product_list.ui_modal_new_product.header.btn_create_new') }}</button>
              <!--<button type="button" class="btn btn-secondary ml-2">{{ t('adminka.product_list.ui_modal_new_product.header.btn_all_products') }}</button>-->
            </div>

            <modal-new-product-filter-form
              :productListId="productListId"
              @selected="handleSubmited"
              @canceled="handleCanceled"
            />
          </div>
        </div>
      </div>
  </div>
</template>

<style lang="scss" scoped>

</style>
