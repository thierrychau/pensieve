mapboxgl.accessToken = document.querySelector('body').getAttribute('data-mapbox-token');

// Initialize the mapbox_form.
// const coordinates = document.getElementById('coordinates');
var mapbox_form = new mapboxgl.Map({
    container: 'mapbox_form',
    style: 'mapbox://styles/mapbox/streets-v12',
    center: [-87.637505, 41.879138],
    zoom:
});

  // Add the search box to the mapbox_form.
  var geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl,
  });

  mapbox_form.addControl(geocoder);
  mapbox_form.addControl(new mapboxgl.NavigationControl());
  mapbox_form.addControl(new mapboxgl.GeolocateControl());
  mapbox_form.addControl(new mapboxgl.ScaleControl());
  
  var layerList = document.getElementById('menu');
  var inputs = layerList.getElementsByTagName('input');
  for (const input of inputs) {
  input.onclick = (layer) => {
  const layerId = layer.target.id;
  mapbox_form.setStyle('mapbox://styles/mapbox/' + layerId);
  };
  }

// Function to create a draggable marker
  function createDraggableMarker(lngLat, mapbox_form) {
    var marker = new mapboxgl.Marker({
      draggable: true
    })
    .setLngLat(lngLat)
    .addTo(mapbox_form);
    marker.on('dragend', function() {
      const newLngLat = marker.getLngLat();
      console.log('Marker coordinates:', newLngLat);
      document.getElementById('memory_lng').value = parseFloat(newLngLat.lng.toFixed(8));
      document.getElementById('memory_lat').value = parseFloat(newLngLat.lat.toFixed(8));
    });
    return marker;
  }

  
  var marker = null;
  geocoder.on('result', function(e) {
     // Save the JSON response
    geocoderResult = e.result;
    console.log(geocoderResult);
    // If a marker already exists, remove it
    if (marker) {
      marker.remove();
    }
    // Create a new marker at the result location
    marker = createDraggableMarker(e.result.geometry.coordinates, mapbox_form);
  });

// If the memory has a location, create a marker for it
var lngInput = document.querySelector('input[data-lng]');
var latInput = document.querySelector('input[data-lat]');
var lng = lngInput ? lngInput.getAttribute('data-lng') : null;
var lat = latInput ? latInput.getAttribute('data-lat') : null;
if (lat && lng) {
  marker = createDraggableMarker([lng, lat], mapbox_form);
}
  
// Copy the address to the hidden input
geocoder.on('result', function(e) {
  document.getElementById('memory_location').value = e.result.place_name;
  document.getElementById('memory_lng').value = e.result.geometry.coordinates[0];
  document.getElementById('memory_lat').value = e.result.geometry.coordinates[1];
  const placeObject = e.result.context.find(c => c.id.startsWith('place'));
  const placeName = placeObject?.text || e.result.text || '';
  document.getElementById('memory_place').value = placeName;
  const countryObject = e.result.context.find(c => c.id.startsWith('country'));
  const countryName = countryObject?.text || '';
  document.getElementById('memory_country').value = countryName;
});
