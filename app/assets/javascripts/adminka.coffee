#= require rails-ujs
#= require turbolinks
#= require jquery
#= require tether
#= require bootstrap-sprockets
#= require i18n
#= require i18n/translations
#= require toastr
#= require js-routes

#= require adminka/lib/UI

# JS library to pass locales from rails to frontend
I18n.locale = 'ru'

$.ajaxSetup({ headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') } })

$(document).on 'ajaxError', (event, response) ->
  UI.error(I18n.t('adminka.common.ajax_error'))