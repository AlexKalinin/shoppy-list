<script>
  import ColorItem from './color-item'
  import ProductAmountComponent from './product-amount-component'

  export default {
    name: 'product-form-component',

    components: { ColorItem, ProductAmountComponent },

    props: [
      'productData',  //undefined if this is new product
      'isUpdating',   // undefined|false if this is new product
    ],

    methods: {

      registerFormChange(){
        this.$emit('changed', {
          isValid: this.isFormValid,
          product: {
            name: this.name,
            unit: this.unit,
            price: this.price,
            description: this.description,
            color: this.color
          },
          amount: this.amount,
        });
      },

      handleAmountChange(data){
        this.isAmountValid = data.isValid;
        this.amount = data.amount;
        this.checkFormValidity();
        this.registerFormChange();
      },

      localizedUnitName(unit){
        return this.t(`adminka.product_list.ui_modal_new_product.creation_form.units.${unit}`);
      },

      isColorSelected(hue){
        return this.color === hue;
      },

      selectColor(hue){
        this.color = hue;
      },

      checkNameValidity(){
        switch(true){
          case !this.name || this.name.length === 0 :
            this.invalidNameMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.name.empty');
            this.isNameValid = false;
            break;
          case this.name === 'kill' :
            this.invalidNameMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.name.kill');
            this.isNameValid = false;
            break;
          default:
            this.invalidNameMessage = '';
            this.isNameValid = true;
        }

        if(!this.isNameValid){ return; }

        $.ajax({
          url: Routes.is_name_taken_adminka_products_path(),
          method: 'GET',
          data: { name: this.name },
          dataType: 'json',
          success: (is_product_name_taken) => {
            if(this.isUpdating && this.name === this.productData.name){
              this.isNameValid = true;
              this.invalidNameMessage = '';
              return;
            }
            if(is_product_name_taken){
              this.isNameValid = false;
              this.invalidNameMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.name.taken');
            }else{
              if(this.warnMessage === this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.name.taken')){
                this.isNameValid = true;
                this.invalidNameMessage = '';
              }
            }
          }
        });
      },

      checkPriceValidity(){
        let price = '' + (this.price || '');

        switch(true){
          case !price :
            this.isPriceValid = false;
            this.invalidPriceMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.price.empty');
            break;
          case !!price.match(/[^0-9\.]+/) :
            this.isPriceValid = false;
            this.invalidPriceMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.price.number_only');
            break;
          case (price.match(/\.+/g) || []).length > 1 :
            this.isPriceValid = false;
            this.invalidPriceMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.price.only_one_dot');
            break;
          case parseFloat(price) <= 0 :
            this.isPriceValid = false;
            this.invalidPriceMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.price.positive');
            break;
          default:
            this.isPriceValid = true;
            this.invalidPriceMessage = '';
        }
      },

      checkDescriptionValidity(){
        switch(true){
          case !this.description :
            this.isDescriptionValid = false;
            this.invalidDescriptionMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.description.empty');
            break;
          case this.description.length > 150 :
            this.isDescriptionValid = false;
            this.invalidDescriptionMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.description.too_big');
            break;
          default:
            this.isDescriptionValid = true;
            this.invalidDescriptionMessage = '';
        }
      },

      checkFormValidity(){
        this.isFormValid = this.isNameValid && this.isPriceValid && this.isDescriptionValid && this.isAmountValid;
      }
    },



    data: function () {
      return {
        units: ['kg', 'pieces', 'liter'],
        colors: 'orange gray red green blue'.split(' '),
        isNameValid: false,
        isPriceValid: true,
        isDescriptionValid: false,
        isFormValid: false,
        isAmountValid: true,

        invalidNameMessage: '',
        invalidPriceMessage: '',
        invalidDescriptionMessage: '',

        name: '',
        unit: 'kg',
        price: '100',
        description: '',
        color: 'orange',
        amount: '1',
      }
    },

    created(){
      if(this.productData && !$.isEmptyObject(this.productData)){
        this.name = this.productData.name;
        this.unit = this.productData.unit;
        this.price = this.productData.price;
        this.description = this.productData.description;
        this.color = this.productData.color;
        this.amount = this.productData.amount;
        console.log('this.productData', this.productData, 'this.amount', this.amount, 'this.productData.amount', this.productData.amount)
      }
    },

    watch: {
      'name': function(){
        this.checkNameValidity();
        this.checkFormValidity();
        this.registerFormChange();
      },

      'price': function(){
        this.checkPriceValidity();
        this.checkFormValidity();
        this.registerFormChange();
      },

      'description': function(){
        this.checkDescriptionValidity();
        this.checkFormValidity();
        this.registerFormChange();
      },
      'unit': function(){
        this.registerFormChange();
      },
      'color': function(){
        this.registerFormChange();
      }
    }
  }
</script>

<template>
  <div class="product-creation-form">
    <!-- Name -->
    <div class="form-group">
      <label for="productCreationFormNameInput">{{ t('adminka.product_list.ui_modal_new_product.creation_form.name_field.label') }}</label>
      <input
        v-model='name'
        :placeholder="t('adminka.product_list.ui_modal_new_product.creation_form.name_field.placeholder')"
        type="text" class="form-control" id="productCreationFormNameInput" aria-describedby="productCreationFormNameInputValidations" >
      <small v-if='!isNameValid' id="productCreationFormNameInputValidations" class="form-text text-warning">{{ invalidNameMessage }}</small>
    </div>

    <!-- Unit -->
    <div class="form-group">
      <label for="productCreationFormUnitSelect">{{ t('adminka.product_list.ui_modal_new_product.creation_form.unit') }}</label>
      <select v-model="unit" class="form-control" id="productCreationFormUnitSelect">
        <option v-for="unitItem in units" :value="unitItem">{{ localizedUnitName(unitItem) }}</option>
      </select>
    </div>

    <!-- Price -->
    <label for="productCreationFormPriceInput">{{ t('adminka.product_list.ui_modal_new_product.creation_form.price.label') }}</label>
    <div class="input-group">
      <input v-model='price' type="text" class="form-control" id="productCreationFormPriceInput" aria-describedby="productCreationFormPriceInputLabel">
      <span class="input-group-addon" id="productCreationFormPriceInputLabel">
        {{ t('adminka.product_list.ui_modal_new_product.creation_form.price.curency') }}
      </span>
    </div>
    <small v-if='!isPriceValid' class="form-text text-warning">{{ invalidPriceMessage }}</small>


    <!-- Description -->
    <div class="form-group mt-2">
      <label for="productCreationFormDescriptionInput">{{ t('adminka.product_list.ui_modal_new_product.creation_form.description.label') }}</label>
      <textarea
        v-model="description"
        :placeholder="t('adminka.product_list.ui_modal_new_product.creation_form.description.placeholder')"
        class="form-control" id="productCreationFormDescriptionInput" rows="3">
      </textarea>
    </div>
    <small v-if='!isDescriptionValid' class="form-text text-warning">{{ invalidDescriptionMessage }}</small>

    <div class="mt-3">
      <color-item
        class="product-color-item"
        v-for="hue in colors"
        @click="selectColor(hue)"
        :color="hue"
        :isSelected="isColorSelected(hue)"
        :key="hue"
      ></color-item>
    </div>

    <div class="mb-3">
      <hr>
      <product-amount-component
        @changed="handleAmountChange"
        :defaultAmount="amount"
      />
    </div>

  </div>
</template>

<style lang="scss" scoped>
  .product-color-item{
    display: inline-block;
    margin-right: 10px;
  }
</style>
