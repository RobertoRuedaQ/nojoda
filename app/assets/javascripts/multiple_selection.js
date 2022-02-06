$(document).on('turbolinks:load',function () {
	createMultipleSelection();
	multiplePickListDropdown()
})

document.addEventListener("turbolinks:before-cache", function() {
	cleanMultipleSelection();
})


function createMultipleSelection(){
	$('.lumni-multiple-selection').bootstrapDualListbox({
	  nonSelectedListLabel: 'Non-selected',
	  selectedListLabel: 'Selected',
	  preserveSelectionOnMove: 'moved',
	  moveOnSelect: false
	});
}

function cleanMultipleSelection(){
	$(".lumni-multiple-selection").bootstrapDualListbox( 'destroy', true ).addClass('lumni-multiple-selection')
}


function multiplePickListDropdown(){
	  $('.lumni-multiple-dropdown').each(function() {
    $(this)
      .wrap('<div class="position-relative"></div>')
      .select2({
        dropdownParent: $(this).parent(),
        closeOnSelect: false
      });
  })

}