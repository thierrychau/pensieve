// initializeMap, getMapContainerId, and mapConfig are all functions to set up the map.

function initializeMap(containerId, config) {
  // Getting the token from the body data attributes
  const token = document.querySelector('body').getAttribute('data-mapbox-token');
  mapboxgl.accessToken = token;

  return new mapboxgl.Map({
    container: containerId,
    style: config.style,
    center: config.center,
    zoom: config.zoom,
  });
}

function getMapContainerId(mapId) {
  return $('body').data(mapId);
};

function mapConfig(coordinates) {
  return {
    style: 'mapbox://styles/mapbox/streets-v12',
    center: coordinates,
    zoom: 9,
  };
}

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
}

// Add a click listener to the map and call the handler function

function addMapClickListener(map, handler) {
  map.on('click', 'circle', (e) => handler(e, map));
  map.on('mouseenter', 'circle', () => {
    map.getCanvas().style.cursor = 'pointer';
    });
  map.on('mouseleave', 'circle', () => {
    map.getCanvas().style.cursor = '';
    });
};

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
  }

  new mapboxgl.Popup()
    .setLngLat(coordinates)
    .setHTML(`<h5>${title}</h5><p>${date}</p><p>${description}</p>`)
    .addTo(map);
};

// Initialize the map and add the source, layer, and click listener for all memories

function initializeMapAll(mapId, coordinates) {
  map = initializeMap(getMapContainerId(mapId), mapConfig(coordinates));
  map.on('load', function () {
    addSourceAndLayer(map);
    addMapClickListener(map, handleMapClick);
  });
};

function initializeMapSearch(mapId, coordinates) {
  map = initializeMap(getMapContainerId(mapId), mapConfig(coordinates));
  map.on('load', function () {
    addSourceAndLayer(map);
    addMapClickListener(map, handleMapClick);
  });
};
