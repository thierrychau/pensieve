// initializeMap, getDataFromHtml, and mapConfig are all functions to set up the map.
function initializeMap(containerId, config) {
  const token = document.querySelector('body').getAttribute('data-mapbox-token');
  mapboxgl.accessToken = token;
  return new mapboxgl.Map({
    container: containerId,
    style: config.style,
    center: config.center,
    zoom: config.zoom,
  });
};

function getDataFromHtml(data_label) {
  return $('body').data(data_label);
};

function mapConfig(coordinates) {
  return {
    style: 'mapbox://styles/mapbox/streets-v12',
    center: coordinates,
    zoom: 9,
  };
};

// Add a source and layer to a map
function addSourceAndLayer(map) {
  const geojsonData = JSON.parse(document.querySelector('body').getAttribute('data-geojson'));

  if (!map.getSource('points')) {
    map.addSource('points', {
      'type': 'geojson',
      'data': geojsonData
    });
  }

  if (!map.getLayer('circle')) {
    map.addLayer({
      'id': 'circle',
      'type': 'circle',
      'source': 'points',
      'paint': {
        'circle-color': '#4264fb',
        'circle-radius': 8,
        'circle-stroke-width': 2,
        'circle-stroke-color': '#ffffff'
      }
    });
  }
};

// Add a click listener to the map and call the handler function
function addMapClickListener(map, handler) {
  map.on('click', 'circle', (e) => handler(e, map));
  map.on('mouseenter', 'circle', () => {
    map.getCanvas().style.cursor = 'pointer';
    // showPopup(lngLat, map, title, date, description); // to do: add popup on hover
    });
  map.on('mouseleave', 'circle', () => {
    map.getCanvas().style.cursor = '';
    });
};


// Show a pop up with the memory details
function showPopup(lngLat, map, title, date, description) {
  new mapboxgl.Popup()
    .setLngLat(lngLat)
    .setHTML(`<h6>${title}</h6><p>${date}</p><p>${description}</p>`)
    .addTo(map);
}

// Center the map on the coordinates of any clicked circle from the 'circle' layer.
function handleMapClick(e, map) {
  map.flyTo({
    center: e.features[0].geometry.coordinates
  });

  const coordinates = e.features[0].geometry.coordinates.slice();
  const description = e.features[0].properties.description;
  const title = e.features[0].properties.title;
  const date = e.features[0].properties.date;

  // Ensure that if the map is zoomed out such that multiple
  // copies of the feature are visible, the popup appears
  // over the copy being pointed to.
  while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
    coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
  };

  showPopup(coordinates, map, title, date, description);
};

// Adding typical map controls
function addControls(map) {
  map.addControl(new mapboxgl.NavigationControl());
  map.addControl(new mapboxgl.GeolocateControl());
  map.addControl(new mapboxgl.ScaleControl());
};

// Adding a layer switcher
function addLayerSwitcher(map, data_menu) {
  let layerList = document.getElementById(getDataFromHtml(data_menu));
  let inputs = layerList.getElementsByTagName('input');
  for (const input of inputs) {
    input.onclick = (layer) => {
      const layerId = layer.target.id;
      map.setStyle('mapbox://styles/mapbox/' + layerId);
    };
  }
};

// Updating form fields from geocoder response
function updateFormFields(e) {
  document.getElementById('memory_location').value = e.result.place_name;
  document.getElementById('memory_lng').value = e.result.geometry.coordinates[0];
  document.getElementById('memory_lat').value = e.result.geometry.coordinates[1];
  const placeObject = e.result.context.find(c => c.id.startsWith('place'));
  const placeName = placeObject?.text || e.result.text || '';
  document.getElementById('memory_place').value = placeName;
  const countryObject = e.result.context.find(c => c.id.startsWith('country'));
  const countryName = countryObject?.text || '';
  document.getElementById('memory_country').value = countryName;
};

// Resize upon modal show
function resizeMap(data_label) {
  $("[id^='add']").on('shown.bs.modal', function () {
    let target_map = window[data_label];
    if (target_map && typeof target_map.resize === 'function') {
      target_map.resize();
    } else {
      console.log('Map not found or resize is not a function');
    }
  });
};

// Creates a draggable marker at the geocoder result location
function handleGeocoderResult(e, marker, mapbox) {
  // Save the JSON response
  geocoderResult = e.result;
  console.log(geocoderResult);
  // If a marker already exists, remove it
  if (marker) {
    marker.remove();
  }
  // Create a new marker at the result location
  return createDraggableMarker(e.result.geometry.coordinates, mapbox);
};

// Creates a draggable marker at the given coordinates
function createDraggableMarker(lngLat, mapbox) {
  let marker = new mapboxgl.Marker({
    draggable: true
  })
  .setLngLat(lngLat)
  .addTo(mapbox);
  marker.on('dragend', function() {
    const newLngLat = marker.getLngLat();
    // console.log('Marker coordinates:', newLngLat); // log coordinates to console on dragend
    document.getElementById('memory_lng').value = parseFloat(newLngLat.lng.toFixed(8));
    document.getElementById('memory_lat').value = parseFloat(newLngLat.lat.toFixed(8));
  });
  return marker;
};

// Get coordinates from form fields
function getCoordinatesFromInput() {
  var lngInput = document.querySelector('input[data-lng]');
  var latInput = document.querySelector('input[data-lat]');
  var lng = lngInput ? lngInput.getAttribute('data-lng') : null;
  var lat = latInput ? latInput.getAttribute('data-lat') : null;
  return { lng, lat };
};

// Create a marker if coordinates exist
function createMarkerIfCoordinatesExist(coordinates, mapbox_form) {
  if (coordinates.lat && coordinates.lng) {
    return createDraggableMarker([coordinates.lng, coordinates.lat], mapbox_form);
  }
  return null;
};
