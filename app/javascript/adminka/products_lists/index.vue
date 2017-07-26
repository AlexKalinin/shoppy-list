<script>
  import ModalPopup from './modal-popup'

  export default {
    components: { ModalPopup },
    methods: {
      showModalPopup(){
        this.showCreateNewPopup = true;
      },

      handleNewListCreated(){
        this.showCreateNewPopup = false;
      },

      handleNewListCanceled(){
        this.showCreateNewPopup = false;
      }

    },

    data: function () {
      return {
        message: "Hello Vue!",
        showCreateNewPopup: false
      }
    }
  }
</script>

<template>
  <div>
    <div class="row">
      <h1>{{ t('adminka.product_lists.page_title') }}</h1>
    </div>
    <div class="row">
      <a @click="showModalPopup()" href="javascript:void(0)" class='btn btn-success'>{{ t('adminka.product_lists.button_new') }}</a>
    </div>

    <modal-popup
      v-if="showCreateNewPopup"
      @created="handleNewListCreated"
      @canceled="handleNewListCanceled"
    />

  </div>
</template>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
