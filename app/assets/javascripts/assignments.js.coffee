jQuery ->
  window.ccss('assignment')

  $ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '770px'
    height: '10px'