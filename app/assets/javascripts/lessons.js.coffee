window.ccss = (ccss)->
  if $('#'+ccss+'_domain_id').parent('form').attr('action') == 'create'
    $('#'+ccss+'_domain_id').parents('.control-group').hide()
  domains = $('#'+ccss+'_domain_id').html()  
  doit = ->
    level = $('#'+ccss+'_level_id :selected').text()
    escaped_level = level.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')    
    options = $(domains).filter("optgroup[label=#{escaped_level}]").html()
    if options
      $('#'+ccss+'_domain_id').html(options)
      $('#'+ccss+'_domain_id').prepend("<option></option>")
      $('#'+ccss+'_domain_id').parents('.control-group').show()  
    else
      $('#'+ccss+'_domain_id').html($("<option>").attr('selected',true)) 
      $('#'+ccss+'_domain_id').parents('.control-group').hide()
  doit()
  $('#'+ccss+'_level_id').change doit


  if $('#'+ccss+'_standard_id').parent('form').attr('action') == 'create'
    $('#'+ccss+'_standard_id').parents('.control-group').hide()
  standards = $('#'+ccss+'_standard_id').html()
  doitagain = ->
    domain = $('#'+ccss+'_domain_id :selected').text() 
    escaped_domain = domain.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')   
    choices = $(standards).filter("optgroup[label=#{escaped_domain}]").html()
    if choices      
      $('#'+ccss+'_standard_id').html(choices)
      $('#'+ccss+'_standard_id').prepend("<option></option>")
      $('#'+ccss+'_standard_id').parents('.control-group').show()      
    else     
      $('#'+ccss+'_standard_id').html($("<option>").attr('selected',true)) 
      $('#'+ccss+'_standard_id').parents('.control-group').hide()
  doitagain()
  $('#'+ccss+'_domain_id').change doitagain

  if $('#'+ccss+'_hstandard_id').parent('form').attr('action') == 'create'
    $('#'+ccss+'_hstandard_id').parents('.control-group').hide()
  hstandards = $('#'+ccss+'_hstandard_id').html()
  doitagain = ->
    standard = $('#'+ccss+'_standard_id :selected').text() 
    escaped_standard = standard.replace(/([ #;&,.+*~\':"!^$[\]()=><+-|\/@])/g, '\\$1')
    alternatives = $(hstandards).filter("optgroup[label=#{escaped_standard}]").html()
    if alternatives      
      $('#'+ccss+'_hstandard_id').html(alternatives)
      $('#'+ccss+'_hstandard_id').prepend("<option></option>")
      $('#'+ccss+'_hstandard_id').parents('.control-group').show()      
    else     
      $('#'+ccss+'_hstandard_id').html($("<option>").attr('selected',true)) 
      $('#'+ccss+'_hstandard_id').parents('.control-group').hide()
  doitagain()
  $('#'+ccss+'_standard_id').change doitagain

jQuery ->
  window.ccss('lesson')
