
$(document).on('turbolinks:load',function () {
	if($('#edit-origination').length > 0){
		setAllSortableOrigination()
	}


   if( $('#eligibility-criteria-funding-opportunity').length > 0 ){
		setEligibilityDropdown()
   }
   if($('[id^=open-icon]').length > 0 || $('[id^=close-icon]').length > 0){
		set_lumni_applicaiton_accordion()
   }
   if($("[id^='application-step-']").length > 0){
	   set_lumni_applicaiton_accordion()
	   $('#edit-application-modal-id').on('hidden.bs.modal',function(){
	   		$('#loader-application-modal').show()
	   		$('#edit-application-container-modal').html('')
	   })

		if (typeof $('[id^=children-application-container]')[0] != 'undefined') {
			$('[id^=sociodemographic_children_number_]').on('change',function(){
			   setHumanChildrenBehavior(this)
			})
			$('[id^=sociodemographic_children_number_]').each(function(){
			   setHumanChildrenBehavior(this)
			})
		}

	}

	$('[id^=pending_modules_application]').each(function(){
		target_modules = eval($(this).attr('modules'))
		if(target_modules.length > 0){
			params = 'application=' + this.id.split('-').pop() + '&'
			params += target_modules.map(x => "modules[]=" + x).join('&')
			lumniPost('/applications/load_target_modules',params)
		}
	})
})




function setHumanChildrenBehavior(target_element){
	target_id = target_element.id.split('_').pop()
	console.log($(target_element).val())
	if($(target_element).val() > 0){
		$('#children-application-container-' + target_id).show()
		if($('[id^=child-element-]').length == $('[id^=sociodemographic_children_number_]').val()){
			$('button[target=edit_sociodemographic_' + target_id + ']').removeAttr('disabled')
		}else{
			$('button[target=edit_sociodemographic_' + target_id + ']').attr('disabled',true)
		}
		
	}else{
		$('button[target=edit_sociodemographic_' + target_id + ']').removeAttr('disabled')
		$('#children-application-container-' + target_id).hide()
	}
}


function set_lumni_applicaiton_accordion(){
	$("[id^='collapse']").on('show.bs.collapse',function(){
		open_target = 'open-icon-' + this.id.split('collapse').pop()
		close_target = 'close-icon-' + this.id.split('collapse').pop()
		$('#' + open_target).attr('hidden',true)
		$('#' + close_target).attr('hidden',false)
	})
	$("[id^='collapse']").on('hide.bs.collapse',function(){
		open_target = 'open-icon-' + this.id.split('collapse').pop() 
		close_target = 'close-icon-' + this.id.split('collapse').pop()
		$('#' + open_target).attr('hidden',false)
		$('#' + close_target).attr('hidden',true)
	})
}











function setEligibilityDropdown(){
   	$('.legal_dropdown').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue) {
   		path = '/legal_documents/' + $(this).find("option:selected").val() + '/eligibility_criteria'
   		params = ''
   		lumniPost(path,params)
	});
}

function sortableOriginationHash(targetElement){
	Sortable.create(document.getElementById(targetElement), {	
		animation: 150,
		direction: 'vertical',
		group: targetElement,
		fallbackOnBody: true,
		store: {
			/**
			 * Get the order of elements. Called once during initialization.
			 * @param   {Sortable}  sortable
			 * @returns {Array}
			 */
			get: function (sortable) {
				var order = localStorage.getItem(sortable.options.group.name);
				return order ? order.split('|') : [];
			},

			/*
			 * Save the order of elements. Called onEnd (when the item is dropped).
			 * @param {Sortable}  sortable
			*/
			 
			set: function (sortable) {
				var order = sortable.toArray();
				localStorage.setItem(sortable.options.group.name, order.join('|'));
				var newOrder = ''
				for(i=0;i<order.length;i++){
					newOrder += 'sort[]=' + order[i].split('-').pop() + '&'
					model = order[i].split('-')[0]
				}
				newOrder += 'model=' + model


				$.post('/originations/sort',newOrder)
				  .done(function() {
				  })
				  .fail(function() {
				  	location.reload();
				  })
				  .always(function() {
				  });
				  
				}
		}
	});
}





function setSortableOrigination(targetElement){
	sortableOriginationHash(targetElement)
}

function setAllSortableOrigination(){
		targetSortable = $('.sortable_origination')
		for(i=0;i<targetSortable.length;i++){
			tempId = targetSortable[i].id
			setSortableOrigination(tempId)

		}
}