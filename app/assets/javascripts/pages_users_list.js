$(function() {

  var isRtl = $('body').attr('dir') === 'rtl' || $('html').attr('dir') === 'rtl';

  var roles = {
    1: 'User',
    2: 'Author',
    3: 'Staff',
    4: 'Admin'
  };

  var statuses = {
    1: ['Active', 'success'],
    2: ['Banned', 'danger'],
    3: ['Deleted', 'default']
  };



  // Filters

  $('#user-list-latest-activity').daterangepicker({
      opens: isRtl ? 'right' : 'left',
      autoUpdateInput: false,
      locale: {
        cancelLabel: 'Clear'
      }
  });

  $('#user-list-latest-activity').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
  });

  $('#user-list-latest-activity').on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
  });

});
