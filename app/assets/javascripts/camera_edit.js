$(document).on('turbolinks:load', function(){
  $('.edit-camera-caller').on('click', function(){
    console.log("here IN THE EDIT JS.ERB!")

    // The width and height of the captured photo. We will set the
    // width to the value defined here, but the height will be
    // calculated based on the aspect ratio of the input stream.

    var width = 320;    // We will scale the photo width to this
    var height = 0;     // This will be computed based on the input stream

    // |streaming| indicates whether or not we're currently streaming
    // video from the camera. Obviously, we start at false.

    var streaming = false;

    // The various HTML elements we need to configure or control. These
    // will be set by the startup() function.

    var video = null;
    var canvas = null;
    var photo = null;
    var startbutton = null;



    
    function searchForRearCamera() {
          var deferred = new $.Deferred();
          //MediaStreamTrack.getSources seams to be supported only by Chrome
          if (navigator.mediaDevices && navigator.mediaDevices.enumerateDevices) {
              navigator.mediaDevices.enumerateDevices()
                .then(function(sources){
                  var rearCameraIds = sources.filter(function (source) {
                      return (source.kind === 'videoinput' && source.label.includes('back'));
                  }).map(function (source) {
                      return source.deviceId;
                  });
                  if (rearCameraIds.length) {
                      deferred.resolve(rearCameraIds[0]);
                  } else {
                      deferred.resolve(null);
                  }
              });
          } else {
              deferred.resolve(null);
          }

          return deferred.promise();
      }


    

    function startup() {
      video = document.getElementById('video');
      canvas = document.getElementById('canvas');
      photo = document.getElementById('photo');
      startbutton = document.getElementById('startbutton');

      var videoSettings = {
        video: { optional: [] },
        audio: false
      };

      var rearCameraId = null;
      searchForRearCamera().done(function(id){
        rearCameraId = id;

      if (rearCameraId) {
          videoSettings.video.optional.push({
              sourceId: rearCameraId
          });
      }

      navigator.getMedia = ( navigator.getUserMedia ||
                             navigator.webkitGetUserMedia ||
                             navigator.mozGetUserMedia ||
                             navigator.msGetUserMedia);

      navigator.getMedia(
        videoSettings,
        function(stream) {
          if (navigator.mozGetUserMedia) {
            video.mozSrcObject = stream;
          } else {
            var vendorURL = window.URL || window.webkitURL;
            video.src = vendorURL.createObjectURL(stream);
          }
          video.play();
        },
        function(err) {
          console.log("An error occured! " + err);
        }
      );

      video.addEventListener('canplay', function(ev){
        if (!streaming) {
          height = video.videoHeight / (video.videoWidth/width);
        
          // Firefox currently has a bug where the height can't be read from
          // the video, so we will make assumptions if this happens.
        
          if (isNaN(height)) {
            height = width / (4/3);
          }
        
          video.setAttribute('width', width);
          video.setAttribute('height', height);
          canvas.setAttribute('width', width);
          canvas.setAttribute('height', height);
          streaming = true;
        }
      }, false);

      startbutton.addEventListener('click', function(ev){
        takepicture();
        ev.preventDefault();
      }, false);
      
      clearphoto();
      });
    }

    // Fill the photo with an indication that none has been
    // captured.

    function clearphoto() {
      var context = canvas.getContext('2d');
      context.fillStyle = "#AAA";
      context.fillRect(0, 0, canvas.width, canvas.height);

      var data = canvas.toDataURL('image/png');
      photo.setAttribute('src', data);
    }
    
    // Capture a photo by fetching the current contents of the video
    // and drawing it into a canvas, then converting that to a PNG
    // format data URL. By drawing it on an offscreen canvas and then
    // drawing that to the screen, we can change its size and/or apply
    // other changes before drawing it.

    function takepicture() {
      var context = canvas.getContext('2d');
      if (width && height) {
        canvas.width = width;
        canvas.height = height;
        context.drawImage(video, 0, 0, width, height);
        
        var data = canvas.toDataURL('image/png');
        // console.log(data);
        photo.setAttribute('src', data);

        var formdata = new FormData();
        formdata.append('picture', data)
        var oldText = $('#note_text')[0].value
        formdata.append('note[text]', oldText)
        formdata.append('authenticity_token', $('.edit_note').children()[2].value)
        $.ajax({
          method: 'PUT',
          data: formdata,
          url: "/notes/<%= @note.id %>",
          processData: false,
          contentType: false
        });

      } else {
        clearphoto();
      }
    }
    startup();
  })
})