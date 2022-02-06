$(document).on('turbolinks:load',function () {

	if( $('*[id*=sections_location_]').length > 0){
		setAllSortable()
		setArrowCollapse()
	}

	if($('#application_pending_info').length > 0){
		hide_finalize_questionnaire_button()
	}


})


function hide_finalize_questionnaire_button(){
	$('#review-finalize-review-button').hide()
}


function setArrowCollapse(){
		$('.lumni-collapser').on('click',function(){
			if($(this).children().attr('class') == 'ion ion-ios-arrow-down'){
				$(this).children().attr('class','ion ion-ios-arrow-up')
			}else{
				$(this).children().attr('class','ion ion-ios-arrow-down')
			}
		})
		$('.lumni-collapser').each(function(){
			$(this).removeClass('lumni-collapser')
		})
}


function setSortable(targetElement){
	Sortable.create(document.getElementById(targetElement), {	
		animation: 150,
		handle: '.handle',
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
					newOrder += 'sort[]=' + order[i].split('_').pop() + '&'
					model = order[i].split('_')[0]
				}
				newOrder += 'model=' + model

				$.post('/questionnaires/sort',newOrder)
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

function setAllSortable(){
		targetSortable = $('.sortable_container')
		for(i=0;i<targetSortable.length;i++){
			tempId = targetSortable[i].id
			setSortable(tempId)

		}
}