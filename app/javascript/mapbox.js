mapboxgl.accessToken = document.querySelector('body').getAttribute('data-mapbox-token');
var mapbox_memories = new mapboxgl.Map({
  container: 'mapbox',
  style: 'mapbox://styles/mapbox/streets-v12',
  center: [-87.637505, 41.879138],
  zoom: 9,
});
