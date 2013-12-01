jQuery ->
  if $('#assignment_domain_id').parent('form').attr('action') == 'create'
    $('#assignment_domain_id').parent().hide()
  domains = $('#assignment_domain_id').html()  
  doit = ->
    level = $('#assignment_level_id :selected').text()
    console.log(level)
    escaped_level = level.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')    
    options = $(domains).filter("optgroup[label=#{escaped_level}]").html()
    if options
      $('#assignment_domain_id').html(options)
      $('#assignment_domain_id').prepend("<option></option>")
      $('#assignment_domain_id').parent().show()  
    else
      $('#assignment_domain_id').html($("<option>").attr('selected',true)) 
      $('#assignment_domain_id').parent().hide()
  doit()
  $('#assignment_level_id').change doit

  if $('#assignment_standard_id').parent('form').attr('action') == 'create'
    $('#assignment_standard_id').parent().hide()
  standards = $('#assignment_standard_id').html()
  doitagain = ->
    domain = $('#assignment_domain_id :selected').text() 
    escaped_domain = domain.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')   
    choices = $(standards).filter("optgroup[label=#{escaped_domain}]").html()
    if choices      
      $('#assignment_standard_id').html(choices)
      $('#assignment_standard_id').prepend("<option></option>")
      $('#assignment_standard_id').parent().show()      
    else     
      $('#assignment_standard_id').html($("<option>").attr('selected',true)) 
      $('#assignment_standard_id').parent().hide()
  doitagain()
  $('#assignment_domain_id').change doitagain