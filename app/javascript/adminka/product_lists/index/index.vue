<script>
  import ModalPopup from './modal-new-list'
  import List from '../_components/list'

  export default {
    components: { ModalPopup, List },
    methods: {
      showModalPopup(){
        this.showCreateNewPopup = true;
      },

      handleNewListCreated(){
        this.showCreateNewPopup = false;
        this.loadListsFromServer();
      },

      handleNewListCanceled(){
        this.showCreateNewPopup = false;
      },

      loadListsFromServer(){
        this.isListLoading = true;
        $.ajax({
          method: 'GET',
          url: Routes.adminka_product_lists_path(),
          dataType: 'json',
          success: (lists) => {
            this.lists = lists;
            this.isListLoading = false;
          }
        });
      }
    },

    data: function () {
      return {
        showCreateNewPopup: false,
        isListLoading: false,
        lists: []
      }
    },

    mounted(){
      this.loadListsFromServer();
    }
  }
</script>

<template>
  <div>
    <div class="row">
      <div class="col">
        <h1>{{ t('adminka.product_lists.page_title') }}</h1>
      </div>
    </div>
    <div class="row">
      <div class="col">
      <a @click="showModalPopup()" href="javascript:void(0)" class='btn btn-success'>{{ t('adminka.product_lists.button_new') }}</a>
      </div>
    </div>

    <modal-popup
      v-if="showCreateNewPopup"
      @created="handleNewListCreated"
      @canceled="handleNewListCanceled"
    />

    <div class="row">
      <list
        :lists="lists"
        :isLoading="isListLoading"
        @deleted="loadListsFromServer()"
        @toggleDone="loadListsFromServer()"
      />
    </div>

  </div>
</template>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
