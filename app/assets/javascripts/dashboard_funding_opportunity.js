$(document).on('turbolinks:load',function () {



  $('.lumni-bar-chart').each(function(){
    var barsChart = new Chart(this.getContext("2d"), {
      type: 'bar',
      data: {
        labels: ['Italy', 'UK', 'USA', 'Germany', 'France', 'Japan'],
        datasets: [{
          label: '2010 customers #',
          data: [53, 99, 14, 10, 43, 27],
          borderWidth: 1,
          backgroundColor: 'rgba(205, 220, 57, 0.3)',
          borderColor: '#CDDC39'
        }, {
          label: '2014 customers #',
          data: [55, 74, 20, 90, 67, 97],
          borderWidth: 1,
          backgroundColor: 'rgba(103, 58, 183, 0.3)',
          borderColor: '#673AB7'
        }]
      },
      // Demo
      options: {
        responsive: true,
        maintainAspectRatio: false
      }
    });
  })



})




