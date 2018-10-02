function onClickRemove(currentItem) {
  var recordId = currentItem.parentNode.childNodes[1].value;
  var divId = currentItem.parentNode.id;
  if (recordId == '') {
    document.getElementById(divId).remove();
  }
  else {
    currentItem.parentNode.style.display = "none";
    var children = currentItem.parentNode.childNodes;
    children.forEach(function(item) {
      if ('name' in item) {
        if (item.type == 'hidden' && item.name.includes('_destroy') ) {
          //set _destroy to 1
          item.value = '1';
      }}
    });
  }
}

function addField(currentItem) {
  //console.log(document.getElementById('button'));

  //create Date object
  var date = new Date();

  //get number of milliseconds since midnight Jan 1, 1970
  //and use it for address key
  var mSec = date.getTime();

  var parentDiv = currentItem.parentNode;
  var cloneDiv = parentDiv.cloneNode(true);
  cloneDiv.id += mSec;

  var children = cloneDiv.childNodes;
  children.forEach(function(item) {
    if ('name' in item) {
      if (item.name == 'button') {
        item.value = '-';
        item.setAttribute('onclick', "onClickRemove(this)");
      }
      else {
        //Replace 0 with milliseconds
        item.name = item.name.replace("0", mSec);
        item.value = '';
      }
    }
  });

  parentDiv.parentNode.insertBefore(cloneDiv, parentDiv);
}
