import Vue from 'vue'
import ProductListsIndexApp from '../adminka/product_lists/index'
import ProductListsEditApp from '../adminka/product_lists/edit'

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
  let currentPageLocation = $('body').attr('data-location');

  //products_list LIST
  if(currentPageLocation === 'adminka/product_lists#index'){
    new Vue(ProductListsIndexApp).$mount('product-lists-index-app');
    console.log('Mounted products-list-index-app'); //TODO: remove this debug message
  }

  //products_list EDIT
  if(currentPageLocation === 'adminka/product_lists#edit'){
    new Vue(ProductListsEditApp).$mount('product-lists-edit-app');
    console.log('Mounted edit-products-list-app'); //TODO: remove this debug message
  }
});