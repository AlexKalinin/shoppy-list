<script>
  export default {
    name: 'modal-popup',

    methods: {
      handleCreateButton(){
        if(!this.isValid){
          return;
        }

        $.ajax({
          url: Routes.adminka_product_lists_path(),
          method: 'POST',
          data: { product_list: { name: this.name } },
          dataType: 'json',
          success: (a, b, c) => {
            $('#new-product-list').modal('hide');
            $('#new-product-list').on('hidden.bs.modal',(e) => {
              this.$emit('created');
              UI.success(this.t('adminka.product_lists.ui_modal_new.created'));
            });
          }
        });
      },

      handleCancelButton(){
        $('#new-product-list').modal('hide');
        $('#new-product-list').on('hidden.bs.modal',(e) => {
          this.$emit('canceled');
        });
      },

      validateName(){
        if(this.name && this.name.length > 0){
          this.isValid = true;
          this.warnMessage = '';

          //is this name is already taken?
          $.ajax({
            url: Routes.is_name_taken_adminka_product_lists_path(),
            method: 'GET',
            data: { name: this.name },
            dataType: 'json',
            success: (is_name_taken) => {
              if(is_name_taken){
                this.isValid = false;
                this.warnMessage = this.t('adminka.product_lists.ui_modal_new.warnings.already_taken')
              }else{
                if(this.warnMessage === this.t('adminka.product_lists.ui_modal_new.warnings.already_taken')){
                  this.warnMessage = '';
                  this.isValid = true;
                }
              }
            }
          });
        }else{
          this.isValid = false;
          this.warnMessage = this.t('adminka.product_lists.ui_modal_new.warnings.incorrect_name');
        }
      }
    },

    watch: {
      'name': function (val) {
        this.validateName();
      }
    },

    data: function () {
      return {
        name: '',
        warnMessage: '',
        isValid: false,
      }
    },

    mounted(){
      $('#new-product-list').modal('show');
      $('#new-product-list').on('shown.bs.modal',(e) => {
        $(e.target).find('input[type="text"]').focus();
      });
    },
  }
</script>

<template>
  <div id="new-product-list" class="modal fade" data-keyboard="false" @keyup.esc="handleCancelButton" @keyup.enter="handleCreateButton">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">{{ t('adminka.product_lists.ui_modal_new.title') }}</h5>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <input autofocus type="text" aria-describedby="nameWarningText" class="form-control" :placeholder="t('adminka.product_lists.ui_modal_new.placeholder')" v-model="name">
            <small v-if="!isValid" id="nameWarningText" class="form-text text-warning">{{warnMessage}}</small>
          </div>
        </div>
        <div class="modal-footer">
          <button :disabled="!isValid" type="button" class="btn btn-primary" @click="handleCreateButton">{{ t('adminka.product_lists.ui_modal_new.buttons.create') }}</button>
          <button type="button" class="btn btn-secondary" @click="handleCancelButton">{{ t('adminka.product_lists.ui_modal_new.buttons.cancel') }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>
