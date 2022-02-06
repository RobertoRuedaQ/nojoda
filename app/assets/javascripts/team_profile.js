$(document).on('turbolinks:load',function () {
	target_tab = $(location).attr('hash')
	controller = $(location).attr('pathname').split('/')[1]
	

	if( target_tab != '' && controller == 'team_profiles'){
		target_id = document.location.href.split('/')[4]
		if(target_tab == '#user-templates-info'){
			loadTeamProfileTemplateTable(target_id)
		}
		if(target_tab == '#user-edit-info'){
			loadTeamProfileRoleTable(target_id)
		}
	}

	$('.form-template-tab').on('click',function(){
		if($('#loader-team-profile-template').length > 0){
			target_form_profile_id = this.id.split('-').pop()
			loadTeamProfileTemplateTable(target_form_profile_id)
		}
	})

	$('.form-template-role-tab').on('click',function(){
		if($('#loader-team-profile-role-table').length > 0){
			target_form_profile_id = this.id.split('-').pop()
			loadTeamProfileRoleTable(target_form_profile_id)
		}
	})
})


function loadTeamProfileTemplateTable(target_form_profile_id){
			
	$.post('/team_profiles/' + target_form_profile_id + '/template_table')
	  .done(function() {
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });
}


function loadTeamProfileRoleTable(target_form_profile_id){
			
	$.post('/team_profiles/' + target_form_profile_id + '/role_table')
	  .done(function() {
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });
}