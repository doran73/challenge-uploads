let samples_display = [];
let samples_meta = [];
let samples_name = [];
let samples_results = [];

const url = 'https://2u-data-curriculum-team.s3.amazonaws.com/dataviz-classroom/v1.1/14-Interactive-Web-Visualizations/02-Homework/samples.json'
let d3JSON = d3.json(url)
let d3Output = d3.json(url).then(function(data){
       let sampleNames = data.names;
       let sampleMetadata = data.metadata; 
       let samples = data.samples;
       let selector = d3.select("#selDataset");
       samples_display.push(samples)
       //samples_meta.push(sampleMetadata)
       let resultsArray = samples.filter(sampleObj => sampleObj.id);
       let metaArray = sampleMetadata.filter(obj => obj.id);

       
       
       
       

       
       console.log(metaArray); 
       //get the first element of the array
       for (let i = 0; i < resultsArray.length; i++) {
        let otu_labels = resultsArray[i].otu_labels
        let otu_ids = resultsArray[i].otu_ids; 
        let value_samples = resultsArray[i].sample_values;
        selector.append("option").text(resultsArray[i].id);
        selector.append("option").property("value",resultsArray[i].id);
        samples_meta.push(metaArray[i]);
        samples_results.push(resultsArray[i]);
   
        //console.log(resultsArray[i].id)
        //console.log(value_samples)
       
    let barData = [
      {
          x:value_samples.slice(0,10).reverse(),
          y:otu_ids.slice(0,10).reverse() ,
          text: otu_labels.slice(0,10),
          type: 'bar',
          orientation : 'h'
          
      }
  ]

  let barLayout = {
      title: "Bar Graph",
  }

  Plotly.newPlot("bar", barData, barLayout)
          }
        
      
  
    
 });

 function optionChanged(result) {
    let add_demo = [];
  console.log(result)
  for (let i = 0; i < samples_meta.length; i++) {

   // console.log(samples_meta[i].age);

   if (samples_meta[i].id == result)
    {
     // console.log(samples_meta[i].age);
     //var my_name = 'John';
     // var s = `hello ${my_name}, how are you doing`;

     let demo_id = `ID: ${samples_meta[i].id}`;
     add_demo.push(demo_id);
     let demo_age = `Age: ${samples_meta[i].age}`;
     add_demo.push(demo_age);
     let demo_ethnic = `Ethnicity: ${samples_meta[i].ethnicity}`;
     add_demo.push(demo_ethnic);
     let demo_gender = `Gender: ${samples_meta[i].gender}`;
     add_demo.push(demo_gender);
     let demo_location = `Location: ${samples_meta[i].location}`;
     add_demo.push(demo_location);
     let demo_bbtype = `BBType ${samples_meta[i].bbtype}`;
     add_demo.push(demo_bbtype);
     let demo_wfreq = `Wfreg: ${samples_meta[i].wfreq}`;
     add_demo.push(demo_wfreq);
     //<h3 class="panel-title">Demographic Info</h3>
     let d3Demo = d3.select("#output");
     d3Demo.text(add_demo);
     //send ID to function to populate bar chart based on ID selected
     

    
     


    }

  }
 };