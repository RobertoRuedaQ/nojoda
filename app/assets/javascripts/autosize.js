$(document).on('turbolinks:load',function () {
	if($('.autosize').length > 0){
		setAutosize();
	}
})

function setAutosize() {
	for(i=0;i<$('.autosize').length;i++){
		targetId = '#' + $('.autosize')[i].id
		  autosize($(targetId));
	}
}
