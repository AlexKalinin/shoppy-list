<script>
  export default {
    name: 'color-item',

    props: ['color', 'isSelected'],

    methods: {
      colorToCssClass(){
        let klass = 'product-color product-color-' + this.color;
        if(this.isSelected){
          klass += ' product-color-selected'
        }
        return klass;
      }
    },

    data: function () {
      return {
      }
    },

    mounted(){

    },
  }
</script>

<template>
  <div :class="colorToCssClass()" @click="$emit('click')"></div>
</template>

<style lang="scss" scoped>
  .product-color{
    border-radius: 3px;
    width: 30px;
    height: 30px;
  }
  .product-color-orange{ background-color: #ffa800; }
  .product-color-gray{ background-color: #6a6a6a; }
  .product-color-red{ background-color: #991212; }
  .product-color-green{ background-color: #15b921; }
  .product-color-blue{ background-color: #2121cd; }
  .product-color-selected{
    /*border: 3px solid #353535 */
    border: 3px solid #ffffff;
    outline: 3px solid #ff9517;
    border-radius: 7px;
  }
</style>
