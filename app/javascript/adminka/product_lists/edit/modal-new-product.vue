<script>
  import ModalNewProductFilterForm from './modal-new-product-filter-form.vue';
  import ModalNewProductCreationForm from './modal-new-product-creation-form.vue';

  export default {
    name: 'modal-new-product',

    components: { ModalNewProductFilterForm, ModalNewProductCreationForm },

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

      switchFormMode(mode){
        this.formMode = mode;
      },


    },

    data: function () {
      return {
        formMode: 'filter', // filter | creation
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
    @keyup.esc="handleCanceled" >

      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ t('adminka.product_list.ui_modal_new_product.header.title') }}</h5>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <button v-if="formMode == 'filter'" @click="switchFormMode('creation')" type="button" class="btn btn-success">{{ t('adminka.product_list.ui_modal_new_product.header.btn_create_new') }}</button>
              <button v-if="formMode == 'creation'" @click="switchFormMode('filter')" type="button" class="btn btn-primary">{{ t('adminka.product_list.ui_modal_new_product.header.btn_select_existing') }}</button>
              <!--<button type="button" class="btn btn-secondary ml-2">{{ t('adminka.product_list.ui_modal_new_product.header.btn_all_products') }}</button>-->
            </div>

            <modal-new-product-filter-form
              v-if="formMode == 'filter'"
              :productListId="productListId"
              @selected="handleSubmited"
              @canceled="handleCanceled"
            />

            <modal-new-product-creation-form
              v-if="formMode == 'creation'"
              :productListId="productListId"
              @created="handleSubmited"
              @canceled="handleCanceled"
            />
          </div>
        </div>
      </div>
  </div>
</template>

<style lang="scss" scoped>

</style>
