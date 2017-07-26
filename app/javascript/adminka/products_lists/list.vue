<template>
  <div class="col-12">
    <table  v-if="!isLoading && isAnyInList()" class="table table-striped table-hover">
      <thead>
      <tr>
        <th class="list-name">{{ t('adminka.product_lists.list.table_titles.list_name') }}</th>
        <th class="products-nubmer">{{ t('adminka.product_lists.list.table_titles.products_number') }}</th>
        <th class="products-sum">{{ t('adminka.product_lists.list.table_titles.products_sum') }}</th>
        <th class="actions">{{ t('adminka.product_lists.list.table_titles.actions') }}</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="list in lists">
        <td>{{ list.name }}</td>
        <td>{{ list.products_number }}</td>
        <td>{{ list.products_sum }}</td>
        <td class="actions" >
          <a href="javascript:void(0)" @click="toggleDone(list)">
            <i v-if="list.is_done" class="fa fa-check-square-o" />
            <i v-else="" class="fa fa-check-square" />
          </a>
          <a href="javascript:void(0)" @click="handleRemove(list)"><i class="fa fa-trash" /></a>
        </td>
      </tr>

      <tr v-if="isLoading">
        <td colspan="4">{{ t('adminka.product_lists.list.loading') }}</td>
      </tr>

      <tr v-if="!isLoading && !isAnyInList()">
        <td colspan="4">{{ t('adminka.product_lists.list.empty') }}</td>
      </tr>

      </tbody>
    </table>
  </div>

</template>

<script>
  export default {
    name: 'list',

    methods: {
      isAnyInList(){
        return this.lists.length > 0
      },

      toggleDone(list){
        console.log('toggleDone() clicked', list);
      },

      handleRemove(list){
        console.log('handleRemove() clicked', list);
      }

    },

    watch: {

    },

    data: function () {
      return {
        lists: [],
        isLoading: true
      }
    },

    mounted(){
      this.isLoading = true;
      $.ajax({
        method: 'GET',
        url: Routes.adminka_product_lists_path(),
        dataType: 'json',
        success: (data) => {
          this.lists = data;
          this.isLoading = false;
        }
      });
    },
  }
</script>

<style scoped>
</style>
