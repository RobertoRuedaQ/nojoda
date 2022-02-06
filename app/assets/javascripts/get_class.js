function get_class(name,element_number){
	var targetClass = "[class*='" + name +"']"
	var classNum = ''

$( targetClass ).each ( function () {
    var elClasses = $( this ).attr ( 'class' ).split ( ' ' );

    for ( var index in elClasses ) {

        if ( elClasses[index].match( RegExp(name + '-*') ) ) {
            classNum = elClasses[index].split ( '-' )[element_number];
            break;
        }
    }

} );
	return(classNum);

}