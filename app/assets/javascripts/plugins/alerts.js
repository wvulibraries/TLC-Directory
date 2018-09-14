// removes the parental bounding box when the alert exit is clicked.
// document.addEventListener('click', function(event){ 
//   if(event.target.className == 'exit-alert'){ 
//     var elm = event.target; 
//     elmToRemove = elm.parentNode; 
//     elmToRemove.parentNode.removeChild(elmToRemove);
//   }
// });

// Using Jquery instead 
$(document).on('click', '.exit-alert', function() {
  $(this).parent().remove();
});