jQuery ->
  $('#post_domain_id').parent().hide()
  domains = $('#post_domain_id').html()
  console.log(domains)
  $('#post_grade_id').change ->
    grade = $('#post_grade_id :selected').text()
    escaped_grade = grade.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')    
    options = $(domains).filter("optgroup[label=#{escaped_grade}]").html()
    console.log(options)
    if options
      $('#post_domain_id').html(options)
      $('#post_domain_id').parent().show()  
    else
      $('#post_domain_id').html($("<option>").attr('selected',true)) 
      $('#post_domain_id').parent().hide()


  standards = $('#post_standard_id').html()
  $('#post_domain_id').change ->
    domain = $('#post_domain_id :selected').text() 
    escaped_domain = domain.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')   
    choices = $(standards).filter("optgroup[label=#{escaped_domain}]").html()
    if choices
      $('#post_standard_id').html(choices)      
    else
      $('#post_standard_id').html($("<option>").attr('selected',true)) 
