$(document).on('turbolinks:load',function () {

   $(".selectpicker").selectpicker({
      dropupAuto: false
   });



   if( $('.legal_dropdown').length > 0 ){
   		setLegalDocumentsDropdown()
   }





});

document.addEventListener("turbolinks:before-cache", function() {

$(".selectpicker").selectpicker( 'destroy', true ).addClass('selectpicker')
})


function setLegalDocumentsDropdown(){
   	$('.legal_dropdown').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue) {
   		if(previousValue != ''){
   			previousId = '#' + $(this)[0].id + previousValue
   			if(previousId.length > 3){
	   			$(previousId)[0].style.display = "none"
   			}
   		}
   		if($(this).val() != ''){
   			currentId = '#' + $(this)[0].id + $(this).val()
   			$(currentId)[0].style.display = "block"
   		}

	});
}