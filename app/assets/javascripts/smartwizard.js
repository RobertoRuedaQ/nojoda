$(document).on('turbolinks:load',function () {
var target_step = parseInt($('#application').attr('wizard-selected'))
      $(function() {
        $('#application').smartWizard({
          selected: target_step,
          autoAdjustHeight: false,
          backButtonSupport: false,
          useURLhash: false,
          showStepURLhash: false,
          enableFinishButton: false,
          hideButtonsOnDisabled: true,
          keyNavigation: false,
          toolbarSettings: {
                toolbarPosition: 'none', // none, top, bottom, both
          },
          anchorSettings: {
            enableAllAnchors: false
          }
        })
	      .on('showStep', function(e, anchorObject, stepNumber, stepDirection) {

          if(stepNumber != get_step_from_url() && location.href.split('/')[3] != 'mains'){
            show_full_page_lumni_spinner()
            window.location.replace('/' + location.href.split('/')[3] + '/' + location.href.split('/')[4] + '/edit?step=' + stepNumber);
          }
        })

        if($('#application').length > 0){
          $('#application').smartWizard('selected',$('#application').attr('wizard-selected'))
          $('#application .sw-toolbar').appendTo($('#application .sw-container'));

          if(get_step_from_url() != ''){
            $('[href="#application-step-' + (parseInt(get_step_from_url()) + 1) + '"]').click()
          }
        }

      });
})


function get_step_from_url(){
  temp_step = 'none'
  if(location.href.split('step=').length > 1){
    temp_step = location.href.split('step=').pop().split('&')[0]
  }
  return temp_step
}