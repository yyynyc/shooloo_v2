jQuery ->
  if $('#lesson_domain_id').parent('form').attr('action') == 'create'
    $('#lesson_domain_id').parent().hide()
  domains = $('#lesson_domain_id').html()  
  doit = ->
    level = $('#lesson_level_id :selected').text()
    console.log(level)
    escaped_level = level.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')    
    options = $(domains).filter("optgroup[label=#{escaped_level}]").html()
    if options
      $('#lesson_domain_id').html(options)
      $('#lesson_domain_id').prepend("<option></option>")
      $('#lesson_domain_id').parent().show()  
    else
      $('#lesson_domain_id').html($("<option>").attr('selected',true)) 
      $('#lesson_domain_id').parent().hide()
  doit()
  $('#lesson_level_id').change doit

  if $('#lesson_standard_id').parent('form').attr('action') == 'create'
    $('#lesson_standard_id').parent().hide()
  standards = $('#lesson_standard_id').html()
  doitagain = ->
    domain = $('#lesson_domain_id :selected').text() 
    escaped_domain = domain.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')   
    choices = $(standards).filter("optgroup[label=#{escaped_domain}]").html()
    if choices      
      $('#lesson_standard_id').html(choices)
      $('#lesson_standard_id').prepend("<option></option>")
      $('#lesson_standard_id').parent().show()      
    else     
      $('#lesson_standard_id').html($("<option>").attr('selected',true)) 
      $('#lesson_standard_id').parent().hide()
  doitagain()
  $('#lesson_domain_id').change doitagain
