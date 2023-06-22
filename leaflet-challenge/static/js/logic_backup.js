function createMap(QuakeLocations) {

    // Create the tile layer that will be the background of our map.
    let streetmap = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    });
  
  
    // Create a baseMaps object to hold the streetmap layer.
    let baseMaps = {
      "Street Map": streetmap
    };
  
    // Create an overlayMaps object to hold the bikeStations layer.
    let overlayMaps = {
      "Bike Stations": QuakeLocations
    };
  
    // Create the map object with options.
    let map = L.map("map", {
      center: [40.73, -74.0059],
      zoom: 12,
      layers: [streetmap, QuakeLocations]
    });
  
    // Create a layer control, and pass it baseMaps and overlayMaps. Add the layer control to the map.
    L.control.layers(baseMaps, overlayMaps, {
      collapsed: false
    }).addTo(map);
  }
  
  function createMarkers(response) {
  
    features = response.features;
    let QuakeMarkers = [];
  
    
  
    // Loop through the stations array.
    for (let index = 0; index < features.length; index++) {
      let feature = features[index];
      let location = feature.geometry;
  
      // For each station, create a marker, and bind a popup with the station's name.
      let QuakeCoords = [location.coordinates[1], location.coordinates[0]];
      let QuakeMarker = L.marker(QuakeCoords).bindPopup("<h3>" + features.properties.title + "<h3><h3>Place: " + features.properties.place + "</h3>");
  
      // Add the marker to the bikeMarkers array.
      QuakeMarkers.push(QuakeMarker);
    }
  
    // Create a layer group that's made from the bike markers array, and pass it to the createMap function.
    createMap(L.layerGroup(QuakeMarkers));
  }
  
  
  // Perform an API call to the Citi Bike API to get the station information. Call createMarkers when it completes.
  let url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.geojson";
  d3.json(url).then(createMarkers);