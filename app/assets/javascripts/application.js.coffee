#= require jquery
#= require jquery_ujs
#= require_tree .

#= require bootstrap-dropdown
#= require bootstrap-tooltip

$(document).ready ->
  $('#shop').focus()
  $('#main').tooltip selector: "span[rel=tooltip], a[rel=tooltip]", placement: 'bottom', html: true
