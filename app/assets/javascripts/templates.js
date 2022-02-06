$(document).on('turbolinks:load',function () {
	if($('#form-template-container').length > 0){
		setAllSortableTemplate()
		loadingTemplatesLinks()
		setAutosize();
	}
})




function sortableHashTemplate(){

return {
		direction: 'vertical',
		animation: 150,
		group: 'template-pipeline',
				// Element dragging ended
		onEnd: function (/**Event*/evt) {
			var itemEl = evt.item;  // dragged HTMLElement
			evt.to;    // target list
			evt.from;  // previous list
			evt.oldIndex;  // element's old index within old parent
			evt.newIndex;  // element's new index within new parent

			if(evt.to.id == evt.from.id){
				storeNewTemplateOrder(evt.to.id)
			}else{
				storeNewTemplateOrder(evt.to.id)
				storeNewTemplateOrder(evt.from.id)
			}
		}
	}
}


function storeNewTemplateOrder(targetElement){
	sortable = Sortable.create(document.getElementById(targetElement));
	order = sortable.toArray()


	if(order.length > 0){
		var newOrder = ''
		for(i=0;i<order.length;i++){
			newOrder += 'sort[]=' + order[i].split('-').pop() + '&'
			model = order[i].split('-')[0]
		}
		newOrder += 'row=' + targetElement.split('-').pop()



		$.post('/form_templates/sort',newOrder)
		  .done(function() {
		  })
		  .fail(function() {
		  	location.reload();
		  })
		  .always(function() {
		  });

	}

}



function setSortableTemplate(targetElement){

	Sortable.create(document.getElementById(targetElement),
		sortableHashTemplate()
		);
}

function setAllSortableTemplate(){
		targetSortable = $('.sortable_container')
		for(i=0;i<targetSortable.length;i++){
			tempId = targetSortable[i].id
			setSortableTemplate(tempId)

		}
}


function deactivateTemplateField(fieldID){
	$('#inactive-0').append($(fieldID))
}


function activateTemplateField(fieldID){
	$('#active-1').append($(fieldID))
}


function loadingActivationTemplate(){
	$('.inactivate-field').on('click',function(){
		targetField = '#' + this.id.split('buttonremove-').pop()
		$(targetField).attr('class', 'col-md-12')

		deactivateTemplateField(targetField)
		$('#moving-container-' + targetField.split('-').pop()).html('<button type="button" class="btn icon-btn btn-xs activate-field" id="buttonadd-field-container-' + targetField.split('-').pop() + '"><span class="ion ion-md-return-left"></span></button>')

		storeNewTemplateOrder('active-1')
		storeNewTemplateOrder('inactive-0')
		loadingDeactivationTemplate()
	})
}

function loadingDeactivationTemplate(){
	$('.activate-field').on('click',function(){
		targetField = '#' + this.id.split('buttonadd-').pop()
		$(targetField).attr('class',$(targetField).attr('restore-class'))

		activateTemplateField(targetField)
		$('#moving-container-' + targetField.split('-').pop()).html('<button type="button" class="btn icon-btn btn-xs inactivate-field" id="buttonremove-field-container-' + targetField.split('-').pop() + '"><span class="ion ion-ios-trash"></span></button>')
		storeNewTemplateOrder('active-1')
		storeNewTemplateOrder('inactive-0')
		loadingActivationTemplate()
	})
}


function loadingTemplatesLinks(){

		loadingActivationTemplate()
		loadingDeactivationTemplate()

		$('.template-modal').on('click',function(){
			$('#field-config').modal('show')
		})


		$('#field-config').on('hidden.bs.modal',function(){
			$('#modal-field-info').html('')
			$('#template-loader-image').attr('hidden',false)

		})
}


function attributeTypeFieldChange(){
	$('[id^=formattribute_name_]').on('change',function(){

		params = '?format=' + form_attribute_options()[$(this).val()]



		$.post('/form_attributes/update_value_field' + params)
		  .done(function() {
		  })
		  .fail(function() {
		  	location.reload();
		  })
		  .always(function() {
		  });



	})	
}






function form_attribute_options(){
	const options = {
	  required: 'boolean',
	  hidden: 'boolean',
	  disabled: 'boolean',
	  legal_language: 'legal_language',
	  min: 'integer',
	  max: 'integer',
	  step: 'integer',
	  list: 'list',
	  custom_label: 'string',
	  multiple_dropdown: 'list',
	  default_value: 'string',
	  accept: 'string',
		tooltip: 'string',
		maxlength: 'string'
	};
	return options

}

function addTextareaCounter(){
	let element = ''
	let parent = ''
	$('.textarea_counter').each(function(index, element) {
		element = $(element)
		parent = element.parent()
		let counter = '<span class="span_counter pull-right mt-1 text-muted">0/' + element.attr('maxlength') + '</span>'
		parent.append(counter)
		element.bind('input', function() {
			let element = $(this)
			let currentValue = element.val().length
			let maxLength = element.attr('maxlength')
			element.siblings('.span_counter').html(currentValue + '/' + maxLength)
		});
	});
}

	$(document).on('turbolinks:load',function () {
		addTextareaCounter()
	})