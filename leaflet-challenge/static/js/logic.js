let myMap = L.map("map", {
    center: [-32.8, 117.9],
    zoom: 7
  });
  
  // Adding the tile layer
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(myMap);
  
  let url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.geojson";
  
  d3.json(url).then(function(response) {
  
    //console.log(response);
    features = response.features;
    let QuakeMarkers = [];
  
    //console.log(features);
  
    for (let i = 0; i < features.length; i++) {
  
      let location = features[i].geometry;
      if(location){
        
        let QuakeCoords = [location.coordinates[1], location.coordinates[0]];
        //console.log(features[i].properties.place)
        //console.log(features[i].properties.title)
        //console.log(features[i].properties.type)
        let QuakeMag = features[i].properties.mag;
        let QuakeDepth = location.coordinates[2];
        console.log(QuakeMag);
        console.log(QuakeDepth);
        //L.marker(QuakeCoords)
       // .bindPopup("<h3>Title:" + features[i].properties.title + "<h3><h3>Location: " + features[i].properties.place + "</h3>").addTo(myMap);
       if (QuakeMag < 6){
        var marker = L.circleMarker(QuakeCoords, {color: "green", weight: 1});
        marker.setRadius(QuakeMag);
        marker.bindPopup("<h3>Title:" + features[i].properties.title + "<h3><h3>Location: " + features[i].properties.place + "</h3>")
        marker.addTo(myMap);
       } else {
        var marker = L.circleMarker(QuakeCoords, {color: "red", weight: 1});
      marker.setRadius(QuakeMag);
      marker.bindPopup("<h3>Title:" + features[i].properties.title + "<h3><h3>Location: " + features[i].properties.place + "</h3>")
      marker.addTo(myMap);
       }
      
      

       
    
        //QuakeMarkers.push(QuakeMarker)
      }
    
    }
    
  });

  //var circle = L.circle([QuakeCoords], {
  //  color: 'red',
  //  fillColor: '#f03',
   // fillOpacity: QuakeDepth,
   // radius: QuakeMag
//}).addTo(mymap);
//  var marker = L.circleMarker(position, {color: '#000', weight: 1});
//marker.setRadius(4);
//marker.addTo(that.map);
