

$(document).on('turbolinks:load',function() {



	if($('.datatables-list').length > 0){
		createDataTables();
	}




})
document.addEventListener("turbolinks:before-cache", function() {
	if($('.datatables-list').length > 0){
		cleanDataTables()
	}
})

var datatable_es = {
    "sProcessing":     "Procesando...",
    "sLengthMenu":     "Mostrar _MENU_ registros",
    "sZeroRecords":    "No se encontraron resultados",
    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix":    "",
    "sSearch":         "Buscar:",
    "sUrl":            "",
    "sInfoThousands":  ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    }
}

var datatable_en = {
    "sEmptyTable":     "No data available in table",
    "sInfo":           "Showing _START_ to _END_ of _TOTAL_ entries",
    "sInfoEmpty":      "Showing 0 to 0 of 0 entries",
    "sInfoFiltered":   "(filtered from _MAX_ total entries)",
    "sInfoPostFix":    "",
    "sInfoThousands":  ",",
    "sLengthMenu":     "Show _MENU_ entries",
    "sLoadingRecords": "Loading...",
    "sProcessing":     "Processing...",
    "sSearch":         "Search:",
    "sZeroRecords":    "No matching records found",
    "oPaginate": {
        "sFirst":    "First",
        "sLast":     "Last",
        "sNext":     "Next",
        "sPrevious": "Previous"
    },
    "oAria": {
        "sSortAscending":  ": activate to sort column ascending",
        "sSortDescending": ": activate to sort column descending"
    }
}

function target_datatable_language(locale){
	if(locale == 'es'){
		result = datatable_es
	}else{
		result = datatable_en
	}
	return result
}

function createDataTables(){
	for(i=0;i < $('.datatables-list').length;i++){
		target_id = '#' + $('.datatables-list')[i].id;
	  $(target_id).dataTable({
            "language": target_datatable_language($('#js-lumni-language').attr('locale'))
	  	});
	}
}

function cleanDataTables(){
	for(i=0;i < $('.datatables-list').length;i++){
		target_id = '#' + $('.datatables-list')[i].id;
	  tabletodestroy = $(target_id).dataTable();
	  tabletodestroy.fnDestroy()
	}
}