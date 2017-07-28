<script>
  import ColorItem from './color-item'
  export default {
    name: 'modal-new-product-creation-form',

    components: { ColorItem },

    props: ['productListId'],

    methods: {
      handleCreateButton(){
        console.log('Creating');
        this.$emit('created');
      },

      handleCancelButton(){
        this.$emit('canceled');
      },

      localizedUnitName(unit){
        return this.t(`adminka.product_list.ui_modal_new_product.creation_form.units.${unit}`);
      },

      isColorSelected(color){
        return this.selectedColor === color;
      },

      selectColor(color){
        this.selectedColor = color;
        console.log('click happened');
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
        switch(true){
          case !this.price :
            this.isPriceValid = false;
            this.invalidPriceMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.price.empty');
            break;
          case !!this.price.match(/[^0-9.\-]+/) :
            this.isPriceValid = false;
            this.invalidPriceMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.price.number_only');
            break;
          case (this.price.match(/\.+/g) || []).length > 1 :
            this.isPriceValid = false;
            this.invalidPriceMessage = this.t('adminka.product_list.ui_modal_new_product.creation_form.warnings.price.only_one_dot');
            break;
          case parseFloat(this.price) <= 0 :
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
        this.isFormValid = this.isNameValid && this.isPriceValid && this.isDescriptionValid;
      }
    },



    data: function () {
      return {
        units: ['kg', 'pieces', 'liter'],
        colors: 'orange gray red green blue'.split(' '),
        isNameValid: false,
        isPriceValid: true,
        isDescriptionValid: true,
        isFormValid: false,

        invalidNameMessage: '',
        invalidPriceMessage: '',
        invalidDescriptionMessage: '',

        //fields
        name: '',
        unit: 'kg',
        price: 100,
        description: '',
        selectedColor: 'orange',
      }
    },

    mounted(){
    },

    watch: {
      'name': function(){
        this.checkNameValidity();
        this.checkFormValidity();
      },

      'price': function(){
        this.checkPriceValidity();
        this.checkFormValidity();
      },

      'description': function(){
        this.checkDescriptionValidity();
        this.checkFormValidity();
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
        <option v-for="unit in units" :value="unit">{{ localizedUnitName(unit) }}</option>
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
        v-for="color in colors"
        @click="selectColor(color)"
        :color="color"
        :isSelected="isColorSelected(color)"
      ></color-item>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-success" :disabled="!isFormValid" @click="handleCreateButton">{{ t('adminka.product_list.ui_modal_new_product.footer.btn_create') }}</button>
      <button type="button" class="btn btn-secondary" @click="handleCancelButton">{{ t('adminka.product_list.ui_modal_new_product.footer.btn_cancel') }}</button>
    </div>

  </div>
</template>

<style lang="scss" scoped>
  .product-creation-form{
    .product-color-item{
      display: inline-block;
      margin-right: 10px;
    }
  }
</style>
