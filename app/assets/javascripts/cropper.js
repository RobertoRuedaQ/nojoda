$(document).on('turbolinks:load',function () {

  $('[data-toggle="cropper-tooltip"]').tooltip({ container: 'body' });

  var URL = window.URL || window.webkitURL;
  var $image = $('#cropper-image');
  var $download = $('#cropper-download');
  var options = {
    aspectRatio: 16 / 16,
    preview: '.cropper-preview'
  };

  var originalImageURL = $image.attr('src');
  var uploadedImageURL;


  // Cropper
  $image.cropper(options);

  // IE10 fix
  if (typeof document.documentMode === 'number' && document.documentMode < 11) {
    options = $.extend({}, options, {zoomOnWheel: false});
    setTimeout(function() {
      $image.cropper('destroy').cropper(options);
    }, 1000);
  }

  // Buttons
  if (!$.isFunction(document.createElement('canvas').getContext)) {
    $('button[data-method="getCroppedCanvas"]').prop('disabled', true);
  }
  if (!$.isFunction(document.createElement('canvas').getContext)) {
    $('button[data-method="aws"]').prop('disabled', true);
  }
  if (typeof document.createElement('cropper').style.transition === 'undefined') {
    $('button[data-method="rotate"]').prop('disabled', true);
    $('button[data-method="scale"]').prop('disabled', true);
  }


  // Download
  if (typeof $download === 'undefined') {
    if (typeof $download[0].download === 'undefined') {
      $download.addClass('disabled');
    }
  }


  // Methods
  $('.cropper-buttons, .cropper-set').on('click', '[data-method]', function () {
    var $this = $(this);
    var data = $this.data();
    var result;



    if ($this.prop('disabled') || $this.hasClass('disabled')) {
      return;
    }

    if ($image.data('cropper') && data.method) {
      data = $.extend({}, data); // Clone a new one

      if (data.method === 'rotate') {
        $image.cropper('clear');
      }

      result = $image.cropper(data.method, data.option, data.secondOption);

      if (data.method === 'rotate') {
        $image.cropper('crop');
      }

      switch (data.method) {
        case 'scaleX':
        case 'scaleY':
          $(this).data('option', -data.option);
          break;

        case 'getCroppedCanvas':
          if (result) {

            // Bootstrap's Modal
            $('#cropper-getCroppedCanvasModal').modal().find('.modal-body').html(result);

            if (!$download.hasClass('disabled')) {
              $download.attr('href', result.toDataURL('image/jpeg'));
            }
          }

          break;

        case 'avatar':
          $('.spinner').show();

          hideEditor();

          result = $image.cropper('getCroppedCanvas', data.option, data.secondOption);

          var ImageURL = result.toDataURL('image/jpeg');
          // Split the base64 string in data and contentType
          var block = ImageURL.split(";");
          // Get the content type of the image
          var contentType = block[0].split(":")[1];// In this case "image/gif"
          // get the real base64 content of the file
          var realData = block[1].split(",")[1];// In this case "R0lGODlhPQBEAPeoAJosM...."

          // Convert it to a blob to upload
          var blob = b64toBlob(realData, contentType);

          // Create a FormData and append the file with "image" as parameter name
          var formDataToUpload = new FormData();
          formDataToUpload.append("image", blob);



          $.ajax({
              url: "/profiles/1" + "?&authenticity_token=" + $('#sense').val(),
              data: formDataToUpload,// Add as Data the Previously create formData
              type:"PUT",
              contentType:false,
              processData:false,
              cache:false,
              dataType:"json", // Change this according to your response from the server.
              error:function(err){
              },
              success:function(data){
              },
              complete:function(data){
                location.reload();

              }
          });




        break;

        case 'destroy':
          if (uploadedImageURL) {
            URL.revokeObjectURL(uploadedImageURL);
            uploadedImageURL = '';
            $image.attr('src', originalImageURL);
          }

          break;
      }
    }
  });

  // Import image
  var $inputImage = $('#cropper-inputImage');

  if (URL) {
    $inputImage.change(function () {
      var files = this.files;
      var file;

      if (!$image.data('cropper')) {
        return;
      }

      if (files && files.length) {
        file = files[0];

        if (/^image\/\w+$/.test(file.type)) {
          if (uploadedImageURL) {
            URL.revokeObjectURL(uploadedImageURL);
          }

          uploadedImageURL = URL.createObjectURL(file);
          $image.cropper('destroy').attr('src', uploadedImageURL).cropper(options);
          $inputImage.val('');
        } else {
          window.alert('Please choose an image file.');
        }
      }


      $('#imageEditor').show();

    });
  } else {
    $inputImage.prop('disabled', true).parent().addClass('disabled');
  }

});