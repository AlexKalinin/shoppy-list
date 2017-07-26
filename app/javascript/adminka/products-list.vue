<template>
  <div>
    <div class="row">
      <h1>{{ t('adminka.product_lists.page_title') }}</h1>
    </div>
    <div class="row">
      <a @click="showModalPopup()" href="javascript:void(0)" class='btn btn-success'>{{ t('adminka.product_lists.button_new') }}</a>
    </div>

  </div>
</template>

<script>
  export default {
    methods: {
      showModalPopup(){
        console.log('showing popup');
      }
    },

    data: function () {
      return {
        message: "Hello Vue!"
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
