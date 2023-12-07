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
  let map = initializeMap(getMapContainerId(mapId), mapConfig(coordinates));
  map.on('load', function () {
    addSourceAndLayer(map);
    addMapClickListener(map, handleMapClick);
  });
};

function addControls(map) {
  map.addControl(new mapboxgl.NavigationControl());
  map.addControl(new mapboxgl.GeolocateControl());
  map.addControl(new mapboxgl.ScaleControl());
}

function addLayerSwitcher(map) {
  let layerList = document.getElementById('menu');
  let inputs = layerList.getElementsByTagName('input');
  for (const input of inputs) {
    input.onclick = (layer) => {
      const layerId = layer.target.id;
      map.setStyle('mapbox://styles/mapbox/' + layerId);
    };
  }
}

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
}

function initializeMapSearch(mapId, coordinates) {
  let map = initializeMap(getMapContainerId(mapId), mapConfig(coordinates));
  let geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl,
  });
  map.addControl(geocoder);
  window[mapId] = map;
  map.on('load', function () {
    addControls(map);
    addLayerSwitcher(map);
  });
  console.log("before");

  geocoder.on('result', function (e) {
    console.log("hello");
    updateFormFields(e);
  });
};

function resizeMap(mapId) {
  $("[id^='add']").on('shown.bs.modal', function () {
    let target_map = window[mapId];
    if (target_map && typeof target_map.resize === 'function') {
      target_map.resize();
    } else {
      console.log('Map not found or resize is not a function');
    }
  });
};
