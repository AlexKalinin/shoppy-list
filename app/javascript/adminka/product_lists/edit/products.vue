<script>
  import ColorItem from './color-item';

  export default {
    name: 'products',

    props: ['products', 'isLoading', 'productListId'],

    components: { ColorItem },

    methods: {
      isEmpty(){
        return !this.products.length > 0
      },


      handleRemove(product){
        $.ajax({
          url: Routes.remove_product_from_adminka_product_list_path(this.productListId, product.id),
          method: 'DELETE',
          dataType: 'json',
          success: () => {
            this.$emit('deleted');
          }
        })
      },

      handleEdit(list){
        this.$emit('edit', list);
      },

      cssClassForList(list){
//        return list.done ? 'item-marked-done' : ''
      }

    },

//    data: function () {
//      return {
//        lists: [],
//        isLoading: true
//      }
//    },

    mounted(){

    }
  }
</script>

<template>
  <div>
    <table class="table table-striped table-hover table-products">
      <thead>
      <tr>
        <th class="col-4 align-middle" colspan="2">{{ t('adminka.product_list.products.table_titles.product') }}</th>
        <th class="col-2 text-center align-middle">{{ t('adminka.product_list.products.table_titles.amount') }}</th>
        <th class="col-2 text-center align-middle">{{ t('adminka.product_list.products.table_titles.unit') }}</th>
        <th class="col-2 text-center align-middle">{{ t('adminka.product_list.products.table_titles.price') }}</th>
        <th class="col-2 text-center align-middle">{{ t('adminka.product_list.products.table_titles.actions') }}</th>
      </tr>
      </thead>
      <tbody>
      <tr v-if="!isLoading && !isEmpty()" v-for="product in products" :class="cssClassForList(product)">
        <td class="align-middle">
          <color-item :color="product.color" :isSelected="false" />
        </td>
        <td class="col-3">
          <!--<div class="product-name-color">{{ product.color }}</div>-->
          <div class="product-name-title">{{ product.name }}</div>
          <div class="product-name-description text-muted">{{ product.description }}</div>
        </td>
        <td class="col-2 text-center">{{ product.amount }}</td>
        <td class="col-2 text-center">{{ product.unit }}</td>
        <td class="col-2 text-center">{{ product.price }}</td>
        <td class="col-2 text-center" >
          <a href="javascript:void(0)" @click="handleEdit(product)"><i class="fa fa-pencil" /></a>
          <a href="javascript:void(0)" @click="handleRemove(product)"><i class="fa fa-trash" /></a>
        </td>
      </tr>

      <tr v-if="isLoading">
        <td colspan="6" class="text-center">{{ t('adminka.product_list.products.loading') }}</td>
      </tr>

      <tr v-if="!isLoading && isEmpty()">
        <td colspan="6" class="text-center">{{ t('adminka.product_list.products.empty') }}</td>
      </tr>

      </tbody>
    </table>
  </div>

</template>

<style lang="scss" scoped>
  .table-products{
    .product-name-title {
      display: inline-block;
    }
  }
</style>
