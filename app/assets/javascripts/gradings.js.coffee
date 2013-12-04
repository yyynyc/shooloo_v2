jQuery ->
  if $('#grading_domain_id').parent('form').attr('action') == 'create'
    $('#grading_domain_id').parent().hide()
  domains = $('#grading_domain_id').html()  
  doit = ->
    level = $('#grading_level_id :selected').text()
    console.log(level)
    escaped_level = level.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')    
    options = $(domains).filter("optgroup[label=#{escaped_level}]").html()
    if options
      $('#grading_domain_id').html(options)
      $('#grading_domain_id').prepend("<option></option>")
      $('#grading_domain_id').parent().show()  
    else
      $('#grading_domain_id').html($("<option>").attr('selected',true)) 
      $('#grading_domain_id').parent().hide()
  doit()
  $('#grading_level_id').change doit

  if $('#grading_standard_id').parent('form').attr('action') == 'create'
    $('#grading_standard_id').parent().hide()
  standards = $('#grading_standard_id').html()
  doitagain = ->
    domain = $('#grading_domain_id :selected').text() 
    escaped_domain = domain.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')   
    choices = $(standards).filter("optgroup[label=#{escaped_domain}]").html()
    if choices      
      $('#grading_standard_id').html(choices)
      $('#grading_standard_id').prepend("<option></option>")
      $('#grading_standard_id').parent().show()      
    else     
      $('#grading_standard_id').html($("<option>").attr('selected',true)) 
      $('#grading_standard_id').parent().hide()
  doitagain()
  $('#grading_domain_id').change doitagain

