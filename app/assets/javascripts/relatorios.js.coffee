# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



jQuery ->
  contas = $('#relatorios_conta_id').html()
  $('#relatorios_centro_de_custo_id').change ->
    centro_de_custo = $('#relatorios_centro_de_custo_id :selected').text()
    options = $(contas).filter("optgroup[label='#{centro_de_custo}']").html()
    if options
       $('relatorios_conta_id').html(options)
    else
      $('relatorios_conta_id').empty()




