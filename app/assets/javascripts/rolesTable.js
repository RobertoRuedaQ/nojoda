$(document).on('turbolinks:load',function () {
	iniciateRoleTableFuncionality()


})




function iniciateRoleTableFuncionality(){
	$("[id$='create_frontcheck'],[id$='update_frontcheck'],[id$='destroy_frontcheck']").on('change',function(){
		tempId = '#' + this.id
		partialId = tempId.split('_frontcheck')[0]
		targetId = partialId + '_with_approval_frontcheck'
		if($(tempId).prop("checked") == true){

			roleModel = getRawId(tempId)
			createRole(profileId(),roleModel[0],roleModel[1])

			uncheckRole($(targetId))
			$(partialId + '_with_approval_').val(false)
			tempViewId = partialId.split(partialId.split('_')[partialId.split('_').length - 1])[0] + 'view_frontcheck'
			checkRole($(tempViewId))
			$(tempViewId.split('frontcheck')[0]).val(true)
			$(partialId + '_approver_').attr('disabled',true);
			$(partialId + '_approver_').val('');
			removeErrorMessage($(partialId + '_approver_')[0],'list')
			$(partialId + '_approver_').selectpicker('refresh');

		}else{
			roleModel = getRawId(tempId)
			destroyRole(profileId(),roleModel[0],roleModel[1])
		}
	})

	$("[id$='create_with_approval_frontcheck'],[id$='update_with_approval_frontcheck'],[id$='destroy_with_approval_frontcheck']").on('change',function(){


		tempId = '#' + this.id
		$('#save-approver').attr('target-check',tempId)
		$('#cancel-approver').attr('target-check',tempId)
		if($(tempId).prop("checked") == true){
			$('#approver-modal').modal('show')
		}else{
			tempId = $('#save-approver').attr('target-check')
			partialId = tempId.split('_with_approval_frontcheck')[0]
			partialId = partialId.replace('brole','roles')
			targetId = partialId + '_frontcheck'
			approverId = partialId + '_approver_'
			adjustWithApprovalActivation(tempId,approverId)
			$(approverId).attr('disabled',true);
			$(approverId).attr('required',false);
			$(approverId).val('');
			$(approverId).selectpicker('refresh');

		}


	})

	$('#save-approver').on('click',function(){
		if($('#roles_modal_').val() == ""){
			$('#roles_modal_')[0].checkValidity()
		}else{
			$('#approver-modal').modal('hide')
			tempId = $('#save-approver').attr('target-check')
			partialId = tempId.split('_with_approval_frontcheck')[0]
			partialId = partialId.replace('brole','roles')
			targetId = partialId + '_frontcheck'
			approverId = partialId + '_approver_'


			$(approverId).removeAttr('disabled');
			$(approverId).attr('required',true);
			$(approverId).val($('#roles_modal_').val());
			$(approverId).selectpicker('refresh');


			adjustWithApprovalActivation(tempId,approverId)
			$('#roles_modal_').val("")
			$('#roles_modal_').selectpicker('refresh');



		}
	})


	$('#cancel-approver').on('click',function(){
		$('#approver-modal').modal('hide')
	})

	$('#approver-modal').on('hide.bs.modal', function (e) {
		if($('#roles_modal_').val() == ""){
			element = $($('#cancel-approver').attr('target-check'))
			element.prop("checked", false);
		}
	})


	$("[id$='view_frontcheck']").on('change',function(){
		options = ['create','create_with_approval','update','update_with_approval','destroy','destroy_with_approval']
		approvers = ['create_approver', 'update_approver','destroy_approver']
		tempId = '#' + this.id
		partialId = tempId.split('_frontcheck')[0]
		if($(tempId).prop("checked") == false){
			roleModel = getRawId(tempId)
			destroyRole(profileId(),roleModel[0],roleModel[1]);

			tempActionId = partialId.split(partialId.split('_')[partialId.split('_').length - 1])[0]
			for(i=0;i<options.length;i++){

				destroyRole(profileId(),options[i],roleModel[1])

				uncheckRole($(tempActionId + options[i] + '_frontcheck'))
				$(tempActionId + options[i] + '_').val(false)
			}
			for(i=0;i<approvers.length;i++){
				$(tempActionId + approvers[i] + '_').attr('disabled',true);
				$(tempActionId + approvers[i] + '_').val('');
				removeErrorMessage($(partialId.split('view')[0] + approvers[i] + '_')[0],'list')
				$(tempActionId + approvers[i] + '_').selectpicker('refresh');

			}
		}else{
			roleModel = getRawId(tempId)
			createRole(profileId(),roleModel[0],roleModel[1])
		}
	})	


}


