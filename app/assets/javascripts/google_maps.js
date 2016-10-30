function initMap() {
	lat = parseFloat($('#lat').html());
	lng = parseFloat($('#lng').html());
	address = parseFloat($('#add').html());
    // Create a map object and specify the DOM element for display.
    var map = new google.maps.Map(document.getElementById('map'), {
    	center: {lat: lat, lng: lng},
      	scrollwheel: false,
      	zoom: 16
    });

    var marker = new google.maps.Marker({
      	map: map,
      	position: {lat: lat, lng: lng},
      	title: address
    });
}
