$(document).on('turbolinks:load',function () {

	if( $('.project-body').length > 0){
		setAllSortableTemplate()

		$('[id^=edit_task]').on( "click", function(){
			path = "/project_tasks/" + this.id.split('-').pop() + "/edit_task"
			lumniGet(path,'')
		})


	}


})

function sortableTemplateHash(){

return {
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
				storeNewProjectOrder(evt.to.id)
			}else{
				storeNewProjectOrder(evt.to.id)
				storeNewProjectOrder(evt.from.id)
			}
		}
	}
}


function storeNewTemplatetOrder(targetElement){
	sortable = Sortable.create(document.getElementById(targetElement));
	order = sortable.toArray()

	if(order.length > 0){
		var newOrder = ''
		for(i=0;i<order.length;i++){
			newOrder += 'sort[]=' + order[i].split('-').pop() + '&'
			model = order[i].split('-')[0]
		}
		newOrder += 'model=' + model + '&card=' + targetElement.split('-').pop()
		$.post('/projects/sort',newOrder)
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
		sortableHash()
		);
}

function setAllSortableTemplate(){
		targetSortable = $('.sortable_container')
		for(i=0;i<targetSortable.length;i++){
			tempId = targetSortable[i].id
			setSortableProject(tempId)

		}
}


