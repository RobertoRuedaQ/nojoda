$(document).on('turbolinks:load',function () {
		readTaskCheckBox()

	if( $('.project-body').length > 0){
		setAllSortableProject()
		setSwitchBehavior()

		$('[id^=edit_task]').on( "click", function(){
			path = "/project_tasks/" + this.id.split('-').pop() + "/edit_task"
			lumniGet(path,'')
		})







		// if(!location.hash.includes('project-tab-')){
		// 	$('[id^=project-tab-button-kanvas-]').each(function(){
		// 		target_tab = 'kanvas'
		// 		target_id = this.id.split('-').pop()
		// 		fillProjectContainer(target_tab,target_id)
		// 	})
		// }else{
		// 	target_id = location.hash.split('-').pop()
		// 	target_tab = location.hash.split('-')[2]
		// 	fillProjectContainer(target_tab,target_id)
		// }



		// $('[id^=project-tab-button-]').on('click',function(){
		// 	target_id = this.id.split('-').pop()
		// 	target_tab = this.id.split('-')[3]
		// 	fillProjectContainer(target_tab,target_id)
		// })

	}


})

function fillProjectContainer(target_tab,target_id){
	showProjectLoader()	
	cleanProjectContainers()
	setProjectListContainer(target_tab,target_id)
}


function setProjectListContainer(tab,project_id){

	path = '/project_tasks/' + project_id + '/show_project_tab'
	params = 'tab=' + tab
	lumniPost(path,params)
}

function showProjectLoader(){
	$('.container-loader').each(function(){
		$(this).attr('hidden',false)
	})
}

function hideProjectLodader(){
	$('.container-loader').each(function(){
		$(this).attr('hidden',true)
	})
}

function cleanProjectContainers(){
	$('.project-container').each(function(){
		$(this).html('')
	})
}

function setSwitchBehavior(){


	$(".project-done-switch").on('change', function() {
		generalId = $(this)[0].id.split('_').pop().split('frontcheck')[0]
		buttonId = '#settings-' + generalId
		commentId = '#comments-checklist-' + generalId

		if($(this)[0].checked){
			$(this).closest('tr').addClass('bg-success text-white font-weight-bold')
			$(buttonId).addClass('text-white')
			$(commentId).addClass('text-white')

			$.post('/project_tasks/'+ generalId +'/done').fail(function () {location.reload();})
			  .done(function() {
			  })
			  .fail(function() {
			  	location.reload();
			  })
			  .always(function() {
			  });


		}else{
			$(this).closest('tr').removeClass('bg-success text-white font-weight-bold')
			$(buttonId).removeClass('text-white')
			$(commentId).removeClass('text-white')
			$.post('/project_tasks/'+ generalId +'/undone').fail(function () {location.reload();})
			  .done(function() {
			  })
			  .fail(function() {
			  	location.reload();
			  })
			  .always(function() {
			  });

		}

     

	})
}

function readTaskCheckBox(){
	$('.project-list-read').on('change',function(){

		target_id = this.id.split('frontcheck')[0].split('_').pop()
		value = $(this).prop('checked')

		if(value){
			path = '/project_tasks/'+ target_id +'/check_read_task'
		}else{
			path = '/project_tasks/'+ target_id +'/uncheck_read_task'
		}
		lumniPost(path,'')


	})
}

function sortableHash(){

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


function storeNewProjectOrder(targetElement){
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



function setSortableProject(targetElement){

	Sortable.create(document.getElementById(targetElement),
		sortableHash()
		);
}

function setAllSortableProject(){
		targetSortable = $('.sortable_container')
		for(i=0;i<targetSortable.length;i++){
			tempId = targetSortable[i].id
			setSortableProject(tempId)

		}
}

function selectFavoriteProject(){
	$('#deselect-favorite').attr('hidden',true)
	$('#select-favorite').attr('hidden',false)
	targetProject =location.pathname.split('/')[2] 
	targetPath = '/projects/' + targetProject +'/select_favorite'
	lumniPost(targetPath,'')
}

function deselectFavoriteProject(){
	$('#deselect-favorite').attr('hidden',false)
	$('#select-favorite').attr('hidden',true)
	targetProject =location.pathname.split('/')[2] 
	targetPath = '/projects/' + targetProject +'/deselect_favorite'
	lumniPost(targetPath,'')
}