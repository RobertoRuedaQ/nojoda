$(document).on('turbolinks:load',function () {

	if( $('.project-list-sortable').length > 0){
		setProjectListBehavior()
	}
})


function setProjectListBehavior(){
	var options = {
	  valueNames: ['read_check','title','project_card_id','start_date','deadline','created_by_id','cached_project_title','responsable_id']
	};

	var userList = new List('projectListContainer', options);

	setAllSortableListProject()
	$('[id^=project_card_list_]').on('change',function(){
		target_id = this.id.split('_').pop()
		new_card = $(this).find("option:selected").val()

		params = 'card=' + new_card 
		lumniPost('/project_tasks/'+ target_id + '/update_card',params)
	})

}


function sortableProjectListHash(){

return {
		handle: '.lumni-handle',
		filter: '.locked',
		animation: 150,
		group: 'project-pipeline',
				// Element dragging ended
		onEnd: function (/**Event*/evt) {
			var itemEl = evt.item;  // dragged HTMLElement
			evt.to;    // target list
			evt.from;  // previous list
			evt.oldIndex;  // element's old index within old parent
			evt.newIndex;  // element's new index within new parent
			if(evt.to.id == evt.from.id){
				storeNewProjectListOrder(evt.to.id)
			}else{
				storeNewProjectListOrder(evt.to.id)
				storeNewProjectListOrder(evt.from.id)
			}
		}


	}




}


function storeNewProjectListOrder(targetElement){
	sortable = Sortable.create(document.getElementById(targetElement),sortableProjectListHash());
	order = sortable.toArray()

	if(order.length > 0){
		var newOrder = ''
		for(i=0;i<order.length;i++){
			newOrder += 'sort[]=' + order[i].split('-').pop() + '&'
			model = order[i].split('-')[0]
		}
		newOrder += 'model=' + model + '&card=' + targetElement.split('-').pop()

		// $.post('/projects/sort',newOrder)
		//   .done(function() {
		//   })
		//   .fail(function() {
		//   	location.reload();
		//   })
		//   .always(function() {
		//   });

	}

}



function setSortableListProject(targetElement){

	Sortable.create(document.getElementById(targetElement),
		sortableProjectListHash()
		);
}

function setAllSortableListProject(){
		targetSortable = $('.project-list-sortable')
		for(i=0;i<targetSortable.length;i++){
			tempId = targetSortable[i].id
			setSortableListProject(tempId)

		}
}

