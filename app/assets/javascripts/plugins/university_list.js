// $(document).on('turbolinks:load ready', function(){
//   var sampleArray = [{id:0,text:'enhancement'}, {id:1,text:'bug'}
//                     ,{id:2,text:'duplicate'},{id:3,text:'invalid'}
//                     ,{id:4,text:'wontfix'}];
//
//   $('#university-list').select2({data: sampleArray});
// });

$(document).on('turbolinks:load ready', function(){
  $('#university-list').select2({
    width: 'resolve',
    ajax: {
      url: '/admin/universities.json',
      dataType: 'json',
      processResults: function (data) {
         console.log(data);
         return {
           results: data
         };
       }
     },
     placeholder: 'Select University'
    });
});

// $(document).on('turbolinks:load ready', function(){
//   $('#university-list').select2({
//     ajax: {
//       url: '/admin/universities.json',
//       results: function (data) {
//         console.log(data);
//         // Tranforms the top-level key of the response object from 'items' to 'results'
//         return {
//           results: data
//         };
//       }
//     }
//   });
// });

// $(document).on('turbolinks:load ready', function(){
//   var itemsArray = [];
//
//   $.getJSON('/admin/universities.json', function(data) {
//       //to do loop over items in array
//       for (i=0; i<data.length; ++i) {
//         itemsArray.push({id: data[i].id, text: data[i].name});
//       }
//   });
//   console.log(itemsArray);
//
//   $('#university-list').select2({data: itemsArray});
// });






// console.log(data);
// sampleArray.push({id: 5, text: data[0].name});
// sampleArray.push({id: 6, text: data[1].name});
//
// console.log(newArray);
// console.log(newArray.length);
// $('#university-list').select2({ data: newArray });

 // var itemsArray = [];
 //
 // $.getJSON('/admin/universities.json', function(data) {
 //     console.log(data[0]);
 //     //to do loop over items in array
 //     // for (i=0; i<data.length; ++i) {
 //     //   itemsArray.push({id: data[i].id, text: data[i].name});
 //     // }
 //     itemsArray = [ {id: data[0].id, text: data[0].name}, {id: data[1].id, text: data[1].name} ];
 // });
 // console.log(itemsArray);


// var data = $.getJSON('/admin/universities.json', function(data) {
//     return data;
    //console.log(data[0]);
    //to do loop over items in array
    // for (i=0; i<data.length; ++i) {
    //   itemsArray.push({id: data[i].id, text: data[i].name});
    // }

    //return sampleArray;

// $(document).on('turbolinks:load ready', function(){
//   $('#university-list').select2({
//     ajax: {
//       url: '/admin/universities.json',
//       data: function(data) {
//            console.log(data);
//       }
//     }
//   });
// });

// $.getJSON('/admin/universities.json', function(data) {
//     console.log(data);
// });

//   $("#university-list").select2({
//       ajax: {
//        url: "/admin/universities.json",
//        dataType: "json"
//    }
//   });
// });

// $.ajax({
// dataType: "json",
// url: "/admin/universities.json",
// data: data,
// success: success
