var slider = document.getElementById('slider');
var output = document.getElementById('slider-output');

function daysToDate(days) {
  var date = new Date(1970, 0, 1); // Unix epoch
  date.setDate(date.getDate() + parseInt(days));
  return date.toISOString().split('T')[0]; // Format as YYYY-MM-DD
}

slider.oninput = function() {
  output.value = daysToDate(this.value);
}

mapboxgl.accessToken = document.querySelector('body').getAttribute('data-mapbox-token');
var mapbox_slider = new mapboxgl.Map({
  container: 'mapbox_slider',
  style: 'mapbox://styles/mapbox/streets-v12',
  center: [-87.637505, 41.879138],
  zoom: 9,
});

// Show a memory based on the slider value
function showMemory() {
  let date = document.getElementById('slider-output').value;
  let memories = document.querySelectorAll('.memory');
  memories.forEach(memory => {
    const memoryDate = memory.getAttribute('data-date');
    if (memoryDate === date) {
      memory.style.display = 'block';
    } else {
      memory.style.display = 'none';
    }
  });
}
