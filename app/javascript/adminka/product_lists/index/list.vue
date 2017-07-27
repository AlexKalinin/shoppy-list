<script>
  export default {
    name: 'list',

    props: ['lists', 'isLoading'],

    methods: {
      isAnyInList(){
        return this.lists.length > 0
      },

      toggleDone(list){
        $.ajax({
          url: Routes.toggle_done_adminka_product_list_path(list.id),
          method: 'POST',
          dataType: 'json',
          success: () => {
            this.$emit('toggleDone');
          }
        });
      },

      handleRemove(list){
        $.ajax({
          url: Routes.adminka_product_list_path(list.id),
          method: 'DELETE',
          dataType: 'json',
          success: () => {
            this.$emit('deleted');
          }
        })
      },

      handleEdit(list){
        Turbolinks.visit(Routes.edit_adminka_product_list_path(list.id))
      },

      cssClassForList(list){
        return list.done ? 'item-marked-done' : ''
      }

    },

//    data: function () {
//      return {
//        lists: [],
//        isLoading: true
//      }
//    },

    mounted(){

    },
  }
</script>

<template>
  <div class="col mt-3">
    <table class="table table-striped table-hover table-product-list">
      <thead>
      <tr>
        <th class="col-6 align-middle">{{ t('adminka.product_lists.list.table_titles.list_name') }}</th>
        <th class="col-2 text-center align-middle">{{ t('adminka.product_lists.list.table_titles.products_number') }}</th>
        <th class="col-2 text-center align-middle">{{ t('adminka.product_lists.list.table_titles.products_sum') }}</th>
        <th class="col-2 text-center align-middle">{{ t('adminka.product_lists.list.table_titles.actions') }}</th>
      </tr>
      </thead>
      <tbody>
      <tr v-if="!isLoading && isAnyInList()" v-for="list in lists" :class="cssClassForList(list)">
        <td class="col-6">{{ list.name }}</td>
        <td class="col-2 text-center">{{ list.products_number }}</td>
        <td class="col-2 text-center">{{ list.products_sum }}</td>
        <td class="col-2 text-center" >
          <a href="javascript:void(0)" @click="handleEdit(list)"><i class="fa fa-pencil" /></a>
          <a href="javascript:void(0)" @click="toggleDone(list)">
            <i v-if="list.done" class="fa fa-check-square" />
            <i v-else="" class="fa fa-check-square-o" />
          </a>
          <a href="javascript:void(0)" @click="handleRemove(list)"><i class="fa fa-trash" /></a>
        </td>
      </tr>

      <tr v-if="isLoading">
        <td colspan="4" class="text-center">{{ t('adminka.product_lists.list.loading') }}</td>
      </tr>

      <tr v-if="!isLoading && !isAnyInList()">
        <td colspan="4" class="text-center">{{ t('adminka.product_lists.list.empty') }}</td>
      </tr>

      </tbody>
    </table>
  </div>

</template>

<style lang="scss" scoped>
  .table-product-list{
    .item-marked-done{
      &, td a{ color: #c1c1c1; }
      a{ text-decoration: line-through; }
    }
  }
</style>
