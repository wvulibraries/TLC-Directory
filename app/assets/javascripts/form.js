var fieldId = 0;

function onClickAdd(sectionName) {
  var parentDiv = document.getElementById(sectionName);
  var cloneDiv = parentDiv.cloneNode(true);
  ++fieldId;
  cloneDiv.id += fieldId;
  cloneDiv.childNodes[1].name = cloneDiv.childNodes[1].name.replace("0", fieldId);
  console.log(cloneDiv.childNodes[1]);
  parentDiv.parentNode.insertBefore(cloneDiv, parentDiv.nextSibling);
}

function onClickRemove(sectionName, item) {
  console.log(item.parentNode.childNodes[1])
  var id = item.parentNode.id;
  console.log(id);
  if (sectionName == id){
    alert("The parent div cannot be removed.");
  }
  else {
    document.getElementById(id).remove();
  }
}

function addWebsiteField(currentItem) {
  //create Date object
  var date = new Date();

  //get number of milliseconds since midnight Jan 1, 1970
  //and use it for address key
  var mSec = date.getTime();

  var parentDiv = currentItem.parentNode;
  var cloneDiv = parentDiv.cloneNode(true);
  cloneDiv.id += mSec;

  //Replace 0 with milliseconds
  cloneDiv.childNodes[1].value = '';
  cloneDiv.childNodes[1].name = cloneDiv.childNodes[1].name.replace("0", mSec);
  cloneDiv.childNodes[3].value = '';
  cloneDiv.childNodes[3].name = cloneDiv.childNodes[3].name.replace("0", mSec);
  // cloneDiv.childNodes[5].value = '-';
  // cloneDiv.childNodes[5].setAttribute('onclick', "onClickRemove('website', this)");
  parentDiv.parentNode.insertBefore(cloneDiv, parentDiv.nextSibling);
}
