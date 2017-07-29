<script>
  export default {
    name: 'product-amount-component',

    props: ['defaultAmount'],

    methods: {
      checkAmountValidity(){
        let amount = '' + (this.amount || '');

        switch(true){
          case !amount :
            this.isAmountValid = false;
            this.invalidAmountMessage = this.t('adminka.product_list.ui_modal_new_product.filter.warnings.amount.empty');
            break;
          case !!amount.match(/[^0-9]+/) || parseInt(this.amount) <= 0 :
            this.isAmountValid = false;
            this.invalidAmountMessage = this.t('adminka.product_list.ui_modal_new_product.filter.warnings.amount.positive');
            break;
          default:
            this.isAmountValid = true;
            this.invalidAmountMessage = '';
        }
        this.$emit('changed', { amount: this.amount, isValid: this.isAmountValid })
      },
    },

    data: function () {
      return {
        isAmountValid: true,
        amount: 1,
        invalidAmountMessage: '',
      }
    },

    mounted(){
      this.amount = this.defaultAmount || 1;
    },

    watch: {
      'amount': function(){
        this.checkAmountValidity();
      }
    },
  }
</script>

<template>
    <div>
      <div class="form-group row">
        <label for="inputAmount" class="col-sm-3 col-form-label">{{ t('adminka.product_list.ui_modal_new_product.filter.amount.label') }}</label>
        <div class="col-sm-9">
          <input v-model='amount' type="text" class="form-control" id="inputAmount" :placeholder="t('adminka.product_list.ui_modal_new_product.filter.amount.placeholder')">
        </div>
      </div>
      <small v-if='!isAmountValid' class="form-text text-warning">{{ invalidAmountMessage }}</small>
    </div>
</template>

<style lang="scss" scoped>
</style>