function checkRole(element){
	element.prop("checked", true);
	targetId = profileId()
	roleModel = getRawId(element[0].id)
	createRole(targetId,roleModel[0],roleModel[1])
}
function uncheckRole(element){
	element.prop("checked", false);
	targetId = profileId()
	roleModel = getRawId(element[0].id)
	destroyRole(targetId,roleModel[0],roleModel[1])
}


function destroyRole(profile_id,role,model){
	console.log('roles: ' + role)
	params = 'profile_id=' + profile_id + '&role=' + role + '&model=' + model 

	$.post('/roles/destroy_role',params)
	  .done(function() {

		if (role.includes('with_approval')){
			partialRole = role.split('_with_approval')[0]			
			approverId = '#roles_' + model + '_' + partialRole +'_approver_'
			$(approverId).attr('disabled',true);
			$(approverId).attr('required',false);
			$(approverId).val('');
			$(approverId).selectpicker('refresh');
	  	}

	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });
}

function createRole(profile_id,role,model){
	params = 'profile_id=' + profile_id + '&role=' + role + '&model=' + model

	$.post('/roles/create_role',params)
	  .done(function() {
	  	if(role.includes('with_approval')){
			partialRole = role.split('_with_approval')[0]			
			approverId = '#roles_' + model + '_' + partialRole +'_approver_'
	  		createApprover(profile_id,role,model,approverId)
	  	}
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });
}

function getRawId(targetId){
	cleanId = targetId.split('_frontcheck')[0]
	cleanId = cleanId.split('#')[cleanId.split('#').length - 1]
	cleanId = cleanId.split('brole_')[cleanId.split('brole_').length - 1]
	if(cleanId.includes('_with_approval')){
		tempAction = cleanId.split('_with_approval')[0]
		action = tempAction.split('_')[tempAction.split('_').length -1] + '_with_approval'
		model = cleanId.split('_' + action)[0]
	}else{
		action = cleanId.split('_')[cleanId.split('_').length -1]
		model = cleanId.split('_' + action)[0]
	}
	return [action, model]
}

function profileId(){
	return $('#role_id').attr('role-id')
}


function adjustWithApprovalActivation(tempId,approverId){

	partialId = tempId.split('_with_approval_frontcheck')[0]
	targetId = partialId + '_frontcheck'

	if($(tempId).prop("checked") == true){
		
		roleModel = getRawId(tempId)
		createRole(profileId(),roleModel[0],roleModel[1])

		uncheckRole($(targetId))
		$(partialId + '_').val(false)
		tempViewId = partialId.split(partialId.split('_')[partialId.split('_').length - 1])[0] + 'view_frontcheck'
		checkRole($(tempViewId))
		$(tempViewId.split('frontcheck')[0]).val(true)

	}else{
		roleModel = getRawId(tempId)
		destroyRole(profileId(),roleModel[0],roleModel[1]);

		$(partialId + '_approver_').attr('disabled',true);
		$(partialId + '_approver_').val('');
		removeErrorMessage($(partialId + '_approver_')[0],'list')
		$(partialId + '_approver_').selectpicker('refresh');

	}


}

function createApprover(profile_id,role,model,approverId){

	params = 'profile_id=' + profile_id + '&role=' + role + '&model=' + model + '&approver=' + $(approverId).val()
	$.post('/roles/asign_approver',params)
	  .done(function() {
	  })
	  .fail(function() {
	  	location.reload();
	  })
	  .always(function() {
	  });
}

