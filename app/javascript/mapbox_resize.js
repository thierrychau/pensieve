$("[id^='add']").on('shown.bs.modal', function () {
  var mapId = $('body').data('map-id');
  var map = window[mapId];
  map.resize();
});
