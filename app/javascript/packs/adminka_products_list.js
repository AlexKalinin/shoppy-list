import Vue from 'vue'
import ProductsListApp from '../adminka/products-list.vue'

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

new Vue(ProductsListApp).$mount('products-list-app');
console.log('Mounted products-list-app');

document.addEventListener('turbolinks:load', function(){

});