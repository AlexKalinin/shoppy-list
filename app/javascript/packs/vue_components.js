import Vue from 'vue'
import ProductsListApp from '../adminka/products_lists'

Vue.mixin({
  methods: {
    //proxy to rails translations
    t(key){
      return I18n.t(key);
    },

    //proxy to rails routes
    r(){
      return Routes;
    }
  }
});

document.addEventListener('turbolinks:load', function(){
  if($('body').attr('data-location') === 'adminka/product_lists#index'){
    new Vue(ProductsListApp).$mount('products-list-app');
    console.log('Mounted products-list-app');
  }
});