  var map = new google.maps.Map(document.getElementById('mapcanvas'));
  var geocoder = new GClientGeocoder();

  function showAddress(address) {
    geocoder.getLatLng(
      address,
      function(point) {
        if (!point) {
          alert(address + " not found");
        } else {
          map.setCenter(point, 13);
          var marker = new GMarker(point);
          map.addOverlay(marker);

          // As this is user-generated content, we display it as
          // text rather than HTML to reduce XSS vulnerabilities.
          marker.openInfoWindow(document.createTextNode(address));
        }
      }
    );
  }
