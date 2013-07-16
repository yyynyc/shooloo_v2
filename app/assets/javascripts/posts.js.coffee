jQuery ->
  $('#post_domain_id').parent().hide()
  domains = $('#post_domain_id').html()  
  $('#post_level_id').change ->
    level = $('#post_level_id :selected').text()
    console.log(level)
    escaped_level = level.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')    
    options = $(domains).filter("optgroup[label=#{escaped_level}]").html()
    if options
      $('#post_domain_id').html(options)
      $('#post_domain_id').prepend("<option></option>")
      $('#post_domain_id').parent().show()  
    else
      $('#post_domain_id').html($("<option>").attr('selected',true)) 
      $('#post_domain_id').parent().hide()

  $('#post_standard_id').parent().hide()
  standards = $('#post_standard_id').html()
  $('#post_domain_id').change ->
    domain = $('#post_domain_id :selected').text() 
    escaped_domain = domain.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')   
    choices = $(standards).filter("optgroup[label=#{escaped_domain}]").html()
    if choices      
      $('#post_standard_id').html(choices)
      $('#post_standard_id').prepend("<option></option>")
      $('#post_standard_id').parent().show()      
    else     
      $('#post_standard_id').html($("<option>").attr('selected',true)) 
      $('#post_standard_id').parent().hide()
